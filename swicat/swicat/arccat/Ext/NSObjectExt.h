//
//  NSObjectExt.h
//  TestApp
//
//  Created by WooKyoung Noh on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Ext)

-(NSString*) className ;
-(NSArray*) classMethods ;
-(NSArray*) methods ;
-(NSArray*) properties ;
-(NSString*) getValueStringForProperty:(NSString*)propertyName ;
-(NSArray*) getters ;

@end



@interface NSObject (CallMethod)

- (id) call_method:(NSString *)sel ;

@end
