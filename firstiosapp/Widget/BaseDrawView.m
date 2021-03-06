//
//  BaseDrawView.m
//  firstiosapp
//
//  Created by Hebe on 16/9/6.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "BaseDrawView.h"

@implementation BaseDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){

    }
    return self;
}

#pragma mark 开始画
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGRect frame = CGRectMake(0,StartY,200,100);
//    CGContextFillRect(context,frame);
//    [[UIColor orangeColor] set];
//    CGContextFillPath(context);

//    [[UIColor whiteColor] set];
    const CGFloat linecolor[] = {1,1,1,1.0};
    CGContextSetFillColor(context,linecolor);
    CGContextFillRect(context,rect);
    CGContextFillPath(context);
    [self drawLine:context];
    [self drawDashLine:context];
    [self drawDashLine2:context];
    [self drawCircle:context];
    [self drawDashCircle:context];
    [self drawFillCircleWithoutLine:context];
    [self drawFillCircleWithLine:context];
    [self drawTuoYuan:context];
    [self drawBeiSaiEr:context];
    [self drawText:context];
    [self drawPic:context];
    [self drawRectangle:context];
    [self drawTriangle:context];
    [self drawAnyAngle:context count:3 radius:50 center:CGPointMake(250,350)];
    [self drawAnyAngleByCALayer:context count:5 radius:50 center:CGPointMake(100,350)];

}

/**
 * 画实线
 * @param context
 */
-(void)drawLine:(CGContextRef)context{
    CGContextSetLineWidth(context,2.0f);
    const CGFloat linecolor[] = {1,0,0,1.0};
    CGContextSetStrokeColor(context,linecolor);
//    CGContextSetRGBStrokeColor(context,255, 100, 100, 1);
    CGContextMoveToPoint(context,0,10);
    CGContextAddLineToPoint(context,200,10);
    CGContextStrokePath(context);
    
}

/**
 * 画虚线
 * @param context
 */
-(void)drawDashLine:(CGContextRef)context{
    CAShapeLayer *dashLine = [CAShapeLayer layer];
    dashLine.lineWidth = 2.0f;
//    [dashLine setBounds:self.bounds];
//    [dashLine setPosition:self.center];
//    [dashLine setFrame:CGRectMake(0,40,200,40)];
    dashLine.strokeColor = [UIColor cyanColor].CGColor;
    [dashLine setLineJoin:kCALineJoinRound];
    [dashLine setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:20], [NSNumber numberWithInt:10],nil]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,nil,0,40);
    CGPathAddLineToPoint(path,nil,300,40);
    [dashLine setPath:path];
    [self.layer addSublayer:dashLine];
    CGPathRelease(path);
}

/**
 * 画虚线2
 * @param context
 */
-(void)drawDashLine2:(CGContextRef)context{
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGFloat lengths[] = {10,20,10};
    CGContextSetLineDash(context, 0, lengths,3);//最后一个值是lengths 长度
    CGContextMoveToPoint(context, 0, 60.0);
    CGContextAddLineToPoint(context, 300,60.0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

/**
 * 画实线圆
 * @param context
 */
-(void)drawCircle:(CGContextRef)context{
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextSetLineWidth(context,2.0f);
    CGFloat lengths[] = {};
    CGContextSetLineDash(context,0,lengths,0);
    CGContextAddArc(context,30,100,20,0,2*M_PI,0);
    CGContextDrawPath(context,kCGPathStroke);

    CGContextStrokeEllipseInRect(context,CGRectMake(0,100,44,44));

}

/**
 * 画虚线圆
 * @param context
 */
-(void)drawDashCircle:(CGContextRef)context{
    CGContextSetRGBStrokeColor(context,0,1,1,1.0);
    CGContextSetLineWidth(context,2.0f);
    CGFloat lengths[] = {5,5};
    CGContextSetLineDash(context,0,lengths,2);
    CGContextAddArc(context,80,100,20,0,2*M_PI,0);
    CGContextDrawPath(context,kCGPathStroke);
}
/**
 *画不带边的圆
 * @param context
 */
-(void)drawFillCircleWithoutLine:(CGContextRef)context{
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddArc(context,130,100,20,0,2*M_PI,0);
    CGContextDrawPath(context,kCGPathFill);
}

/**
 * 画带边的圆
 * @param context
 */
-(void)drawFillCircleWithLine:(CGContextRef)context{
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context,3.0f);
    CGFloat lengths[] = {};
    CGContextSetLineDash(context,0,lengths,0);
    CGContextAddArc(context,180,100,20,0,2*M_PI,0);
    CGContextDrawPath(context,kCGPathFillStroke);
}
/**
 * 画椭圆
 * @param context
 */
-(void)drawTuoYuan:(CGContextRef)context{
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextAddEllipseInRect(context,CGRectMake(0,150,70,30));
    CGContextSetLineWidth(context,3.0f);
//    CGFloat lengths[] = {5,5};
//    CGContextSetLineDash(context,0,lengths,2);
    CGContextDrawPath(context,kCGPathFillStroke);
}

/**
 * 画贝塞尔曲线
 * @param context
 */
-(void)drawBeiSaiEr:(CGContextRef)context{
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context,80,150);
    CGContextAddQuadCurveToPoint(context,115,45,150,150);//二次曲线第二个是x点,第三个是y点 最后的是终点
    CGContextAddCurveToPoint(context,200,50,250,250,300,150);//三次曲线第二个点,第三个点 终点
    CGFloat lengths[] = {5,5};
    CGContextSetLineDash(context,0,lengths,2);
//    CGContextStrokePath(context);
    CGContextDrawPath(context,kCGPathStroke);
}

