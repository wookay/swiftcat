//
//  NSString+Extension.h
//  TestApp
//
//  Created by ssukcha on 2014. 1. 10..
//  Copyright (c) 2014년 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LF @"\n"

@interface NSString (Extension)
-(NSString*) to_s ;
-(NSArray*) split:(NSString*)sep ;
-(NSArray*) each_char ;
-(NSString*) ljust:(int)justified ;
-(NSString*) strip ;
-(NSString*) reverse ;
@end
