//
//  UIViewConsoleExt.m
//  TestApp
//
//  Created by ssukcha on 2013. 12. 9..
//  Copyright (c) 2013년 factorcat. All rights reserved.
//

#import "UIViewConsoleExt.h"
#import "NSArrayExt.h"

@implementation UIView (ConsoleExt)

-(UIImage*) toImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (NULL == context) {
        return nil;
    } else {
        [self.layer renderInContext:context];
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

-(void) traverseSubviews:(TraverseViewBlock)block {
    [self traverseSubviews:block reverse:false];
}

-(void) traverseSubviews:(TraverseViewBlock)block reverse:(BOOL)reverse {
    [self traverseSubviews:block depth:0 reverse:reverse];
}

-(void) traverseSubviews:(TraverseViewBlock)block depth:(int)depth reverse:(BOOL)reverse {
    block(depth, self);
    Class UIWebDocumentViewClass = NSClassFromString(@"UIWebDocumentView");
    for (UIView* subview in (reverse ? [[self subviews] reverse] : [self subviews])) {
        if ([subview isKindOfClass:UIWebDocumentViewClass]) {
        } else {
            [subview traverseSubviews:block depth:depth+1 reverse:reverse];
        }
    }
}

@end
