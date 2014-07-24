//
//  NSObjectExt.h
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Ext)

-(NSString*) className ;
-(NSArray*) classMethods ;
-(NSArray*) Methods ;
-(NSArray*) properties ;
-(NSString*) getValueStringForProperty:(NSString*)propertyName ;
-(NSArray*) getters ;

@end
