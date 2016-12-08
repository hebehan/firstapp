//
//  BaiDuMapViewController.m
//  firstiosapp
//
//  Created by Hebe on 2016/12/7.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
#import "BaiDuMapViewController.h"
#import "Toast.h"

@interface BaiDuMapViewController ()<BMKMapViewDelegate,UIGestureRecognizerDelegate,BMKLocationServiceDelegate>

@end

@implementation BaiDuMapViewController{
    BMKMapView *mapView;
    BMKLocationService *localService;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mapView = [[BMKMapView alloc] init];
    localService = [[BMKLocationService alloc] init];
    [self.view addSubview:mapView];
    [mapView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.top).offset(StartY);
        make.height.mas_equalTo(@(self.view.frame.size.height-StartY));
        make.width.mas_equalTo(self.view.mas_width);
    }];

    //自定义双加时间，地图自带的有双击事件
    UITapGestureRecognizer *douletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customdoubletap)];
    douletap.delegate = self;
    douletap.numberOfTapsRequired = 2;
    //添加自定义手势，要添加下面两个，不影响地图的手势处理
    douletap.cancelsTouchesInView = NO;
    douletap.delaysTouchesEnded = NO;
    [self.view addGestureRecognizer:douletap];
    mapView.delegate = self;
    localService.delegate = self;
//    mapView.zoomEnabledWithTap = NO;
    UIButton *trafficbutton = [[UIButton alloc] init];
    [self.view addSubview:trafficbutton];
    [trafficbutton addTarget:self action:@selector(ontrafficclick) forControlEvents:UIControlEventTouchUpInside];
    [trafficbutton setTitle:@"交通" forState:UIControlStateNormal];
    trafficbutton.backgroundColor = [UIColor redColor];
    [trafficbutton makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.view.top).offset(64);
        make.leading.mas_equalTo(self.view.leading);
    }];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"普通地图",@"卫星地图"]];
    segmentedControl.selectedSegmentIndex = 0;
    mapView.mapType = BMKMapTypeStandard;
    [segmentedControl addTarget:self action:@selector(maptypeclick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    [segmentedControl makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(trafficbutton.trailing).offset(3);
        make.height.mas_equalTo(trafficbutton.mas_height);
        make.baseline.mas_equalTo(trafficbutton.baseline);
    }];

    UISegmentedControl *scaleseg = [[UISegmentedControl alloc] initWithItems:@[@"  +  ",@"  -  "]];
    scaleseg.momentary = YES;
    [self.view addSubview:scaleseg];
    [scaleseg makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(segmentedControl.trailing).offset(3);
        make.height.mas_equalTo(segmentedControl.mas_height);
        make.baseline.mas_equalTo(segmentedControl.baseline);
    }];
    [scaleseg addTarget:self action:@selector(scaleclick:) forControlEvents:UIControlEventValueChanged];
    UIButton *locationbutton = [[UIButton alloc] init];
    [self.view addSubview:locationbutton];
    locationbutton.backgroundColor = [UIColor grayColor];
    [locationbutton setTitle:@"定位" forState:UIControlStateNormal];
    [locationbutton makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.mas_equalTo(scaleseg.mas_baseline);
        make.height.mas_equalTo(scaleseg.mas_height);
        make.leading.mas_equalTo(scaleseg.trailing).offset(3);
    }];
    [locationbutton addTarget:self action:@selector(onlocationclick) forControlEvents:UIControlEventTouchUpInside];
//    [self onlocationclick];
}

-(void)onlocationclick{
    NSLog(@"进来定位了");
    [localService startUserLocationService];
}

-(void)scaleclick:(UISegmentedControl *)sender{
    NSInteger index = sender.selectedSegmentIndex;
    mapView.zoomLevel = index==0?mapView.zoomLevel++:mapView.zoomLevel--;
    [Toast show:@"当前缩放等级=%f",mapView.zoomLevel];
}
-(void)maptypeclick:(id)sender{
    NSLog(@"jinlal");
    NSInteger index = ((UISegmentedControl *)sender).selectedSegmentIndex;
    mapView.mapType = index == 0?BMKMapTypeStandard:BMKMapTypeSatellite;
}

-(void)ontrafficclick{
    mapView.trafficEnabled = !mapView.trafficEnabled;
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    [Toast show:[NSString stringWithFormat:@"双击地图,纬度=%f，经度=%f",coordinate.latitude,coordinate.longitude]];
    NSLog(@"mapView onDoubleClick");
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    [Toast show:[NSString stringWithFormat:@"点击地图空白,纬度=%f，经度=%f",coordinate.latitude,coordinate.longitude]];
    NSLog(@"mapView onClickedMapBlank");
}
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi {
    [mapView setCenterCoordinate:mapPoi.pt animated:YES];
//    mapView.centerCoordinate = mapPoi.pt;
    [Toast show:[NSString stringWithFormat:@"点击地图poi,名称=%@,纬度=%f，经度=%f",mapPoi.text,mapPoi.pt.latitude,mapPoi.pt.longitude]];
}

-(void)customdoubletap{
    NSLog(@"doubletap");
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"定位回调进来了");
    [mapView updateLocationData:userLocation];
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
//    mapView.showsUserLocation = YES;

//    mapView.zoomLevel = 14;
    for(BMKPointAnnotation *pointAnnotation in mapView.annotations){
        if ([pointAnnotation.title isEqualToString:@"我是title"]){
            NSLog(@"找到ano并移除");
            [mapView removeAnnotation:pointAnnotation];
        }
    }
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = userLocation.location.coordinate;
    annotation.title = @"我是title";
    annotation.subtitle = @"我是subtitle";
    [mapView addAnnotation:annotation];
//    mapView.centerCoordinate = userLocation.location.coordinate;
    //放大地图到自身的经纬度位置。
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(userLocation.location.coordinate, BMKCoordinateSpanMake(0.02f,0.02f));
    BMKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];
    [Toast show:@"纬度=%f，经度=%f，title=%@，subtitle=%@",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude,userLocation.title,userLocation.subtitle];
    if (userLocation.location){
        [localService stopUserLocationService];
    }
}

- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {

    return overlay;
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
//    if ([annotation.title isEqualToString:@"我是title"]){
//
//        return annotationView;
//    }
    NSString *pointid = @"annotationid";
    BMKPinAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:pointid ];
    if (annotationView == nil){
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointid];
        annotationView.animatesDrop = YES;
        annotationView.pinColor = BMKPinAnnotationColorRed;
        annotationView.draggable = YES;
    }
    return annotationView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [mapView viewWillAppear];
    mapView.delegate = self;
    localService.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [mapView viewWillDisappear];
    mapView.delegate = nil;
    localService.delegate = nil;
}
- (void)dealloc {
    if (mapView) {
        mapView = nil;
    }
    if (localService){
        localService = nil;
    }
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
