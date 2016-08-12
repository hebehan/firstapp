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

@interface LauncherView ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, retain)UIAlertView *alertView;
@end

@implementation LauncherView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Hello World";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
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

    return MyItems.count;
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


@end
