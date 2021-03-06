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
#define MyItems @[@"常见View",@"UITableView",@"UICollectionView",@"网络相关",@"系统通知",@"UITabBarController",@"动画",@"手势",@"选图拍照",@"相关跳转",@"设备信息",@"UITextFiled",@"自定义画线等",@"自定义动动动",@"3DTOUCH",@"日语五十音",@"XibAutoLayout",@"CodeAutoLayout",@"定位",@"百度地图"]
typedef NS_ENUM (NSInteger ,ItemType){
    ItemTypeNormalView = 0,
    ItemTypeTableView,
    ItemTypeCollectionView,
    ItemTypeNetView,
    ItemTypeNotificationView,
    ItemTypeUITabBarController,
    ItemTypeAnimation,
    ItemTypeGesRec,
    ItemTypePhoto,
    ItemTypeIntent,
    ItemTypeDeviceInfo,
    ItemTypeUITextFiled,
    ItemTypeBaseDraw,
    ItemTypeMotionDraw,
    ItemType3DTOUCH,
    ItemTypeJapaness,
    ItemTypeAutoLayout,
    ItemTypeCodeAutoLayout,
    ItemTypeLocation,
    ItemTypeBaiDuMap
};

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define StatusBarHeight    20
#define TabBarHeight       49
#define NavBarHeight       44
#define StartY             64
#define NormalHeight       [UIScreen mainScreen].bounds.size.height-20-44
#define KEYBORD_HEIGHT     258
static NSString *baseurl = @"http://www.66liuliang.com/12321/index.php/";

#endif
