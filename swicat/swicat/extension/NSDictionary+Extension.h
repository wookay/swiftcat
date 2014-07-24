//
//  NSDictionary+Extension.h
//  TestApp
//
//  Created by ssukcha on 2014. 1. 10..
//  Copyright (c) 2014년 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)
-(NSString*) to_s ;
-(id) fetch:(id)key ;
-(NSArray*) keys ;
-(NSArray*) values ;
@end
