//
//  MotionViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/9/12.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "MotionViewController.h"
#import "HorizontalProgressDrawView.h"

@interface MotionViewController(){

}
@end
@implementation MotionViewController{
    NSTimer *timer;
    HorizontalProgressDrawView *motionDrawView;
    UIButton *startbutton;
    UIButton *stopButton;
    UIButton *resumeButton;
    NSInteger currentValue;
    NSInteger timerState;//0开始1暂停2停止
}

- (void)viewDidLoad {
    motionDrawView = [[HorizontalProgressDrawView alloc] initWithFrame:CGRectMake(30,StartY+55,200,25)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    motionDrawView.currentValue = 0;
    [self.view addSubview:motionDrawView];
    currentValue = 0;
    timerState = 0;

    startbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    startbutton.frame = CGRectMake(20,StartY,70,45);
    [startbutton setTitle:@"开始" forState:UIControlStateNormal];

    stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopButton setTitle:@"停止" forState:UIControlStateNormal];
    stopButton.frame = CGRectMake(100,StartY,70,45);

    resumeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [resumeButton setTitle:@"暂停" forState:UIControlStateNormal];
    resumeButton.frame = CGRectMake(180,StartY,70,45);

    startbutton.enabled = YES;
    resumeButton.enabled = NO;
    stopButton.enabled = NO;

    [startbutton addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    [stopButton addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
    [resumeButton addTarget:self action:@selector(pauseTimer) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startbutton];
    [self.view addSubview:stopButton];
    [self.view addSubview:resumeButton];
}

-(void)update{
    currentValue++;
    NSLog(@"currentValue=%d",currentValue);
    motionDrawView.currentValue = currentValue;
    [motionDrawView setNeedsDisplay];
}

-(void)startTimer{
    startbutton.enabled = NO;
    resumeButton.enabled = YES;
    stopButton.enabled = YES;
    if (timerState == 0||timerState==2){
        timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(update) userInfo:nil repeats:YES];
        timerState = 0;
    } else{
        if (timerState == 1){
            [timer setFireDate:[NSDate date]];
            timerState = 0;
        }
    }

}

-(void)stopTimer{
    startbutton.enabled = YES;
    resumeButton.enabled = NO;
    stopButton.enabled = NO;
    if (timer != nil){
        [timer invalidate];
        currentValue = 0;
        timerState = 2;
        motionDrawView.currentValue = currentValue;
        [motionDrawView setNeedsDisplay];
        [startbutton setTitle:@"开始" forState:UIControlStateNormal];
    }
}

-(void)pauseTimer{
    startbutton.enabled = YES;
    resumeButton.enabled = NO;
    stopButton.enabled = YES;
    [startbutton setTitle:@"继续" forState:UIControlStateNormal];
    [timer setFireDate:[NSDate distantFuture]];
    timerState = 1;
}

- (void)viewDidDisappear:(BOOL)animated {
    if (timer != nil){
        [timer invalidate];
    }
    timer = nil;
}

@end
