//
//  NSClassExt.m
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "NSClassExt.h"
#import "NSStringExt.h"
#import "NSArrayExt.h"
#import "objc/runtime.h"




NSString* TypeEncodingDescription(const char* code) {
	switch (code[0]) {
		case _C_ID:
			return @"id";
		case _C_CLASS:
			return @"Class";
		case _C_SEL:
			return @"SEL";
		case _C_CHR:
			return @"char";
		case _C_UCHR:
			return @"u_char";
		case _C_SHT:
			return @"short";
		case _C_USHT:
			return @"ushort";
		case _C_INT:
			return @"int";
		case _C_UINT:
			return @"uint";
		case _C_LNG:
			return @"long";
		case _C_ULNG:
			return @"u_long";
		case _C_LNG_LNG:
			return @"long long";
		case _C_ULNG_LNG:
			return @"unsigned long long";
		case _C_FLT:
			return @"float";
		case _C_DBL:
			return @"double";
		case _C_BFLD:
			return @"bit field";
		case _C_BOOL:
			return @"BOOL";
		case _C_VOID:
			return @"void";
		case _C_UNDEF:
			return @"unknown";
		case _C_PTR:
			return @"void*";
		case _C_CHARPTR:
			return @"char*";
		case _C_ATOM:
			return @"atom";
		case _C_ARY_B:
		case _C_ARY_E:
			return @"array";
		case _C_UNION_B:
		case _C_UNION_E:
			return @"union";
		case _C_STRUCT_B:
		case _C_STRUCT_E: {
            NSString* structStr = [[[[SWF(@"%s", code) gsub:@"{_" to:Empty] gsub:OPENING_BRACE to:Empty] Split:EQUAL] First];
            if ([QUESTION_MARK isEqualToString:structStr]) {
                return @"struct";
            } else {
                return structStr;
            }
        }
			break;
		case _C_VECTOR:
			return @"vector";
		case _C_CONST:
			return @"const";
		default:
			break;
	}
	return SWF(@"%s", code);
}


@implementation NSClassExt

+(NSArray*) methodsForClass:(Class)targetClass {
	NSMutableArray* ary = [NSMutableArray array];
	unsigned int count;
	Method *methods = class_copyMethodList((Class)targetClass, &count);
	int retStrMax = 0;
	for (unsigned int idx = 0; idx < count; ++idx) {
		Method method = methods[idx];
		SEL selector = method_getName(method);
		NSString *selectorName = NSStringFromSelector(selector);
#define ARGUMENT_OFFSET 2
		unsigned int numberOfArguments = method_getNumberOfArguments(method) - ARGUMENT_OFFSET;
		NSString* selName;
		if (numberOfArguments > 0) {
			NSMutableArray* selArray = [NSMutableArray array];
			NSArray* selArgs = [selectorName Split:COLON];
			for (unsigned int argIdx = 0; argIdx < numberOfArguments; argIdx++) {
				NSString* argString = [selArgs objectAtIndex:argIdx];
				char* argType = method_copyArgumentType(method, argIdx + ARGUMENT_OFFSET);
				NSString* argTypeString = TypeEncodingDescription(argType);
				free(argType);
				NSString* shortArgStr;
				NSRange range = [argString rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet] options:NSBackwardsSearch];
				if (NSNotFound == range.location) {
					shortArgStr = SWF(@"%@Value", argTypeString);
				} else {
					shortArgStr = [[argString substringFromIndex:range.location] lowercaseString];
				}
				[selArray addObject:SWF(@"%@:(%@)%@", argString, argTypeString, shortArgStr)];
			}
			selName = [selArray Join:SPACE];
		} else {
			selName = selectorName;
		}
		char* returnType = method_copyReturnType(method);
		NSString* returnTypeString = TypeEncodingDescription(returnType);
		free(returnType);
		NSString* retStr = SWF(@"%@(%@)", class_isMetaClass(targetClass) ? @"+" : @"-", returnTypeString);
		[ary addObject:@[selName, retStr]];
		retStrMax = MAX(retStrMax, (int)retStr.length);
	}
	free(methods);
	NSMutableArray* ret = [NSMutableArray array];
	for (NSArray* pair in [ary sortedArrayUsingFunction:sortByFirstObjectComparator context:nil]) {
		[ret addObject:SWF(@"%@ %@ ;", [[pair second] Ljust:retStrMax], [pair First])];
	}
	return ret;
}

+(NSArray*) propertiesForClass:(Class)targetClass {
    NSMutableArray* ary = [NSMutableArray array];
	unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList((Class)targetClass, &count);
    int typeStrMax = 0;
    for(unsigned int idx = 0; idx < count; idx++ ) {
        objc_property_t property = properties[idx];
		const char* name = property_getName(property);
		NSString* propertyName = SWF(@"%s", name);
        const char* attr = property_getAttributes(property);
        const char *argType = (const char*)&attr[1];
        NSString* argTypeString = TypeEncodingDescription(argType);
        [ary addObject:@[propertyName, argTypeString]];
        typeStrMax = MAX(typeStrMax, (int)argTypeString.length);
	}
	free(properties);
    NSMutableArray* ret = [NSMutableArray array];
	for (NSArray* pair in [ary sortedArrayUsingFunction:sortByFirstObjectComparator context:nil]) {
		[ret addObject:SWF(@"%@ %@", [pair.second Ljust:typeStrMax], pair.First)];
	}
	return ret;
}

@end