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
    CALayer *caLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画";
    button = [[UIButton alloc] initWithFrame:CGRectMake(0,StartY,100,50)];
    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(move) forControlEvents:UIControlEventTouchUpInside];
    button1 = [[UIButton alloc] initWithFrame:CGRectMake(100,StartY,50,50)];
    button1.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [self.view addSubview:button1];
    caLayer = [CALayer layer];
    caLayer.frame = CGRectMake(0,StartY+60,60,60);
    caLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:caLayer];
    [button1 addTarget:self action:@selector(camove:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"CA" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
}


-(void)camove:(UIView *)view{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath =@"position";
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(view.frame.origin.x,view.frame.origin.y)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(300,600)];
    animation.duration = 3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:nil];
}

-(void)move{
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
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [Toast show:@"动画结束啦"];
}
@end
