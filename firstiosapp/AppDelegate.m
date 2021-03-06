//
//  AppDelegate.m
//  firstiosapp
//
//  Created by Hebe on 16/7/1.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "AppDelegate.h"
#import "NormalViewController.h"
#import "LauncherView.h"
#import "Utils.h"
#import "Toast.h"
#import "NetViewController.h"
#import <GT/GT.h>


@interface AppDelegate ()

@end

@implementation AppDelegate{
    BMKMapManager* mapManager;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    LauncherView *vc =[[LauncherView alloc]init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController=navi;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[Utils getInstance] startNetListener];
//    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    _window.backgroundColor = [UIColor redColor];
//    [_window makeKeyAndVisible];
    // Override point for customization after application launch.
//    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types==UIUserNotificationTypeNone) {
//        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
//    }
    //注册notification
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
        [application registerForRemoteNotifications];
    } else{
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }

//    GT_DEBUG_INIT;
//    
//    // GT Usage(合入) 设置GT logo不旋转及支持方向
//    
//    GT_DEBUG_SET_AUTOROTATE(false);
//    
//    GT_DEBUG_SET_SUPPORT_ORIENTATIONS(UIInterfaceOrientationMaskPortrait);
    mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [mapManager start:@"tkZMwufg16tt8xiKnHHS9GCi0FFozj92" generalDelegate:self];
    NSLog(@"百度地图%@",ret?@"初始化成功":@"初始化失败");
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(notification.alertBody);
//    NSLog(notification.alertAction);
    application.applicationIconBadgeNumber-=1;
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    NSLog([shortcutItem description]);
    [Toast show:[shortcutItem description]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"3DTOUCH" object:shortcutItem];
}

@end
