//
//  SecondViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/7/11.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"second navi";
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor colorWithRed:0.07 green:0.82 blue:0.99 alpha:1.00];
    [self.view addSubview:view];
    UILabel *lable = [[UILabel alloc] init];
    [lable setText:self.name];
    lable.frame = CGRectMake(100, 100, 150, 40);
    [self.view addSubview:lable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void) viewWillAppear:(BOOL)animated{
//    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
//}
//- (void) viewWillDisappear:(BOOL)animated{
//    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
//}
//- (void) viewDidAppear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:YES];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
