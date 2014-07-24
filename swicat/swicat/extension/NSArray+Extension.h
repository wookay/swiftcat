//
//  NSArray+Extension.h
//  TestApp
//
//  Created by ssukcha on 2014. 1. 10..
//  Copyright (c) 2014년 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Extension)
-(NSString*) to_s ;
-(NSString*) join ;
-(NSString*) join:(NSString*)sep ;
-(id) first ;
-(id) last ;
-(NSArray*) reverse ;
@end
