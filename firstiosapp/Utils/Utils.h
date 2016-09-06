//
// Created by Hebe on 16/7/31.
// Copyright (c) 2016 Hebe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemConfiguration/SystemConfiguration.h"
#import <netdb.h>
#import <arpa/inet.h>

typedef NS_ENUM(NSInteger, Network_State) {
    Network_No,
    Network_2G,
    Network_3G,
    Network_4G,
    Network_5G,
    Network_WIFI,
};
@protocol NetStateDelegate
-(void)onNetStateChanged:(BOOL)state;
@end
@interface Utils : NSObject
@property (nonatomic, assign)id<NetStateDelegate> netDelegate;
+(instancetype)getInstance;
+(void)getStringCGSize:(NSString *)string width:(NSInteger)width height:(NSInteger)height mode:(NSLineBreakMode)mode;
-(void)startNetListener;
-(void)stopNetListener;
+(Network_State)netWorkState;
+(BOOL)isConnectedNetwork;
@end