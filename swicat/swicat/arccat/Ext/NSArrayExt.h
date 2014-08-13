//
//  NSArrayExt.h
//  TestApp
//
//  Created by WooKyoung Noh on 05/09/13.
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
-(NSString*) to_s ;
-(NSString*) join ;
-(NSString*) join:(NSString*)sep ;
-(id) first ;
-(id) last ;
-(NSArray*) reverse ;
@end


@interface NSMutableArray (Ext)
- (id) push:(id)obj ;
- (id) pop ;
-(void) clear ;
@end