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

@implementation DeviceInfoViewController{
    UILabel *infolabel;
    NSMutableString *infoString;
}

- (void)viewDidLoad {
    infolabel = [[UILabel alloc] init];
    infoString = [[NSMutableString alloc] init];

    UIDevice *device = [[UIDevice alloc] init];
    [infoString appendFormat:@"name -> %@\n\n",device.name];
    [infoString appendFormat:@"model -> %@\n\n",device.model];
    [infoString appendFormat:@"type -> %@\n\n",device.localizedModel];
    [infoString appendFormat:@"sysname -> %@\n\n",device.systemName];
    [infoString appendFormat:@"sysversion -> %@\n\n",device.systemVersion];
    [infoString appendFormat:@"UUID -> %@\n\n", [[[UIDevice currentDevice] identifierForVendor] UUIDString]];

    [infoString appendFormat:@"rect -> %@\n\n", NSStringFromCGRect([[UIScreen mainScreen] bounds])];
    [infoString appendFormat:@"scale -> %f\n\n", [[UIScreen mainScreen] scale]];
    [infoString appendFormat:@"width*height -> %f*%f\n\n", [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height];
    NSLog(device.description);

    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSLog(info.description);
    NSLog(carrier.description);



    [infoString appendFormat:@"NSHomeDirectory -> %@\n\n",NSHomeDirectory()];
    [infoString appendFormat:@"NSTemporaryDirectory -> %@\n\n",NSTemporaryDirectory()];
    [infoString appendFormat:@"bundlePath -> %@\n\n", [[NSBundle mainBundle] bundlePath]];

    NSArray *libraryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    [infoString appendFormat:@"libraryPath -> %@\n\n", [libraryPath objectAtIndex:0]];
    NSLog(libraryPath.description);

    //老方法
    CGSize infosize = [infoString sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREEN_WIDTH,MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    //新方法
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
//    CGSize infosize = [infoString boundingRectWithSize:CGSizeMake(SCREEN_WIDTH,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    infolabel.numberOfLines = 0;
    infolabel.font = [UIFont systemFontOfSize:13];
    infolabel.frame = CGRectMake(0,StartY,infosize.width,infosize.height);
    infolabel.text = infoString;
    infolabel.textColor = [UIColor blackColor];
    infolabel.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:infolabel];
}

@end
