//
//  WeekSportChartView.m
//  firstiosapp
//
//  Created by Hebe on 16/9/10.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "WeekSportChartView.h"
#define count 7
@implementation WeekSportChartView{

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){

    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context,rect);

    NSInteger chartWidth = self.frame.size.width;
    NSInteger chartHeight = self.frame.size.height;
    CGFloat dashWidth = 20;
    CGFloat onefullWidth = (chartWidth-(count-1)*dashWidth)/count;
    NSLog(@"每个柱子宽=%f",onefullWidth);
    CGFloat maxHeight = chartHeight*0.85;
    CGFloat startx = 0;
    CGFloat starty = chartHeight*0.15;
    NSArray *keys = [self.datas allKeys];
    CGFloat maxValue=0;
    for (id key in keys){
        NSLog(@"数据key=%@,value=%@",key, [self.datas objectForKey:key]);
        if (maxValue < [[self.datas objectForKey:key] floatValue])
            maxValue = [[self.datas objectForKey:key] floatValue];
    }
    NSLog(@"最大值=%f",maxValue);
    double delayInSeconds = 1.0;
    __block WeekSportChartView *bself = self;
    dispatch_time_t delaytime = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delayInSeconds * NSEC_PER_SEC));
    for (int i = 0; i < count; ++i) {
//        dispatch_async(dispatch_get_main_queue(),^(void){
//            [bself delayDraw:context maxHeight:maxHeight starty:starty keys:keys i:i maxValue:maxValue startx:startx onefullWidth:onefullWidth dashWidth:dashWidth chartHeight:chartHeight];
//        });
//        dispatch_after(delaytime,dispatch_get_main_queue(),^(void){
//            [bself delayDraw:context maxHeight:maxHeight starty:starty keys:keys i:i maxValue:maxValue startx:startx onefullWidth:onefullWidth dashWidth:dashWidth chartHeight:chartHeight];
//        });
        CGFloat heighty = (maxHeight-starty) * [[self.datas objectForKey:[keys objectAtIndex:i]] floatValue] /maxValue;
        CGFloat widthx = startx+i*(onefullWidth+dashWidth);
//        负值反向绘制
//        CGRect oneRect = CGRectMake(widthx,maxHeight,onefullWidth,-heighty);
//        正值从上往下绘制
        CGRect oneRect = CGRectMake(widthx,maxHeight-heighty,onefullWidth,heighty);
        NSLog(@"区域%d的坐标为%@",i,NSStringFromCGRect(oneRect));
        CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
        CGContextFillRect(context,oneRect);
        CGContextDrawPath(context,kCGPathFill);
        NSString *key = [keys objectAtIndex:i];
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        [key drawInRect:CGRectMake(widthx,maxHeight,onefullWidth,chartHeight-maxHeight) withFont:[UIFont systemFontOfSize:12] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
    }
    [self setNeedsDisplay];
}

-(void)delayDraw:(CGContextRef)context maxHeight:(CGFloat) maxHeight starty:(CGFloat)starty keys:(NSArray *)keys i:(int)i maxValue:(CGFloat)maxValue startx:(CGFloat)startx onefullWidth:(CGFloat)onefullWidth dashWidth:(CGFloat)dashWidth chartHeight:(CGFloat)chartHeight {
    CGFloat heighty = (maxHeight-starty) * [[self.datas objectForKey:[keys objectAtIndex:i]] floatValue] /maxValue;
    CGFloat widthx = startx+i*(onefullWidth+dashWidth);
//        负值反向绘制
//        CGRect oneRect = CGRectMake(widthx,maxHeight,onefullWidth,-heighty);
//        正值从上往下绘制
    CGRect oneRect = CGRectMake(widthx,maxHeight-heighty,onefullWidth,heighty);
    NSLog(@"区域%d的坐标为%@",i,NSStringFromCGRect(oneRect));
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextFillRect(context,oneRect);
    CGContextDrawPath(context,kCGPathFill);
    NSString *key = [keys objectAtIndex:i];
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    [key drawInRect:CGRectMake(widthx,maxHeight,onefullWidth,chartHeight-maxHeight) withFont:[UIFont systemFontOfSize:12] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
}
@end
