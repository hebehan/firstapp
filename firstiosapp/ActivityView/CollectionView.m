//
//  CollectionView.m
//  firstiosapp
//
//  Created by Hebe on 16/7/21.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "CollectionView.h"
#import "MyCollectionCell.h"

@interface CollectionView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong,nonatomic)UICollectionView *colectionview;
@end

@implementation CollectionView

- (void)viewDidLoad {
    [super viewDidLoad];
//    UICollectionViewLayout *uvl = [[UICollectionViewLayout alloc] init];
//    uvl
//    [self.view addSubview:uvl];
    UICollectionViewFlowLayout *uvfl = [[UICollectionViewFlowLayout alloc] init];
    [uvfl setScrollDirection:UICollectionViewScrollDirectionVertical];
    
//    UICollectionView *collection = [[UICollectionView alloc] init];
//    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:uvfl];
    _colectionview = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:uvfl];
    _colectionview.dataSource = self;
    _colectionview.delegate = self;
    [self.view addSubview:_colectionview];
    _colectionview.backgroundColor = [UIColor colorWithRed:0.39 green:0.67 blue:0.41 alpha:1.00];
    [_colectionview registerClass:[MyCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UICollectionViewDataSource 
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyCollectionCell alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    }
    cell.label.text = [[NSString alloc] initWithFormat:@"s%ld,r%ld",(long)indexPath.section,(long)indexPath.row];
    cell.label.textColor = [UIColor blackColor];
    UIImage *image = [UIImage imageNamed:@"1"];
    cell.imageview.image = image;
//    [cell.button addTarget:self action:@selector(showDialog:) forControlEvents:UIControlEventTouchUpInside];
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
//    lable.backgroundColor = [UIColor colorWithRed:1.00 green:0.77 blue:0.21 alpha:1.00];
//    lable.text= @"caonima";
//    lable.textColor = [UIColor colorWithRed:0.92 green:0.06 blue:0.14 alpha:1.00];
//    section = indexPath.section;
//    row = indexPath.row;
//    
//    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDialog:)];
//    lable.userInteractionEnabled = YES;
//    lable.text = [[NSString alloc] initWithFormat:@"s%ld,r%ld",(long)indexPath.section,(long)indexPath.row];
//    [lable addGestureRecognizer:gest];
//    [cell.contentView addSubview:lable];
    return cell;
}
NSInteger section,row;
-(void) showDialog:(UIButton *)sender{
    NSLog(@"click");
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        NSLog(@"ok");
    }
    if ([sender isKindOfClass:[UILabel class]]) {
        NSLog(@"o1k");
    }
    if([sender isKindOfClass:[UICollectionViewCell class]]) {
        NSLog(@"o2k");
    }
    UICollectionViewCell *cell = (UICollectionViewCell *)sender.superview.superview;
    //    (UITapGestureRecognizer *)send
//    UIView *v = [sender superview];
//    UICollectionViewCell *cell = (UICollectionViewCell *)[v superview];
    NSIndexPath *path = [_colectionview indexPathForCell:cell];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"dfd" message:[[NSString alloc] initWithFormat:@"section=%ld,row=%ld",(long)path.section,(long)path.row] delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:nil, nil];
    [view show];
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小 
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog([[NSString alloc] initWithFormat:@"sec=%ld,row=%ld",(long)indexPath.section,(long)indexPath.row],nil);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
