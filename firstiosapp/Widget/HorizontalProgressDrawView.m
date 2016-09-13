//
//  HorizontalProgressDrawView.m
//  firstiosapp
//
//  Created by Hebe on 16/9/12.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "HorizontalProgressDrawView.h"

@implementation HorizontalProgressDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        self.maxValue = 100;
        self.currentValue = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
//    CAShapeLayer *roundBg = [CAShapeLayer layer];
//    roundBg.frame = rect;
//    roundBg.lineWidth = 3;
//    roundBg.strokeColor = [UIColor redColor].CGColor;
//    roundBg.fillColor = [UIColor blueColor].CGColor;
//    //指定角UIRectCornerBottomLeft|UIRectCornerTopRight
//    roundBg.path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(roundBg.frame.size.width/2,roundBg.frame.size.height/2)].CGPath;
//    [self.layer addSublayer:roundBg];

//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.fromValue = [NSNumber numberWithFloat:0.0f];
//    animation.toValue = [NSNumber numberWithFloat:1.0f];
//    animation.duration = 1;
//    [roundBg addAnimation:animation forKey:@""];

//    roundBg = [CAShapeLayer layer];
//    CGFloat dashwidth = 4;
//    CGFloat currentWidth = MIN(self.currentValue,100)*1.0/self.maxValue * (rect.size.width-(4*dashwidth));
//    roundBg.frame = CGRectMake(rect.origin.x+dashwidth,rect.origin.y+dashwidth,currentWidth,rect.size.height-dashwidth*4);
//    roundBg.path = [UIBezierPath bezierPathWithRoundedRect:roundBg.frame cornerRadius:roundBg.frame.size.height/2].CGPath;
//    roundBg.fillColor = [UIColor grayColor].CGColor;
//    [self.layer addSublayer:roundBg];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,3);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddRect(context,rect);
    CGContextDrawPath(context,kCGPathFillStroke);

    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGFloat dashwidth = 4;
    CGFloat currentWidth = MIN(self.currentValue,100)*1.0/self.maxValue * (rect.size.width-(2*dashwidth));
    CGRect roundRect = CGRectMake(rect.origin.x,rect.origin.y,currentWidth,rect.size.height-dashwidth*2);

//    CGFloat radius = 4;
//    CGFloat minx = CGRectGetMinX(roundRect), midx = CGRectGetMidX(roundRect), maxx = CGRectGetMaxX(roundRect);
//    CGFloat miny = CGRectGetMinY(roundRect), midy = CGRectGetMidY(roundRect), maxy = CGRectGetMaxY(roundRect);
//    CGContextMoveToPoint(context, minx, midy);
//    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);//左上角
//    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);//右上角
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);//右下角
//    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);//左下角

    CGFloat width = roundRect.size.width;
    CGFloat height = roundRect.size.height;
    // 简便起见，这里把圆角半径设置为长和宽平均值的1/10
    CGFloat radius = MIN(roundRect.size.height/2,currentWidth/2);
    NSLog(@"radius=%f",radius);

    // 获取CGContext，注意UIKit里用的是一个专门的函数
//    CGContextRef context = UIGraphicsGetCurrentContext();
    // 移动到初始点
//    CGContextMoveToPoint(context, radius, 0);

    // 绘制第1条线和第1个1/4圆弧
//    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius+dashwidth, radius+dashwidth, radius, -0.5 * M_PI, 0.0, 0);

    // 绘制第2条线和第2个1/4圆弧
//    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArc(context, width - radius+dashwidth, height - radius+dashwidth, radius, 0.0, 0.5 * M_PI, 0);

    // 绘制第3条线和第3个1/4圆弧
//    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArc(context, radius+dashwidth, height - radius+dashwidth, radius, 0.5 * M_PI, M_PI, 0);

    // 绘制第4条线和第4个1/4圆弧
//    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius+dashwidth, radius+dashwidth, radius, M_PI, 1.5 * M_PI, 0);

    // 闭合路径
    CGContextClosePath(context);

    CGContextClosePath(context);
