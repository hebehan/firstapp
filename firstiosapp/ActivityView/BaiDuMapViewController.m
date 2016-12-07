//
//  BaiDuMapViewController.m
//  firstiosapp
//
//  Created by Hebe on 2016/12/7.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "BaiDuMapViewController.h"

@interface BaiDuMapViewController ()

@end

@implementation BaiDuMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BMKMapView *mapView = [[BMKMapView alloc] init];
    [self.view addSubview:mapView];
    [mapView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
    }];
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
