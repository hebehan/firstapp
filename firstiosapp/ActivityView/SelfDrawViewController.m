//
//  SelfDrawViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/9/6.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "SelfDrawViewController.h"
#import "BaseDrawView.h"
#import "WeekSportChartView.h"

@implementation SelfDrawViewController

- (void)viewDidLoad {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,StartY,SCREEN_WIDTH,SCREEN_HEIGHT)];
    self.automaticallyAdjustsScrollViewInsets = false;
    BaseDrawView *baseDrawView = [[BaseDrawView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,410)];
    [scrollView addSubview:baseDrawView];
    WeekSportChartView *weekSportChartView = [[WeekSportChartView alloc] initWithFrame:CGRectMake(0,baseDrawView.frame.origin.y+baseDrawView.frame.size.height,SCREEN_WIDTH,200)];
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObjects:@[@"800",@"1000",@"4000",@"600",@"2500",@"1400",@"500"] forKeys:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7"]];
    weekSportChartView.datas = data;
    NSLog(@"%f,%f",baseDrawView.frame.size.height,weekSportChartView.frame.size.height);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH,baseDrawView.frame.size.height+weekSportChartView.frame.size.height+StartY);
    scrollView.scrollEnabled = YES;
    NSLog(@"scrollview的contentSize高度=%f",scrollView.contentSize.height);
    [scrollView addSubview:weekSportChartView];
    [self.view addSubview:scrollView];

}

@end
