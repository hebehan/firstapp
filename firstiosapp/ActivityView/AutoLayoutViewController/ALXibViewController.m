//
//  ALXibViewController.m
//  firstiosapp
//
//  Created by Hebe on 2016/10/28.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "ALXibViewController.h"

@implementation ALXibViewController{
    UIView *appview;
}

- (void)viewDidLoad {
    NSArray  *apparray= [[NSBundle mainBundle]loadNibNamed:@"autotest" owner:nil options:nil];
    appview=[apparray firstObject];
    [self.view addSubview:appview];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeFrames:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

-(void)changeFrames:(NSNotification *)notification
{
    NSLog(@"change notification: %@", notification.userInfo);
    float width=[[UIScreen mainScreen]bounds].size.width*[[UIScreen mainScreen] scale];
    float height=[[UIScreen mainScreen]bounds].size.height*[[UIScreen mainScreen] scale];
    NSLog(@"%f,%f",width,height);
    appview.frame=CGRectMake(0, 0, width/2, height/2);
//    if ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait
//        || [[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown)
//    {
//        NSLog(@"portrait");
//        appview.frame=CGRectMake(0, 0, width/2, height/2);
//        
//    }
//    else
//    {
//        NSLog(@"landscape");
//        appview.frame=CGRectMake(0, 0, width/2, height/2);
//    }
    NSLog(@"view is %@",self);
}

@end
