//
//  NSNumberExt.h
//  TestApp
//
//  Created by WooKyoung Noh on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FIXNUM(num)     [NSNumber numberWithInt:num]
#define Enum(enum)      [NSNumber numberWithInt:enum]


int get_random(int div) ;

@interface NSNumber (Ext)

-(NSNumber*) next ;
-(NSNumber*) roundUp ;
-(NSNumber*) ceiling ;
-(NSNumber*) floorDown ;

@end



@interface NSNumber (CapitalizedExt)
-(NSString*) to_s ;
@end