//
//  AnimationViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/8/17.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "AnimationViewController.h"
#import "Toast.h"

@interface AnimationViewController()
@end
@implementation AnimationViewController{
    UIButton *button;
    UIButton *button1;
}

- (void)viewDidLoad {
    self.title = @"动画";
    button = [[UIButton alloc] initWithFrame:CGRectMake(0,StartY,100,50)];
    button.backgroundColor = [UIColor cyanColor];
    button1 = [[UIButton alloc] initWithFrame:CGRectMake(100,StartY,50,50)];
    button1.backgroundColor = [UIColor redColor];
    [UIView beginAnimations:@"testanim" context:nil];
    [UIView setAnimationDuration:2];
    button.center = self.view.center;
    [button setAlpha:0.1];
    button.backgroundColor = [UIColor blueColor];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [button setTransform:CGAffineTransformRotate(button.transform,M_PI)];
    [button setTransform:CGAffineTransformScale(button.transform,0.5,0.5)];


    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    [self.view addSubview:button];
    [self.view addSubview:button1];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [Toast show:@"动画结束啦"];
}
@end
