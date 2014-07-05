//
//  ViewController.m
//  QuickLook
//
//  Created by ssukcha on 7/5/14.
//  Copyright (c) 2014 factorcat. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
            

@end

@implementation ViewController

-(id) debugQuickLookObject {
    return self.view.subviews.firstObject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
