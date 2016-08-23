//
//  IntentViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/8/23.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "IntentViewController.h"
#import "Toast.h"

@interface IntentViewController()<UIActionSheetDelegate,MFMessageComposeViewControllerDelegate>
@end
@implementation IntentViewController

- (void)viewDidLoad {
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    phoneButton.frame = CGRectMake(0,StartY,80,50);
    [phoneButton setTitle:@"电话" forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(PhoneTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneButton];

    UIButton *smsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    smsButton.frame = CGRectMake(0+80+20,StartY,80,50);
    smsButton.backgroundColor = [UIColor grayColor];
    [smsButton setTitle:@"短信" forState:UIControlStateNormal];
    [smsButton addTarget:self action:@selector(smsTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:smsButton];

    UIButton *browseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    browseButton.frame = CGRectMake(0+2*80+20,StartY,80,50);
    [browseButton setTitle:@"浏览器" forState:UIControlStateNormal];
    [browseButton addTarget:self action:@selector(browseTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:browseButton];

    UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeSystem];
    mailButton.frame = CGRectMake(0,StartY+50+20,80,50);
    [mailButton setTitle:@"邮件" forState:UIControlStateNormal];
    [mailButton addTarget:self action:@selector(mailTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mailButton];

    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeSystem];
    mapButton.frame = CGRectMake(0+80+20,StartY+50+20,80,50);
    [mapButton setTitle:@"地图" forState:UIControlStateNormal];
    [mapButton addTarget:self action:@selector(mapTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapButton];

    UIButton *appstoreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    appstoreButton.frame = CGRectMake(0+2*80+20,StartY+50+20,80,50);
    [appstoreButton setTitle:@"AppStore" forState:UIControlStateNormal];
    [appstoreButton addTarget:self action:@selector(appStroeTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appstoreButton];

    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    settingButton.frame = CGRectMake(0,StartY+2*50+20,80,50);
    [settingButton setTitle:@"Setting" forState:UIControlStateNormal];
    [settingButton addTarget:self action:@selector(settingTap) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:settingButton];
    
    UIButton *appButton = [UIButton buttonWithType:UIButtonTypeSystem];
    appButton.frame = CGRectMake(0,StartY+2*50+20,80,50);
    [appButton setTitle:@"APP" forState:UIControlStateNormal];
    [appButton addTarget:self action:@selector(intentApp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appButton];

}

-(void)PhoneTap{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"打电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"方式1",@"方式2",@"方式3",nil];
    actionSheet.tag = 1;
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)smsTap{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"发短信" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"方式1",@"方式2",nil];
    actionSheet.tag = 2;
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}
-(void)browseTap{
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"http://www.google.com/ncr"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"浏览器" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"方式1",nil];
//    actionSheet.tag = 3;
//    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)mailTap{
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"mailto://%@",@"doveskila@gmail.com"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

-(void)mapTap{
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"http://maps.google.com/maps?q=%@",@"shanghai"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

-(void)appStroeTap{
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"itms-apps:// itunes.apple.com/gb/app/yi-dong-cai-bian/id391945719?mt=8"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

-(void)settingTap{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Setting" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"prefs:root=INTERNET_TETHERING",@"prefs:root=WIFI",@"prefs:root=General&path=About",nil];
    actionSheet.tag = 3;
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)intentApp{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"com.hebe.podtest:123242342"]];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag){
        case 1:{
            NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"tel://%@",@"13333333333"];
            switch (buttonIndex){
                case 0:{
                    //直接拨打,无提示
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
                }
                    break;
                case 1:{
                    //直接拨打,有提示
                    UIWebView *callview = [[UIWebView alloc] init];
                    [callview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:string]]];
                    [self.view addSubview:callview];
                }
                    break;
                case 2:{
                    //直接拨打,有提示 tel变telprompt
                    NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"13333333333"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
                }
                    break;
            }
        }
            break;
        case 2:{
            NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"sms://%@",@"13333333333"];
            switch (buttonIndex){
                case 0:{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
                }
                    break;
                case 1:{
                    if ([MFMessageComposeViewController canSendText]){
                        MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
                        messageComposeViewController.recipients = [NSArray arrayWithObject:@"10010"];
                        messageComposeViewController.body = @"test";
                        messageComposeViewController.messageComposeDelegate = self;
                        [self presentModalViewController:messageComposeViewController animated:YES];
                        [[[[messageComposeViewController viewControllers] lastObject] navigationItem] setTitle:@"测试"];
                    } else{
                        [Toast show:@"发送失败"];
                    }
                }
                    break;
            }
        }
            break;
        case 3:{
            NSLog([actionSheet buttonTitleAtIndex:buttonIndex]);
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[actionSheet buttonTitleAtIndex:buttonIndex]]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
        }
            break;
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissModalViewControllerAnimated:NO];
    switch (result){
        case MessageComposeResultCancelled:{
            [Toast show:@"MessageComposeResultCancelled"];
        }
            break;
        case MessageComposeResultFailed:{
            [Toast show:@"MessageComposeResultFailed"];
        }
            break;
        case MessageComposeResultSent:{
            [Toast show:@"MessageComposeResultSent"];
        }
            break;
    }
}
@end
