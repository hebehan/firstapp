//
//  AppConstant.h
//  firstiosapp
//
//  Created by Hebe on 16/7/29.
//  Copyright (c) 2016 Hebe. All rights reserved.
//
#ifndef AppConstant_h
#import "UIKit/UIKit.h"
static const NSString *hello=@"heheh";
#define PI 3.14;
#define MyItems @[@"常见View",@"UITableView",@"UICollectionView",@"网络相关"]
typedef NS_ENUM (NSInteger ,ItemType){
    ItemTypeNormalView = 0,
    ItemTypeTableView,
    ItemTypeCollectionView,
    ItemTypeNetView
};

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define STATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height);
static NSString *baseurl = @"http://www.66liuliang.com/12321/index.php/";

#endif