//
//  BaseViewController.h
//  firstiosapp
//
//  Created by Hebe on 16/7/25.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController
-(void)showAlert:(NSString *)title message:(NSString *)message;
-(void)setStatusBarState:(NSInteger)type;
@property (nonatomic)CGFloat NavigationHeight;
@property(copy,nonatomic)void(^alertClick)(UIAlertView *sender,NSInteger index);

@end
