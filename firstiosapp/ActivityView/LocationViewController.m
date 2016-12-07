//
//  LocationViewController.m
//  firstiosapp
//
//  Created by Hebe on 2016/12/5.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "LocationViewController.h"
#import "CoreLocation/CoreLocation.h"

@interface LocationViewController ()<CLLocationManagerDelegate>

@end

@implementation LocationViewController{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    UILabel *label;
    UIButton *button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.distanceFilter = 100;
    geocoder = [[CLGeocoder alloc] init];
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"点击定位" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    [self.view addSubview:button];
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100,40));
        make.top.equalTo(self.view).offset(StartY);
        make.centerX.equalTo(self.view);
    }];
    [button addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];

    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor greenColor];
    label.textColor = [UIColor blackColor];
    label.text = @"dfhsdfhasdfsdf";
    label.numberOfLines = 0;
    [self.view addSubview:label];

    // Do any additional setup after loading the view.
}

-(void)locationClick{
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"定位回调进来了");
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(button.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view.mas_width).offset(-32);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-16);
    }];
    label.text = locations[0].description;
    [geocoder reverseGeocodeLocation:locations[0] completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        NSString *info = [[NSString alloc] initWithFormat:@"%@,%@",locations[0].description,placemarks[0].description];
//        label.text = [self replaceUnicode:info];
        label.text = info;
        NSLog(placemarks.description);
    }];
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(error.description);
    [locationManager stopUpdatingLocation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];

    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
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
