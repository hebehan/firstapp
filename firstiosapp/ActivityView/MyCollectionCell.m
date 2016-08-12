//
//  MyCollectionCell.m
//  firstiosapp
//
//  Created by Hebe on 16/7/25.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "MyCollectionCell.h"

@implementation MyCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        NSLog([[NSString alloc] initWithFormat:@"w=%f,h=%f",frame.size.width,frame.size.width]);
//        _textview = [[UITextView alloc] initWithFrame:CGRectMake((self.bounds.size.width + 32) / 2, (self.bounds.size.width + 32) / 2, 30, 30)];
//        _button = [[UIButton alloc] initWithFrame:CGRectMake((self.bounds.size.width - 32) / 2, (self.bounds.size.width - 32) / 2, 50, 50)];
//        _textview.backgroundColor = [UIColor colorWithRed:0.64 green:0.15 blue:0.15 alpha:1.00];
//        _button.backgroundColor = [UIColor colorWithRed:0.92 green:0.06 blue:0.14 alpha:1.00];
////        [_button addTarget:self action:@selector(testclick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_textview];
//        [self.contentView addSubview:_button];
        
        NSArray *arrayviews = [[NSBundle mainBundle] loadNibNamed:@"MyCollectionCell" owner:self options:nil];
        if (![[arrayviews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            NSLog(@"gun");
        }else{
            NSLog(@"gun12312");
        }
        self = [arrayviews objectAtIndex:0];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
