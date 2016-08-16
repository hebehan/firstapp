//
//  ListView.m
//  firstiosapp
//
//  Created by Hebe on 16/7/18.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "ListView.h"
#import "MyTabCell.h"

@interface ListView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation ListView
NSIndexPath *lastPath;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"List View";
    UIView *baseview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    baseview.backgroundColor = [[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1.0];
    [self.view addSubview:baseview];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0,20, baseview.frame.size.width, 50)];
    lable.backgroundColor = [[UIColor alloc] initWithRed:0.5 green:0.2 blue:0.8 alpha:1.0];    
    [baseview addSubview:lable];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.01f)];
//    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showalert1)];
//    tableView.tableHeaderView.userInteractionEnabled = YES;
//    [tableView addGestureRecognizer:gest];
//    tableView.tableHeaderView = nil;
//    tableView.tableFooterView setHidden:YES;
    [baseview addSubview:tableView];
    
    //UITableViewController 特有的。。
//    [self.tableView setSeparatorColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0]];
//    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    

}
-(void)showalert1{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"sb" message:@"sb" delegate:self cancelButtonTitle:@"sb" otherButtonTitles:nil, nil];
    [view show];
}

-(void)showalert:(UITapGestureRecognizer *) tap{
    UIView *temp = [tap view];
    NSLog([[NSString alloc] initWithFormat:@"head222 section=%ld",temp.tag]);

    NSString *msg = [[NSString alloc] initWithFormat:@"%ld",temp.tag];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:msg message:msg delegate:self cancelButtonTitle:msg otherButtonTitles:nil, nil];
    [view show];
}

//有多少大区 大区编号用 indexPath.section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
//每个大区多少小区 小区编号用indexPath.row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog([[NSString alloc] initWithFormat:@"head333 section=%ld",(long)section]);
//    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showalert:)];
//    tableView.tableHeaderView.userInteractionEnabled = YES;
//    //    NSLog([[NSString alloc] initWithFormat:@"head111 section=%ld",(long)section]);
//    tableView.tag = section;
//    [tableView addGestureRecognizer:gest];
    return 5;
}
//相当于getview
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     MyTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[MyTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setName:@"caonima"];
//    [cell setClick:indexPath.section row: indexPath.row];
//    __weak MyTabCell *weakCell = cell;
    cell.butclick = ^(UIButton *button){
        [self show:indexPath];
//        weakCell.backgroundColor = color;
        if (lastPath != nil && lastPath != indexPath) {
            [tableView reloadRowsAtIndexPaths:@[lastPath] withRowAnimation:NO];
        }
        button.backgroundColor = [UIColor colorWithRed:0.20 green:0.62 blue:0.31 alpha:1.00];
        lastPath = indexPath;
        
    };
//    UIImage *icon = [UIImage imageNamed:@"1"];
//    CGSize itemSize = CGSizeMake(30, 30);
//    UIGraphicsBeginImageContextWithOptions(itemSize, NO ,0.0);
//    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
//    [icon drawInRect:imageRect];
//    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    cell.imageView.image = icon;
//    cell.backgroundColor = [[UIColor alloc] initWithRed:0.1*indexPath.section green:0.1*indexPath.section blue:0.1*indexPath.section alpha:1.0];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)show:(NSIndexPath *)indexPath{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"button" message:[[NSString alloc] initWithFormat:@"section=%ld,row=%ld",(long)indexPath.section,(long)indexPath.row] delegate:self cancelButtonTitle:@"calcle" otherButtonTitles:nil, nil];
    [alertView show];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MyTabCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell setClick:indexPath.section row: indexPath.row];
    UIAlertView *alerview = [[UIAlertView alloc] initWithTitle:@"hehe" message:@"hehe" delegate:self cancelButtonTitle:[[NSString alloc] initWithFormat:@"section=%ld,row=%ld",(long)indexPath.section,(long)indexPath.row] otherButtonTitles:nil, nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//点击变色恢复
    [alerview show];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    tableView.tableHeaderView = nil;
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showalert:)];
    tableView.tableHeaderView.userInteractionEnabled = YES;
//    NSLog([[NSString alloc] initWithFormat:@"head111 section=%ld",(long)section]);
    tableView.tableHeaderView.tag = section;
    tableView.tableHeaderView.userInteractionEnabled = YES;
    [tableView.tableHeaderView addGestureRecognizer:gest];

    return [[NSString alloc] initWithFormat:@"head section=%ld",section];
//    return nil;
}
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    
////    return [[NSString alloc] initWithFormat:@"foot section=%ld",(long)section];
//    return nil;
//}

@end
