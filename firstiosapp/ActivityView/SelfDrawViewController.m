//
//  SelfDrawViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/9/6.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "SelfDrawViewController.h"
#import "BaseDrawView.h"

@implementation SelfDrawViewController

- (void)viewDidLoad {
    BaseDrawView *baseDrawView = [[BaseDrawView alloc] initWithFrame:CGRectMake(0,StartY,SCREEN_WIDTH,SCREEN_HEIGHT)];
    [self.view addSubview:baseDrawView];
}

@end
