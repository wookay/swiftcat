//
//  NSDictionaryExt.h
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Ext)
-(NSArray*) to_array ;
-(BOOL) hasKey:(id)key ;
-(id) keyForObject:(id)obj ;
@end


@interface NSDictionary (CapitalizedExt)
-(NSString*) To_s ;
-(id) Fetch:(id)key ;
-(NSArray*) Keys ;
-(NSArray*) Values ;
@end

@interface NSMutableDictionary (Ext)

-(id) storeKey:(id)key value:(id)value ;
-(void) merge:(NSDictionary*)other ;
-(id) delete:(id)key ;
-(void) clear ;

@end