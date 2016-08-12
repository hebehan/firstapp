//
//  MyCollectionCell.h
//  firstiosapp
//
//  Created by Hebe on 16/7/25.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionCell : UICollectionViewCell
@property (nonatomic,retain) UITextView *textview;
@property (nonatomic,retain) UIButton *button;
@property (nonatomic,retain) IBOutlet UIImageView *imageview;
@property (nonatomic,retain) IBOutlet UILabel *label;
@end
