//
//  BaseNavigationController.m
//  sh12321
//
//  Created by Hebe on 16/8/4.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "BaseNavigationController.h"
@interface BaseNavigationController ()

@end
@implementation BaseNavigationController
+ (void)initialize {
    UINavigationBar *naviBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    naviBar.barTintColor = [UIColor whiteColor];
    naviBar.tintColor = [UIColor blackColor];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[NSForegroundColorAttributeName] = [UIColor blackColor];
    naviBar.titleTextAttributes = dictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
@end
