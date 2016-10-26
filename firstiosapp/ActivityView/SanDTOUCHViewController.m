//
//  3DTOUCHViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/10/12.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "SanDTOUCHViewController.h"
#import "PeekViewController.h"

@interface SanDTOUCHViewController () <UIViewControllerPreviewingDelegate>

@end

@implementation SanDTOUCHViewController{
    UIView *touchview;
    UILabel *touchlable;
    UILabel *touchstate;
    UIButton *peekpopButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    touchview = [[UIView alloc]initWithFrame:CGRectMake(30, StartY+20, 200, 80)];
    touchview.backgroundColor = [UIColor blackColor];
    touchlable = [[UILabel alloc] initWithFrame:CGRectMake((touchview.frame.origin.x+touchview.frame.size.width)/2, touchview.frame.origin.y + touchview.frame.size.height+30, 100, 30)];
    touchlable.textColor = [UIColor blackColor];
    touchlable.font = [UIFont systemFontOfSize:14];
    touchlable.text = @"0";
    
    touchstate = [[UILabel alloc] initWithFrame:CGRectMake((touchview.frame.origin.x+touchview.frame.size.width)/2, touchlable.frame.origin.y + touchlable.frame.size.height+30, 100, 30)];
    touchstate.textColor = [UIColor blackColor];
    touchstate.font = [UIFont systemFontOfSize:14];
    touchstate.text = @"0";
    
    peekpopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [peekpopButton setTitle:@"peek&pop" forState:UIControlStateNormal];
    peekpopButton.frame = CGRectMake(touchview.frame.origin.x, touchstate.frame.origin.y+touchstate.frame.size.height+20, touchview.frame.size.width, touchview.frame.size.height);
//    peekpopButton.frame = CGRectMake(30, 300, 150, 80);
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {//判断3Dtouch是否可用
        [self registerForPreviewingWithDelegate:self sourceView:peekpopButton];
    }
    [self.view addSubview:peekpopButton];
    [self.view addSubview:touchlable];
    [self.view addSubview:touchstate];
    [self.view addSubview:touchview];
    self.view.multipleTouchEnabled = YES;//开启多指触控
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    NSLog(@"traitCollectionDidChange");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    touchstate.text = [NSString stringWithFormat:@"%ld",(long)touch.phase];
    NSLog(@"触摸个数%lu",(unsigned long)[touches count]);
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    NSLog(@"%ld",touch.phase);
    touchlable.text = [NSString stringWithFormat:@"%f",touch.force];
    touchview.backgroundColor = [UIColor colorWithRed:(touch.force/touch.maximumPossibleForce) green:0 blue:0 alpha:1];
    touchstate.text = [NSString stringWithFormat:@"%ld",(long)touch.phase];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    touchstate.text = [NSString stringWithFormat:@"%ld",(long)touch.phase];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    //防止重复加入
    if ([self.presentedViewController isKindOfClass:[PeekViewController class]]){
        return nil;
    }
    else{
        PeekViewController *peekViewController = [[PeekViewController alloc] init];
        return peekViewController;
    }
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    PeekViewController *peekViewController = [[PeekViewController alloc] init];
    [self.navigationController pushViewController:peekViewController animated:YES];
//    [self showViewController:peekViewController sender:self];
//    [self presentModalViewController:peekViewController animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
