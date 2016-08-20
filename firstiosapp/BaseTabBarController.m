//
//  BaseTabBarController.m
//  sh12321
//
//  Created by Hebe on 16/8/4.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "NormalViewController.h"
#import "ListView.h"
#import "CollectionView.h"

@interface BaseTabBarController()

@end
@implementation BaseTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.tabBar.backgroundColor = [UIColor blackColor];
    self.tabBar.tintColor = [UIColor greenColor];
    [self setUpAllChildVC];
    self.tabBar.translucent = NO;
//    [self setModalTransitionStyle:UIModalPresentationCustom];
//    [self setModalTransitionStyle:UIModalTransitionStylePartialCurl];
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.5];
//    [animation setType:kCATransitionFromLeft];
//    [animation setSubtype:kCATransitionFromRight];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [[self.view layer] addAnimation:animation forKey:@"SwitchToView"];
}

-(void)setUpAllChildVC{
    NormalViewController *reportViewController = [[NormalViewController alloc] init];
    [self addOneVC:reportViewController normalImage:nil selectImage:nil title:@"normal"];

    ListView *newsViewController = [[ListView alloc] init];
    [self addOneVC:newsViewController normalImage:nil selectImage:nil title:@"list"];

    CollectionView *meViewcontroller = [[CollectionView alloc] init];
    [self addOneVC:meViewcontroller normalImage:nil selectImage:nil title:@"collection"];

}
-(void)addOneVC:(UIViewController *)controller normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage title:(NSString *)title{
    BaseNavigationController *baseNavigationController = [[BaseNavigationController alloc] initWithRootViewController:controller];
    controller.tabBarItem.image = normalImage;
    controller.tabBarItem.selectedImage = selectImage;
    controller.tabBarItem.title = title;
    [self addChildViewController:baseNavigationController];
}

@end
