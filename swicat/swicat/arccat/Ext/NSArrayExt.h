//
//  NSArrayExt.h
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>



NSInteger sortByFirstObjectComparator(NSArray* uno, NSArray* dos, void* context) ;

@interface NSArray (Ext)
-(BOOL) include:(id)obj ;
-(NSArray*) slice:(int)loc :(int)length_ ;
-(NSArray*) slice:(int)loc backward:(int)backward ;
-(id) second ;
-(id) third ;
-(NSArray*) append:(NSArray*)ary ;
-(NSArray*) sort ;
@end


@interface NSArray (CapitalizedExt)
-(NSString*) To_s ;
-(NSString*) Join ;
-(NSString*) Join:(NSString*)sep ;
-(id) First ;
-(id) Last ;
-(NSArray*) Reverse ;
@end


@interface NSMutableArray (Ext)
- (id) push:(id)obj ;
- (id) pop ;
-(void) clear ;
@end