//
//  ProgressCircleView.m
//  firstiosapp
//
//  Created by Hebe on 16/9/13.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "ProgressCircleView.h"

@implementation ProgressCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        self.maxValue = 100;
        self.currentValue = 0;
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
    CGFloat endangle = MIN(self.currentValue,self.maxValue)*1.0/self.maxValue*360*(M_PI/180);


    CGContextSetStrokeColorWithColor(context,[UIColor blueColor].CGColor);
//    CGContextAddEllipseInRect(context,CGRectMake(rect.size.width/2-MIN(rect.size.width/2,rect.size.height/2)+linewidth,rect.size.height/2-MIN(rect.size.width/2,rect.size.height/2)+linewidth,MIN(rect.size.width,rect.size.height)-2*linewidth,MIN(rect.size.width,rect.size.height)-2*linewidth));
//    CGContextDrawPath(context,kCGPathStroke);
    CGContextAddArc(context,rect.size.width/2,rect.size.height/2,radius,0,360*(M_PI/180),0);
    CGContextDrawPath(context,kCGPathStroke);


    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    NSLog(@"half-width=%f",rect.size.width/2);
    NSLog(@"endangle=%f radius=%f",endangle,radius);
    CGContextAddArc(context,rect.size.width/2,rect.size.height/2,radius,0,endangle,0);
    CGContextDrawPath(context,kCGPathStroke);

    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    NSLog([NSString stringWithFormat:@"%d%@", MIN(self.currentValue, 100),@"%"]);
    CGSize size = [[NSString stringWithFormat:@"%d%@", MIN(self.currentValue, 100), @"%"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(CGFLOAT_MAX,0) lineBreakMode:NSLineBreakByCharWrapping];
    [[NSString stringWithFormat:@"%d%@", MIN(self.currentValue, 100), @"%"] drawInRect:CGRectMake((rect.size.width-size.width)/2,(rect.size.height-size.height)/2,size.width,size.height) withFont:[UIFont systemFontOfSize:14] lineBreakMode:NSLineBreakByCharWrapping alignment:NSTextAlignmentCenter];

}
@end
