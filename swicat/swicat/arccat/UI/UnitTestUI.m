//
//  UnitTestUI.m
//  TestApp
//
//  Created by ssukcha on 06/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTestUI.h"

UIView* findViewInRootViewController(id rootViewController) {
    if ([rootViewController isKindOfClass:UITabBarController.class] || [rootViewController isKindOfClass:UINavigationController.class]) {
        return [[[rootViewController viewControllers] firstObject] view];
    } else {
        return [rootViewController view];
    }
}

@implementation UnitTest (UI)

+(void) run:(id)ui {
    [self run];
    if (UnitTestManager.sharedInstance.assertions > 0) {
        UIView* view = nil;
        if ([ui conformsToProtocol:@protocol(UIApplicationDelegate)]) {
            view = findViewInRootViewController([[ui window] rootViewController]);
        } else if ([ui isKindOfClass:[UIApplication class]]) {
            view = findViewInRootViewController([[[ui windows] firstObject] rootViewController]);
        } else if ([ui isKindOfClass:[UIView class]] || [ui isKindOfClass:[UIWindow class]]) {
            view = ui;
        } else if ([ui isKindOfClass:[UIViewController class]]) {
            view = ((UIViewController*)ui).view;
        }
        if (nil != view) {
            view.backgroundColor =
            (0 == UnitTestManager.sharedInstance.failures) ?
            [UIColor colorWithRed:0.13 green:0.63 blue:0.13 alpha:1] : [UIColor redColor];
        }
    }
}

@end