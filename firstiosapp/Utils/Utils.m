//
// Created by Hebe on 16/7/31.
// Copyright (c) 2016 Hebe. All rights reserved.
//

#import "Utils.h"
#import <sys/utsname.h>

@interface Utils()

@end
static NSTimer *timer = nil;
static BOOL lastNetState = YES;
static Utils *instance = nil;
@implementation Utils{
}
+ (instancetype)getInstance {
        @synchronized (self) {
                if (instance == nil){
                        instance = [[self alloc] init];
                }
        }
        return instance;
}

+(CGSize) getStringCGSize:(NSString *)string fontsize:(CGFloat)size width:(CGFloat)width height:(CGFloat)height mode:(NSLineBreakMode)mode {

        return [string sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(width==0,height) lineBreakMode:mode];
}

+ (Network_State)netWorkState {
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
        Network_State state = Network_No;
        int netType = 0;
        //获取到网络返回码
        for (id child in children) {
                if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                        //获取到状态栏
                        netType = [[child valueForKeyPath:@"dataNetworkType"] intValue];

                        switch (netType) {
                                case 0:
                                        state = Network_No;
                                break;
                                case 1:
                                        state = Network_2G;
                                break;
                                case 2:
                                        state = Network_3G;
                                break;
                                case 3:
                                        state = Network_4G;
                                break;
                                case 4:
                                        state = Network_5G;
                                break;
                                case 5:
                                        state = Network_WIFI;
                                break;
                                default:
                                        break;
                        }
                }
        }
        //根据状态选择
        return state;
}

+ (BOOL)isConnectedNetwork {
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

- (void)startNetListener {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(notifiNetState) userInfo:nil repeats:YES];
}

- (void)stopNetListener {
        if (timer)
                [timer invalidate];
}

-(void)notifiNetState{
        BOOL isconnect = [Utils isConnectedNetwork];
        if (lastNetState != isconnect){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"netstate" object:isconnect?@"YES":@"NO"];
                NSLog(isconnect?@"网络连接":@"网络断开");
                if (self.netDelegate)
                        [self.netDelegate onNetStateChanged:isconnect];
                lastNetState = isconnect;
        }
}

+(NSString *)getDeviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

+ (NSArray *)removeObjectFromArrayByKey:(NSString *)key array:(NSArray *)array {
//    NSLog(@"1---%f", [[NSDate date] timeIntervalSince1970]);
//    NSLog(@"2---%ld", time(NULL));
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSDate *date = [NSDate date];
//    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
//    NSString *timeString = [NSString stringWithFormat:@"%f", a];
//    NSLog(@"3---%@", timeString);
    for (int i = 0; i < array.count; ++i) {
        if ([[array objectAtIndex:i] isKindOfClass:[NSString class]] && [[array objectAtIndex:i] isEqual:key]){
            continue;
        }
        [array1 addObject:[array objectAtIndex:i]];
    }
//    NSLog(@"%ld", time(NULL));
//    NSMutableArray *array2 = [[NSMutableArray alloc] init];
//    NSDate* dat1 = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a1=[dat1 timeIntervalSince1970]*1000;
//    NSString *timeString1 = [NSString stringWithFormat:@"%f", a1];
//    NSLog(@"3---%@", timeString1);
    return array1;
}
@end