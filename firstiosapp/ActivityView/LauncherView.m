//
//  LauncherView.m
//  firstiosapp
//
//  Created by Hebe on 16/7/30.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "LauncherView.h"
#import "NormalViewController.h"
#import "ListView.h"
#import "CollectionView.h"
#import "NetViewController.h"
#import "NotificationViewController.h"
#import "BaseTabBarController.h"
#import "AnimationViewController.h"
#import "HebeVCAT.h"
#import "MyGesRecViewController.h"
#import "TakePhotoViewController.h"
#import "IntentViewController.h"
#import "DeviceInfoViewController.h"
#import "UITextFiledViewController.h"
#import "SelfDrawViewController.h"
#import "MotionViewController.h"
#import "SanDTOUCHViewController.h"
#import "Utils.h"
#import "JapannessViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "ALXibViewController.h"

@interface LauncherView ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIViewControllerTransitioningDelegate,UIAlertViewDelegate>
@property (nonatomic, retain)UIAlertView *alertView;
@end

@implementation LauncherView{
    HebeVCAT *hebeVCAT;
    BaseTabBarController *tabBarController1;
    BOOL istouch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Hello World";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    hebeVCAT = [HebeVCAT new];
    
//    if (!istouch) {
//        LAContext *context = [[LAContext alloc] init];
//        NSError *error;
//        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
//            [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"测试touchid" reply:^(BOOL success, NSError * _Nullable error) {
//                if (success) {
//                    NSLog(@"Touch ID 成功啦！！");
//                }else{
//                    NSLog(@"Touch ID 失败啦！！");
//                    NSLog(@"%@",error.description);
//                    exit(0);
//                }
//            }];
//        }
//    }

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        //代码创建3D touch 图标
        // 创建标签的ICON图标。
//    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];//使用系统图标
        UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"bingo.png"];//自定义图标
        // 创建一个标签，并配置相关属性。
        UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"2" localizedTitle:@"么么哒" localizedSubtitle:@"爱你呦" icon:icon userInfo:nil];
        // 将标签添加进Application的shortcutItems中。
        [UIApplication sharedApplication].shortcutItems = @[item];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(on3DTouch:) name:@"3DTOUCH" object:nil];
    }

    
}

-(void)on3DTouch:(NSNotification*)notification {
    if ([notification.object isKindOfClass:[UIApplicationShortcutItem class]]) {
        UIApplicationShortcutItem *item = notification.object;
        if ([item.type isEqualToString:@"0"]) {
            [self.navigationController pushViewController:[[NetViewController alloc] init] animated:YES];
        }
        NSLog(@"成了");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        return MyItems.count;
    } else{
        return [Utils removeObjectFromArrayByKey:@"3DTOUCH" array:MyItems].count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.textLabel.text = [MyItems objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self showAlert:@"launcher" message:[MyItems objectAtIndex:indexPath.row]];
//    [self showPush:indexPath.row];
    switch (indexPath.row){
        case ItemTypeNormalView:
            [self.navigationController pushViewController:[[NormalViewController alloc] init] animated:YES];
            break;
        case ItemTypeTableView:
            [self.navigationController pushViewController:[[ListView alloc] init] animated:YES];
            break;
        case ItemTypeCollectionView:
            [self.navigationController pushViewController:[[CollectionView alloc] init] animated:YES];
            break;
        case ItemTypeNetView:
            [self.navigationController pushViewController:[[NetViewController alloc] init] animated:YES];
            break;
        case ItemTypeNotificationView:
            [self.navigationController pushViewController:[[NotificationViewController alloc] init] animated:YES];
            break;
        case ItemTypeUITabBarController:
            tabBarController1 = [[BaseTabBarController alloc] init];
            tabBarController1.transitioningDelegate = self;
            [self presentModalViewController:tabBarController1 animated:YES];
            break;
        case ItemTypeAnimation:
            [self.navigationController pushViewController:[[AnimationViewController alloc] init] animated:YES];
            break;
        case ItemTypeGesRec:
            [self.navigationController pushViewController:[[MyGesRecViewController alloc] init] animated:YES];
            break;
        case ItemTypePhoto:
            [self.navigationController pushViewController:[[TakePhotoViewController alloc] init] animated:YES];
            break;
        case ItemTypeIntent:
            [self.navigationController pushViewController:[[IntentViewController alloc] init] animated:YES];
            break;
        case ItemTypeDeviceInfo:
            [self.navigationController pushViewController:[[DeviceInfoViewController alloc] init] animated:YES];
            break;
        case ItemTypeUITextFiled:
            [self.navigationController pushViewController:[[UITextFiledViewController alloc] init] animated:YES];
            break;
        case ItemTypeBaseDraw:
            [self.navigationController pushViewController:[[SelfDrawViewController alloc] init] animated:YES];
            break;
        case ItemTypeMotionDraw:
            [self.navigationController pushViewController:[[MotionViewController alloc] init] animated:YES];
            break;
        case ItemType3DTOUCH:
            [self.navigationController pushViewController:[[SanDTOUCHViewController alloc] init] animated:YES];
            break;
        case ItemTypeJapaness:
            [self.navigationController pushViewController:[[JapannessViewController alloc] init] animated:YES];
            break;
        case ItemTypeAutoLayout:
            [self.navigationController pushViewController:[[ALXibViewController alloc] init] animated:YES];
            break;
    }
}

-(void)showPush:(NSInteger)type{
    _alertView = [[UIAlertView alloc] initWithTitle:@"选择跳转方式" message:nil delegate:self cancelButtonTitle:@"push跳转" otherButtonTitles:@"present跳转",nil];
    _alertView.tag = type;
    [_alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog([[NSString alloc] initWithFormat:@"buttonIndex=%d",buttonIndex]);
    switch (buttonIndex){
        case 0:
            switch (alertView.tag){
                case ItemTypeNormalView:
                    [self.navigationController pushViewController:[[NormalViewController alloc] init] animated:YES];
                    break;
                case ItemTypeTableView:
                    [self.navigationController pushViewController:[[ListView alloc] init] animated:YES];
                    break;
                case ItemTypeCollectionView:
                    [self.navigationController pushViewController:[[CollectionView alloc] init] animated:YES];
                    break;
                case ItemTypeNetView:
                    [self.navigationController pushViewController:[[NetViewController alloc] init] animated:YES];
                    break;
            }
            break;
        case 1:
            switch (alertView.tag){
                case ItemTypeNormalView:
                    [self presentViewController:[[NormalViewController alloc] init] animated:YES completion:^(){
                        NSLog(@"跳转完成??");
                    }];
                    break;
                case ItemTypeTableView:
                    [self presentViewController:[[ListView alloc] init] animated:YES completion:^(){
                        NSLog(@"跳转完成??");
                    }];
                    break;
                case ItemTypeCollectionView:
                    [self presentViewController:[[CollectionView alloc] init] animated:YES completion:^(){
                        NSLog(@"跳转完成??");
                    }];
                    break;
                case ItemTypeNetView:
                    [self presentViewController:[[NetViewController alloc] init] animated:YES completion:^(){
                        NSLog(@"跳转完成??");
                    }];
                    break;
            }
            break;
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return hebeVCAT;
}
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return hebeVCAT;
}

@end
