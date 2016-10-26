//
//  DeviceInfoViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/8/23.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "DeviceInfoViewController.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "SystemConfiguration/SystemConfiguration.h"
#import <netdb.h>
#import <arpa/inet.h>
#import "Utils.h"

@implementation DeviceInfoViewController{
    UIScrollView *scrollView;
    UILabel *infolabel;
    NSMutableString *infoString;
}

- (void)viewDidLoad {
    infolabel = [[UILabel alloc] init];
    infoString = [[NSMutableString alloc] init];

    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,StartY,SCREEN_WIDTH,SCREEN_HEIGHT-StartY)];
    scrollView.scrollEnabled = YES;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    UIDevice *device = [[UIDevice alloc] init];
    [infoString appendFormat:@"name -> %@\n\n",device.name];
    [infoString appendFormat:@"model -> %@\n\n",device.model];
    [infoString appendFormat:@"model -> %@\n\n",[Utils getDeviceType]];
    [infoString appendFormat:@"type -> %@\n\n",device.localizedModel];
    [infoString appendFormat:@"sysname -> %@\n\n",device.systemName];
    [infoString appendFormat:@"sysversion -> %@\n\n",device.systemVersion];
    [infoString appendFormat:@"UUID -> %@\n\n", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];

    [infoString appendFormat:@"rect -> %@\n\n", NSStringFromCGRect([[UIScreen mainScreen] bounds])];
    [infoString appendFormat:@"scale -> %.0f\n\n", [[UIScreen mainScreen] scale]];
    [infoString appendFormat:@"width*height -> %.0f*%.0f\n\n", [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height];
    [infoString appendFormat:@"分辨率 -> %.0f*%.0f\n\n", [[UIScreen mainScreen] bounds].size.width*[[UIScreen mainScreen] scale],[[UIScreen mainScreen] bounds].size.height*[[UIScreen mainScreen] scale]];

    [infoString appendFormat:@"当前网络 -> %@\n\n", [self netWorkState]];
    [infoString appendFormat:@"网络状态 -> %@\n\n", [self isConnectedNetwork]?@"联网":@"未联网"];

    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc]init];
    [infoString appendFormat:@"网络类型 -> %@\n\n", info?info.currentRadioAccessTechnology:@"未知"];

    CTCarrier *carrier = [info subscriberCellularProvider];
    [infoString appendFormat:@"运营商 -> %@\n\n", carrier?carrier.carrierName:@"未知"];
    [infoString appendFormat:@"国家代码 -> %@\n\n", carrier?carrier.mobileCountryCode:@"未知"];
    [infoString appendFormat:@"网络code -> %@\n\n", carrier?carrier.mobileNetworkCode:@"未知"];
    [infoString appendFormat:@"ISO国家代码 -> %@\n\n", carrier?carrier.isoCountryCode:@"未知"];


    [infoString appendFormat:@"NSHomeDirectory -> %@\n\n",NSHomeDirectory()];
    [infoString appendFormat:@"NSTemporaryDirectory -> %@\n\n",NSTemporaryDirectory()];
    [infoString appendFormat:@"bundlePath -> %@\n\n", [[NSBundle mainBundle] bundlePath]];

    NSArray *libraryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    [infoString appendFormat:@"libraryPath -> %@\n\n", [libraryPath objectAtIndex:0]];

    //老方法
    CGSize infosize = [infoString sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREEN_WIDTH,MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    //新方法
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
//    CGSize infosize = [infoString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    infolabel.numberOfLines = 0;
    infolabel.font = [UIFont systemFontOfSize:13];
    infolabel.frame = CGRectMake(0,0,infosize.width,infosize.height);
    infolabel.text = infoString;
    infolabel.textColor = [UIColor blackColor];
    [self.view addSubview:scrollView];
    scrollView.contentSize = infolabel.frame.size;
    [scrollView addSubview:infolabel];
}

-(NSString *)netWorkState {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    int netType;
    NSString * netTypeString;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"] intValue];

            switch (netType) {
                case 0:
                    netTypeString = @"无网络";
                    break;
                case 1:
                    netTypeString = @"2G";
                    break;
                case 2:
                    netTypeString = @"3G";
                    break;
                case 3:
                    netTypeString = @"4G";
                    break;
                case 5:
                    netTypeString = @"WIFI";
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return netTypeString;
}

#pragma mark - 判断有没有网络
- (BOOL)isConnectedNetwork {
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;

    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;

    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);

    if (!didRetrieveFlags) {
        return NO;
    }

    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}


@end
