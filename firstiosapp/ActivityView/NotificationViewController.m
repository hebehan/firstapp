//
//  NotificationViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/8/15.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "NotificationViewController.h"

@implementation NotificationViewController{
    UILocalNotification *localNotification;
}

- (void)viewDidLoad {

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0,StartY,100,50)];
    [button setTitle:@"发本地通知" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(showNotification) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)initNotification{
    //初始化通知
    localNotification = [[UILocalNotification alloc] init];
    //触发时间,当前时间的几秒后
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //触发时弹出内容信息
    localNotification.alertBody = @"这是alertBody";
//    //触发时弹出标题
//    localNotification.alertTitle = @"这是Title";
    // 触发时的声音（这里选择的系统默认声音）
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 触发频率（repeatInterval是一个枚举值，可以选择每分、每小时、每天、每年等）NSCalendarUnitDay
    localNotification.repeatInterval = 0;
    // 需要在App icon上显示的未读通知数（设置为1时，多个通知未读，系统会自动加1，如果不需要显示未读数，这里可以设置0）-1貌似清空
    localNotification.applicationIconBadgeNumber+= 1;
    //添加通知id 方便取消哪一个通知
    localNotification.userInfo = @{@"id":@"notiid1"};
    //添加notification的事件按钮名字
    localNotification.alertAction = @"知道了";
    localNotification.hasAction = YES;

}

-(void)showNotification{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [self showios8Notification];
    } else{
        [self initNotification];
    }
    //注册本地通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)showios8Notification{
    //初始化action
    UIMutableUserNotificationAction* action1 = [[UIMutableUserNotificationAction alloc] init];
    //设置action的identifier
    [action1 setIdentifier:@"action1"];
    //title就是按钮上的文字
    [action1 setTitle:@"title1"];
    //设置点击后在后台处理,还是打开APP
    [action1 setActivationMode:UIUserNotificationActivationModeBackground];
    //是不是像UIActionSheet那样的Destructive样式
    [action1 setDestructive:NO];
    //在锁屏界面操作时，是否需要解锁
    [action1 setAuthenticationRequired:NO];

    UIMutableUserNotificationAction* action2 = [[UIMutableUserNotificationAction alloc] init];
    [action2 setIdentifier:@"action2"];
    [action2 setTitle:@"title2"];
    [action2 setActivationMode:UIUserNotificationActivationModeForeground];
    [action2 setDestructive:NO];
    [action2 setAuthenticationRequired:NO];

    //一个category包含一组action，作为一种显示样式
    UIMutableUserNotificationCategory* category = [[UIMutableUserNotificationCategory alloc] init];
    [category setIdentifier:@"category1"];
    //minimal作为banner样式时使用，最多只能有2个actions；default最多可以有4个actions
    [category setActions:@[action1,action2] forContext:UIUserNotificationActionContextMinimal];

    NSSet* set = [NSSet setWithObject:category];
    UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound
                                                                             categories:set];
    //注册notification设置
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    //添加一个notification，10秒后触发
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    //设置notifiction的样式为"category1"
    [notification setCategory:@"category1"];
    [notification setFireDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    [notification setAlertBody:@"this is an alert"];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

}
@end
