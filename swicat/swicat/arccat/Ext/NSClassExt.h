//
//  NSClassExt.h
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>


NSString* TypeEncodingDescription(const char* code) ;


@interface NSClassExt : NSObject

+(NSArray*) methodsForClass:(Class)targetClass ;
+(NSArray*) propertiesForClass:(Class)targetClass ;

@end
