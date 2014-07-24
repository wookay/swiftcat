//
//  NSValueExt.h
//  FindTheWords
//
//  Created by wookay on 13. 10. 6..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSValue (ValueExt)

+(id) valueWithAny:(const void *)value objCType:(const char *)type ;
+(NSString*) stringWithAny:(const void *)value objCType:(const char *)type ;

@end
