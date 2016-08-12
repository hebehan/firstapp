//
//  MyTabCell.m
//  firstiosapp
//
//  Created by Hebe on 16/7/20.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "MyTabCell.h"

@interface MyTabCell()

@end

@implementation MyTabCell

int section1,row1;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textview = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _button = [[UIButton alloc] initWithFrame:CGRectMake(120, 0, 50, 50)];
        _textview.backgroundColor = [UIColor colorWithRed:0.64 green:0.15 blue:0.15 alpha:1.00];
        _button.backgroundColor = [UIColor colorWithRed:0.92 green:0.06 blue:0.14 alpha:1.00];
        [_button addTarget:self action:@selector(testclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_textview];
        [self.contentView addSubview:_button];
    }
    return self;
}

-(void)setName:(NSString *)name{
    _textview.text = name;
}

-(void)testclick:(UIButton *)sender{
    if (self.butclick) {
        self.butclick(sender);
//        _button.backgroundColor = [UIColor colorWithRed:0.20 green:0.62 blue:0.31 alpha:1.00];
    }
}

-(void)setClick:(int) section row:(int) row{
    section1 = section;
    row1 = row;
    _button.titleLabel.text = @"heh";
    [_button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
}

-(void)show{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"button" message:[[NSString alloc] initWithFormat:@"section=%d,row=%d",section1,row1] delegate:self cancelButtonTitle:@"calcle" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)show1{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"set" message:[[NSString alloc] initWithFormat:@"section=%d,row=%d",section1,row1] delegate:self cancelButtonTitle:@"calcle" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    [self show1];
    // Configure the view for the selected state
}

@end
