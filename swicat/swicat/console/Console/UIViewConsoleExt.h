//
//  UIViewConsoleExt.h
//  TestApp
//
//  Created by ssukcha on 2013. 12. 9..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TraverseViewBlock)(int depth, UIView* view) ;
@interface UIView (ConsoleExt)
-(UIImage*) toImage ;
-(void) traverseSubviews:(TraverseViewBlock)block ;
-(void) traverseSubviews:(TraverseViewBlock)block reverse:(BOOL)reverse ;
-(void) traverseSubviews:(TraverseViewBlock)block depth:(int)depth reverse:(BOOL)reverse ;
@end