/**
 * 写字画背景
 * @param context
 */
-(void)drawText:(CGContextRef)context{
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextAddRect(context,CGRectMake(10,300,50,20));
    CGContextDrawPath(context,kCGPathFillStroke);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    [@"hahahaha" drawInRect:CGRectMake(10,300,50,20) withFont:[UIFont systemFontOfSize:10]];
}

/**
 * 绘图
 * @param context
 */
-(void)drawPic:(CGContextRef)context{
    UIImage *image = [UIImage imageNamed:@"1.png"];
    [image drawInRect:CGRectMake(80,200,80,40)];//内容大小
    [image drawAtPoint:CGPointMake(200,200)];//原图大小
    CGContextDrawImage(context, CGRectMake(10,200,50,20), image.CGImage);//内容大小
}

/**
 * 画正方形
 * @param context
 */
-(void)drawRectangle:(CGContextRef)context{
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddRect(context,CGRectMake(10,250,30,20));
    CGContextDrawPath(context,kCGPathFillStroke);
}

/**
 * 画三角形
 * @param context
 */
-(void)drawTriangle:(CGContextRef)context{
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor cyanColor].CGColor);
    CGContextMoveToPoint(context,40,250);
    CGContextAddLineToPoint(context,80,250);
    CGContextAddLineToPoint(context,60,300);
    CGContextClosePath(context);
    CGContextDrawPath(context,kCGPathFillStroke);
}

-(void)drawAnyAngle:(CGContextRef)context count:(NSInteger)count radius:(NSInteger)radius center:(CGPoint)center{
    double singleangle = 2*M_PI/count;
    double nextangle = 0;
    double startAngle = M_PI_2-singleangle/2;
    double sidelen = 2*radius*sin(singleangle/2);
    NSLog(@"边长是=%f",sidelen);
    NSLog(@"每个角度是%f",singleangle*180/M_PI);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextMoveToPoint(context,center.x+radius*cos(startAngle),center.y+sin(startAngle)*radius);
    NSLog(@"start坐标是(%f,%f)",center.x+cos(nextangle)*radius,center.y+sin(nextangle)*radius);
    NSLog(@"start角度是%f",startAngle*180/M_PI);
    CGFloat lengths[] = {};
    CGContextSetLineDash(context,0,lengths,0);
    for (int i = 0; i <= count; ++i) {
        nextangle = startAngle+i*singleangle;
        NSLog(@"角度是%f",nextangle*180/M_PI);
        NSLog(@"下一次坐标是(%f,%f)",center.x+cos(nextangle)*radius,center.y+sin(nextangle)*radius);
        CGContextAddLineToPoint(context,center.x+cos(nextangle)*radius,center.y+sin(nextangle)*radius);
    }
    CGContextClosePath(context);
    CGContextDrawPath(context,kCGPathStroke);
}

/**
 * 画任意多边形用CAShapeLayer
 * @param context
 * @param count
 * @param radius
 * @param center
 */
-(void)drawAnyAngleByCALayer:(CGContextRef)context count:(NSInteger)count radius:(NSInteger)radius center:(CGPoint)center{
    CAShapeLayer *anyangle = [CAShapeLayer layer];
    anyangle.lineWidth = 1.0f;
//    [dashLine setBounds:self.bounds];
//    [dashLine setPosition:self.center];
//    [dashLine setFrame:CGRectMake(0,40,200,40)];
    anyangle.strokeColor = [UIColor cyanColor].CGColor;
    anyangle.fillColor = [UIColor yellowColor].CGColor;
    [anyangle setLineJoin:kCALineJoinRound];
//    [anyangle setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:20], [NSNumber numberWithInt:10],nil]];
    CGMutablePathRef path = CGPathCreateMutable();

    double singleangle = 2*M_PI/count;
    double nextangle = 0;
    double startAngle = M_PI_2-singleangle/2;
    double sidelen = 2*radius*sin(singleangle/2);
    NSLog(@"边长是=%f",sidelen);
    NSLog(@"每个角度是%f",singleangle*180/M_PI);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGPathMoveToPoint(path,nil,center.x+radius*cos(startAngle),center.y+sin(startAngle)*radius);
    NSLog(@"start坐标是(%f,%f)",center.x+cos(nextangle)*radius,center.y+sin(nextangle)*radius);
    NSLog(@"start角度是%f",startAngle*180/M_PI);
    for (int i = 0; i <= count; ++i) {
        nextangle = startAngle+i*singleangle;
        NSLog(@"角度是%f",nextangle*180/M_PI);
        NSLog(@"下一次坐标是(%f,%f)",center.x+cos(nextangle)*radius,center.y+sin(nextangle)*radius);
        CGPathAddLineToPoint(path,nil,center.x+cos(nextangle)*radius,center.y+sin(nextangle)*radius);
    }
    [anyangle setPath:path];
    [self.layer addSublayer:anyangle];
    CGPathRelease(path);
}


@end
