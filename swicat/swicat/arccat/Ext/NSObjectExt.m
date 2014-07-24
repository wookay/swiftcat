//
//  NSObjectExt.m
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "NSObjectExt.h"
#import "NSClassExt.h"
#import "NSStringExt.h"
#import "NSArrayExt.h"
#import "objc/runtime.h"
#import "objc/message.h"
#import "Logger.h"
#import "NSValueExt.h"

@implementation NSObject (Ext)

-(NSString*) className {
    return NSStringFromClass([self class]);
}

-(NSArray*) Methods {
    return [NSClassExt methodsForClass:[self class]];
}

-(NSArray*) classMethods {
    Class klass = [self class];
    Class targetClass = object_getClass(klass);
    return [NSClassExt methodsForClass:targetClass];
}

-(NSArray*) getters {
    NSMutableArray* ary = [NSMutableArray array];
    int getterTypeMax = 0;
    int getterNameMax = 0;
    for (Class targetClass in @[self.class, self.superclass]) {
        unsigned int count;
        Method *methods = class_copyMethodList(targetClass, &count);
        for (unsigned int idx = 0; idx < count; ++idx) {
            Method setterMethod = methods[idx];
            SEL setterSel = method_getName(setterMethod);
            NSString* setterMethodName = NSStringFromSelector(setterSel);
//            log_info(@"setterMethodName %@", setterMethodName);
            if ([setterMethodName hasPrefix:@"set"] && (setterMethodName.length >= 5)) {
                NSString* getterMethodName = SWF(@"%@%@",
                                                 [[setterMethodName slice:3 :1] lowercaseString],
                                                 [setterMethodName slice:4 :(int)setterMethodName.length-5]);
                SEL getterSel = NSSelectorFromString(getterMethodName);
                if ([self respondsToSelector:getterSel]) {
                    Method getterMethod = class_getInstanceMethod(targetClass, getterSel);
//                    log_info(@"s %@ g %@", setterMethodName, getterMethodName);
                    NSString* valueString = [self getValueStringForProperty:getterMethodName];
                    char* getterType = method_copyReturnType(getterMethod);
                    NSString* getterTypeString = TypeEncodingDescription(getterType);
                    [ary addObject:@[getterMethodName, getterTypeString, valueString]];
                    getterTypeMax = MAX(getterTypeMax, (int)getterTypeString.length);
                    getterNameMax = MAX(getterNameMax, (int)getterMethodName.length);
                }
            }
        }
        free(methods);
    }
    NSMutableArray* ret = [NSMutableArray array];
	for (NSArray* trio in [ary sortedArrayUsingFunction:sortByFirstObjectComparator context:nil]) {
		[ret addObject:SWF(@"%@ %@ %@", [trio.second Ljust:getterTypeMax], [trio.First Ljust:getterNameMax], trio.third)];
	}
	return ret;
}

-(NSString*) getValueStringForProperty:(NSString*)propertyName {
    SEL sel = NSSelectorFromString(propertyName);
	if (! [self respondsToSelector:sel]) {
        SEL isSel = NSSelectorFromString(SWF(@"is%@%@",
                                             [[propertyName slice:0 :1] uppercaseString],
                                             [propertyName slice:1 backward:-1]));
        if ([self respondsToSelector:isSel]) {
            sel = isSel;
        } else {
            return @"-";
        }
	}
    NSMethodSignature* sig = [self methodSignatureForSelector:sel];
	const char* aTypeDescription = [sig methodReturnType];
    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setSelector:sel];
    [invocation invokeWithTarget:self];
    switch (*aTypeDescription) {
        case _C_VOID:
            break;
        case _C_BOOL: {
                BOOL value;
                [invocation getReturnValue:&value];
                return [NSValue stringWithAny:&value objCType:aTypeDescription];
            }
            break;
        case _C_CHR: {
                char value;
                [invocation getReturnValue:&value];
                return [NSValue stringWithAny:&value objCType:aTypeDescription];
            }
            break;
        case _C_DBL: {
                double value;
                [invocation getReturnValue:&value];
                return [NSValue stringWithAny:&value objCType:aTypeDescription];
            }
            break;
        case _C_INT: {
                int value;
                [invocation getReturnValue:&value];
                return [NSValue stringWithAny:&value objCType:aTypeDescription];
            }
            break;
        case _C_UINT: {
                unsigned int value;
                [invocation getReturnValue:&value];
                return [NSValue stringWithAny:&value objCType:aTypeDescription];
            }
            break;
        case _C_FLT: {
                float value;
                [invocation getReturnValue:&value];
                return [NSValue stringWithAny:&value objCType:aTypeDescription];
            }
            break;
        case _C_STRUCT_B:
        case _C_STRUCT_E: {
                const void* value;
                [invocation getReturnValue:&value];
                return [NSValue stringWithAny:&value objCType:aTypeDescription];
            }
            break;
        case _C_ID: {
                id value;
                [invocation getReturnValue:&value];
                if (value) {
                    CFRetain((CFTypeRef)value);
                }
                return to_s(value);
            }
            break;
        default: {
                id value;
                [invocation getReturnValue:&value];
                return [NSValue stringWithAny:&value objCType:aTypeDescription];
            }
            break;
    }
	return Empty;
}

-(NSArray*) properties {
    NSMutableArray* ary = [NSMutableArray array];
    int typeStrMax = 0;
    int propertyNameMax = 0;
    for (Class targetClass in @[self.class, self.superclass]) {
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList((Class)targetClass, &count);
        for(unsigned int idx = 0; idx < count; idx++ ) {
            objc_property_t property = properties[idx];
            const char* name = property_getName(property);
            NSString* propertyName = SWF(@"%s", name);
            const char* attr = property_getAttributes(property);
            const char *argType = (const char*)&attr[1];
            NSString* argTypeString = TypeEncodingDescription(argType);
            NSString* valueString = [self getValueStringForProperty:propertyName];
            [ary addObject:@[propertyName, argTypeString, valueString]];
            typeStrMax = MAX(typeStrMax, (int)argTypeString.length);
            propertyNameMax = MAX(propertyNameMax, (int)propertyName.length);
        }
        free(properties);
    }
    NSMutableArray* ret = [NSMutableArray array];
	for (NSArray* trio in [ary sortedArrayUsingFunction:sortByFirstObjectComparator context:nil]) {
		[ret addObject:SWF(@"%@ %@ %@", [trio.second Ljust:typeStrMax], [trio.First Ljust:propertyNameMax], trio.third)];
	}
	return ret;
}

@end
