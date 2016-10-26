//
//  TouchIdViewController.m
//  firstiosapp
//
//  Created by Hebe on 2016/10/25.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "TouchIdViewController.h"

@interface TouchIdViewController ()

@end

@implementation TouchIdViewController{
    UILabel *touchlable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    touchlable = [[UILabel alloc]initWithFrame:CGRectMake(100, StartY+50, 100, 50)];
    touchlable.textColor = [UIColor redColor];
    touchlable.font = [UIFont systemFontOfSize:14];
    touchlable.text = @"请触摸home键完成指纹验证";
    [self.view addSubview:touchlable];
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
