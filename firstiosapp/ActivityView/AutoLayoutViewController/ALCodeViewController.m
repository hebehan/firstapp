//
//  ALCodeViewController.m
//  firstiosapp
//  纯代码实现autolayout
//  Created by Hebe on 2016/12/2.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "ALCodeViewController.h"

@interface ALCodeViewController ()

@end

@implementation ALCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"apple.jpg"]];
    [self.view addSubview:image];
    image.contentMode = UIViewContentModeScaleAspectFit;
    self.view.backgroundColor = [UIColor grayColor];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:image attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:image attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:image attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:StartY];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:image attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5f constant:-StartY];
    left.active = YES;
    right.active = YES;
    top.active = YES;
    bottom.active = YES;
    image.translatesAutoresizingMaskIntoConstraints = NO;

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.backgroundColor = [UIColor blackColor];
    NSLayoutConstraint *scrollleft = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *scrollright = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *scrolltop = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:image attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *scrollbottom = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5f constant:0.0f];
    NSLayoutConstraint *scrollwidth = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
    scrollleft.active = YES;
    scrollright.active = YES;
    scrollbottom.active = YES;
    scrolltop.active = YES;
    scrollwidth.active = YES;

    UILabel *title = [[UILabel alloc] init];
    title.text = @"苹果公司";
    title.font = [UIFont systemFontOfSize:16];
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor greenColor];

    NSLayoutConstraint *titleleft = [NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *titleright = [NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *titletop = [NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:3.0f];
    NSLayoutConstraint *titlebottom = [NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20];
    NSLayoutConstraint *titlewidth = [NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
    [scrollView addSubview:title];

    titlebottom.active = YES;
    titleleft.active = YES;
    titletop.active = YES;
    titleright.active = YES;
    titlewidth.active = YES;
    title.translatesAutoresizingMaskIntoConstraints = NO;


    UILabel *content = [[UILabel alloc] init];
    content.text = @"注意，我们需要将创建的约束添加到约束所涉及到的两个视图的最小公共祖先视图上。例如，如果直接设置视图的宽度和高度，则将约束添加到该视图即可；如果约束建立在父视图和子注意，我们需要将创建的约束添加到约束所涉及到的两个视图的最小公共祖先视图上。例如，如果直接设置视图的宽度和高度，则将约束添加到该视图即可；如果约束建立在父视图和子视图上，则添加到父视图上；如果约束建立在两个兄弟视图上，则添加到两个兄弟视图的父视图上。 \\n\"\n"
            "            \"对于上面的4个约束而言，涉及到的两个视图分别是logoImageView与其父视图self.view，这两个视图的最小公共祖先视图为self.view。UIView类提供了若干方法和属性，用于添加或者移除约束。对于iOS 6或者iOS 7可以调用addConstraint(s):和removeConstraint(s注意，我们需要将创建的约束添加到约束所涉及到的两个视图的最小公共祖先视图上。例如，如果直接设置视图的宽度和高度，则将约束添加到该视图即可；如果约束建立在父视图和子视图上，则添加到父视图上；如果约束建立在两个兄弟视图上，则添加到两个兄弟视图的父视图上。 \\n\"\n"
            "            \"对于上面的4个约束而言，涉及到的两个视图分别是logoImageView与其父视图self.view，这两个视图的最小公共祖先视图为self.view。UIView类提供了若干方法和属性，用于添加或者移除约束。对于iOS 6或者iOS 7可以调用addConstraint(s):和removeConstraint(s视图上，则添加注意，我们需要将创建的约束添加到约束所涉及到的两个视图的最小公共祖先视图上。例如，如果直接设置视图的宽度和高度，则将约束添加到该视图即可；如果约束建立在父视图和子视图上，则添加到父视图上；如果约束建立在两个兄弟视图上，则添加到两个兄弟视图的父视图上。 \\n\"\n"
            "            \"对于上面的4个约束而言，涉及到的两个视图分别是logoImageView与其父视图self.view，这两个视图的最小公共祖先视图为self.view。UIView类提供了若干方法和属性，用于添加或者移除约束。对于iOS 6或者iOS 7可以调用addConstraint(s):和removeConstraint(s到父视图上；如果约束建立在两个兄弟视图上，则添加到两个兄弟视图的父视图上。 \n"
            "对于上面的4个约束而言，涉及到的两个视图分别是logoImageView与其父视图self.view，这两个视图的最小公共祖先视图为self.view。UIView类提供了若干方法和属性，用于添加或者移除约束。对于iOS 6或者iOS 7可以调用addConstraint(s):和removeConstraint(s):方法；对于iOS 8及更新的版本，直接设置约束的active属性或者调用activateConstraints:与deactivateConstraints:类方法。";
    content.font = [UIFont systemFontOfSize:14];
    content.textColor = [UIColor blackColor];
    content.backgroundColor = [UIColor yellowColor];
    content.numberOfLines = 0;

    NSLayoutConstraint *contentleft = [NSLayoutConstraint constraintWithItem:content attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *contentright = [NSLayoutConstraint constraintWithItem:content attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *contenttop = [NSLayoutConstraint constraintWithItem:content attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:title attribute:NSLayoutAttributeBottom multiplier:1.0f constant:3.0f];
    NSLayoutConstraint *contentbottom = [NSLayoutConstraint constraintWithItem:content attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:scrollView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *contentwidth = [NSLayoutConstraint constraintWithItem:content attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];

    [scrollView addSubview:content];

    contentbottom.active = YES;
    contentleft.active = YES;
    contenttop.active = YES;
    contentright.active = YES;
    contentwidth.active = YES;
    content.translatesAutoresizingMaskIntoConstraints = NO;


//    [image addConstraints:@[left,right,top,bottom]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
