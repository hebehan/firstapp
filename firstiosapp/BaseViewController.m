//
//  BaseViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/7/25.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (retain, nonatomic)UIAlertView *alertView;
@end

@implementation BaseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_alertView){
        _alertView = [[UIAlertView alloc] init];
    }
    _alertView.delegate = self;
    _NavigationHeight = self.navigationController.navigationBar.frame.size.height;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netNotification:) name:@"netstate" object:nil];
//    [[UIScreen mainScreen] bounds].size.height
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlert:(NSString *)title message:(NSString *)message{
    _alertView.title = title;
    _alertView.message = message;
//    [_alertView setCancelButtonIndex:[_alertView addButtonWithTitle:@"OK"]];
//    [_alertView setCancelButtonIndex:-1];
    [_alertView show];
}



- (void)setStatusBarState:(UIStatusBarStyle)style {
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:YES];
}

//-(void)netNotification:(NSNotification *)notification{
//    NSLog(@"hahaha");
//    if ([[notification object] isEqual:@"YES"]){
//        if (_alertView){
//            [_alertView dismissWithClickedButtonIndex:-10086 animated:NO];
//        }
//    } else{
//        [self showAlert:@"提示" message:@"网络已断开!"];
//    }
//    NSLog([notification object]);
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
