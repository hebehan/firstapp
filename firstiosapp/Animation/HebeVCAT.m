//
//  HebeVCAT.m
//  firstiosapp
//
//  Created by Hebe on 16/8/17.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "HebeVCAT.h"
#import "BaseTabBarController.h"

@implementation HebeVCAT

//动画持续时间，单位是秒
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.8f;
}

//动画效果
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //通过键值UITransitionContextToViewControllerKey获取需要呈现的视图控制器toVC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //得到toVC完全呈现后的frame
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
//    if ([toVC isKindOfClass:[BaseTabBarController class]]) {
//        //需要呈现的视图是跳转视图，此时将模态视图的frame放到屏幕空间下方，这样才能实现从下方弹出的效果
//        toVC.view.frame = CGRectOffset(finalFrame, 0, [UIScreen mainScreen].bounds.size.height);
//    } else {
//        //需要呈现的视图是主视图，此时将主视图的frame放在屏幕空间上方，这样才能实现从上方放下的效果
//        toVC.view.frame = CGRectOffset(finalFrame, 0, -[UIScreen mainScreen].bounds.size.height);
//    }
    //切换在containerView中完成，需要将toVC.view加到containerView中
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    //开始动画，这里使用了UIKit提供的弹簧效果动画，usingSpringWithDamping越接近1弹性效果越不明显，此API在IOS7之后才能使用
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVC.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                //通知系统动画切换完成
                [transitionContext completeTransition:YES];
            }];

//    // 1. Get controllers from transition context
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//
//    // 2. Set init frame for toVC
//    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
//    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
//
//    // 3. Add toVC's view to containerView
//    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:toVC.view];
//
//    // 4. Do animate now
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    [UIView animateWithDuration:duration
//                          delay:0.0
//         usingSpringWithDamping:0.6
//          initialSpringVelocity:0.0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         toVC.view.frame = finalFrame;
//                     } completion:^(BOOL finished) {
//                // 5. Tell context that we completed.
//                [transitionContext completeTransition:YES];
//            }];
}
@end
