//
// Created by Hebe on 16/7/31.
// Copyright (c) 2016 Hebe. All rights reserved.
//

#import "Utils.h"

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
@end