//    CGContextAddRect(context,roundRect);
    CGContextDrawPath(context,kCGPathFill);

    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    NSLog([NSString stringWithFormat:@"%d%@", MIN(self.currentValue, 100),@"%"]);
    CGSize size = [[NSString stringWithFormat:@"%d%@", MIN(self.currentValue, 100), @"%"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(CGFLOAT_MAX,0) lineBreakMode:NSLineBreakByCharWrapping];
    [[NSString stringWithFormat:@"%d%@", MIN(self.currentValue, 100), @"%"] drawInRect:CGRectMake((rect.size.width-size.width)/2,(rect.size.height-size.height)/2,size.width,size.height) withFont:[UIFont systemFontOfSize:14] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];
}

- (void)drawRect345234234:(CGRect)rect {
    CAShapeLayer *roundBg = [CAShapeLayer layer];
    roundBg.frame = rect;
    roundBg.lineWidth = 3;
    roundBg.strokeColor = [UIColor redColor].CGColor;
    roundBg.fillColor = [UIColor blueColor].CGColor;
    //指定角UIRectCornerBottomLeft|UIRectCornerTopRight
    roundBg.path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(roundBg.frame.size.width/2,roundBg.frame.size.height/2)].CGPath;
    [self.layer addSublayer:roundBg];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSNumber *fromvalue = [NSNumber numberWithFloat: MIN(MAX(self.currentValue-1,0),100)*1.0/ self.maxValue];
    NSNumber *tovalue = [NSNumber numberWithFloat: MIN(self.currentValue,100)*1.0/ self.maxValue];
    animation.fromValue = fromvalue;
    animation.toValue = tovalue;
    animation.duration = 0.1;

    roundBg = [CAShapeLayer layer];
    CGFloat dashwidth = 4;
    roundBg.lineWidth = 3;
//    CGFloat currentWidth = MIN(self.currentValue,100)*1.0/self.maxValue * (rect.size.width-(4*dashwidth));
    CGFloat allWidth = 1.0 * (rect.size.width-(4*dashwidth));
    roundBg.frame = CGRectMake(rect.origin.x+dashwidth,rect.origin.y+2*dashwidth,allWidth,rect.size.height-dashwidth*3);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,nil,roundBg.frame.origin.x,roundBg.frame.origin.y-dashwidth);
    CGPathAddLineToPoint(path,nil,roundBg.frame.origin.x+allWidth,roundBg.frame.origin.y-dashwidth);

    roundBg.lineWidth = roundBg.frame.size.height;

    CGFloat width = roundBg.frame.size.width;
    CGFloat height = roundBg.frame.size.height;
    CGFloat currentWidth = MIN(self.currentValue,100)*1.0/self.maxValue * (rect.size.width-(2*dashwidth));
    // 简便起见，这里把圆角半径设置为长和宽平均值的1/10
    CGFloat radius = MIN(height/2,currentWidth/2);
    NSLog(@"radius=%f",radius);

    // 获取CGContext，注意UIKit里用的是一个专门的函数
//    CGContextRef context = UIGraphicsGetCurrentContext();
    // 移动到初始点
//    CGContextMoveToPoint(context, radius, 0);

    // 绘制第1条线和第1个1/4圆弧
//    CGContextAddLineToPoint(context, width - radius, 0);
    CGPathAddArc(path,nil,width - radius+dashwidth, radius+dashwidth, radius, -0.5 * M_PI, 0.0, NO);
    CGPathAddArc(path,nil,width - radius+dashwidth, height - radius+dashwidth, radius, 0.0, 0.5 * M_PI, NO);
    CGPathAddArc(path,nil,radius+dashwidth, height - radius+dashwidth, radius, 0.5 * M_PI, M_PI, NO);
    CGPathAddArc(path,nil,radius+dashwidth, radius+dashwidth, radius, M_PI, 1.5 * M_PI, NO);

    roundBg.path = path;
//    roundBg.path = [UIBezierPath bezierPathWithRoundedRect:roundBg.frame cornerRadius:roundBg.frame.size.height/2].CGPath;
    roundBg.strokeColor = [UIColor grayColor].CGColor;
    roundBg.fillColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:roundBg];
    [roundBg addAnimation:animation forKey:@""];
}
@end
