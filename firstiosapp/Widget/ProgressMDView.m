//
//  ProgressMDView.m
//  firstiosapp
//
//  Created by Hebe on 16/9/18.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "ProgressMDView.h"

@implementation ProgressMDView{
    CGFloat durning;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        durning = 2;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context,rect);
    CGFloat linewidth = 3;
    CGContextSetLineWidth(context,linewidth);
    CGFloat radius = MIN(rect.size.width/2,rect.size.height/2)-linewidth;


    CGContextSetStrokeColorWithColor(context,[UIColor blueColor].CGColor);
//    CGContextAddEllipseInRect(context,CGRectMake(rect.size.width/2-MIN(rect.size.width/2,rect.size.height/2)+linewidth,rect.size.height/2-MIN(rect.size.width/2,rect.size.height/2)+linewidth,MIN(rect.size.width,rect.size.height)-2*linewidth,MIN(rect.size.width,rect.size.height)-2*linewidth));
//    CGContextDrawPath(context,kCGPathStroke);
    CGContextAddArc(context,rect.size.width/2,rect.size.height/2,radius,0,360*(M_PI/180),0);
    CGContextDrawPath(context,kCGPathStroke);


    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    NSLog(@"half-width=%f",rect.size.width/2);
    CGContextDrawPath(context,kCGPathStroke);

}

@end
