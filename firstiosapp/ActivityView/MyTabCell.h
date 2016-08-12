//
//  MyTabCell.h
//  firstiosapp
//
//  Created by Hebe on 16/7/20.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabCell : UITableViewCell
@property (nonatomic,retain) UITextView *textview;
@property (nonatomic,retain) UIButton *button;

-(void)setName:(NSString *)name;
-(void)setClick:(int) section row:(int) row;
@property(copy,nonatomic)void(^butclick)(UIButton *sender);
@end
