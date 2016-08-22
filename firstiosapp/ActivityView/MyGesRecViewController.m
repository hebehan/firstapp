//
//  MyGesRecViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/8/20.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "MyGesRecViewController.h"
#import "Toast.h"

@implementation MyGesRecViewController{
    UIButton *panButton;
    UIButton *pinchButton;
    UIButton *rotationButton;
}

- (void)viewDidLoad {
    panButton = [[UIButton alloc] initWithFrame:CGRectMake(0,StartY,80,50)];
    panButton.backgroundColor = [UIColor redColor];
    [panButton setTitle:@"Pan" forState:UIControlStateNormal];
    [panButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.view addSubview:panButton];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panbutton:)];
    [panButton addGestureRecognizer:panGestureRecognizer];

    pinchButton = [[UIButton alloc] initWithFrame:CGRectMake(panButton.frame.origin.x+panButton.frame.size.width+50,StartY+120,120,120)];
    pinchButton.backgroundColor = [UIColor cyanColor];
    [pinchButton setTitle:@"Pinch+rotation" forState:UIControlStateNormal];
    [pinchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:pinchButton];
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchbutton:)];
    [pinchButton addGestureRecognizer:pinchGestureRecognizer];
//    [pinchButton addGestureRecognizer:panGestureRecognizer];

    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationButton:)];
    [pinchButton addGestureRecognizer:rotationGestureRecognizer];

    UISwipeGestureRecognizer *swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:swipeLeftGestureRecognizer];
    [self.view addGestureRecognizer:swipeRightGestureRecognizer];
}

/**
 * 拖动手势
 * @param pan
 */
-(void)panbutton:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.view];
    pan.view.center = CGPointMake(pan.view.center.x+point.x,pan.view.center.y+point.y);
    [pan setTranslation:CGPointZero inView:self.view];
    if (pan.state == UIGestureRecognizerStateEnded){
        CGPoint velocity = [pan velocityInView:self.view];
        CGFloat vector = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slidemult = vector / 2000;
        float slideFactor = 0.1* slidemult;
        CGPoint finalPoint = CGPointMake((pan.view.center.x+velocity.x*slideFactor),(pan.view.center.y+velocity.y*slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x,0),self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        [UIView animateWithDuration:slideFactor*0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            pan.view.center = finalPoint;
        } completion:nil];
    }
}

/**
 * 缩放手势
 * @param pinch
 */
-(void)pinchbutton:(UIPinchGestureRecognizer *)pinch{

    pinch.view.transform = CGAffineTransformScale(pinch.view.transform,pinch.scale,pinch.scale);
    pinch.scale = 1;
}

/**
 * 旋转手势
 * @param rotation
 */
-(void)rotationButton:(UIRotationGestureRecognizer *)rotation{
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform,rotation.rotation);
    rotation.rotation = 0;
}
/**
 * 滑动手势
 * @param swipe
 */
-(void)swipeAction:(UISwipeGestureRecognizer *)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        [Toast show:@"左滑"];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        [Toast show:@"右滑"];
    }
}
@end
