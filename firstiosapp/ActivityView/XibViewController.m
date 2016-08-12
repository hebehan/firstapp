//
//  XibViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/7/12.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "XibViewController.h"

@interface XibViewController ()

@end

@implementation XibViewController

- (instancetype)init
{
    self = [super initWithNibName:@"firstxib" bundle:nil];
    if (self) {
        
    }
    return self;
}
//@synthesize xiblable;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog([[NSString alloc] initWithFormat:@"sdjfkdjdsjfk%f,%f",SCREEN_WIDTH,SCREEN_HEIGHT]);
//    self.view.frame = CGRectMake(0, 0,  0, 0);
    [_xiblable setText:@"gunbani"];
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"loadxib" owner:self options:nil];
    UIView *loadxibview1 = [views lastObject];
    NSArray *views1 = [loadxibview1 subviews];
    loadxibview1.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    loadxibview1.userInteractionEnabled = YES;
    UIView *view2 = [views1 lastObject];
    view2.userInteractionEnabled = YES;
    UIButton *xibbutton = [[view2 subviews] lastObject];
    xibbutton.userInteractionEnabled = YES;
    [xibbutton addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    xibbutton.backgroundColor =[UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    xibbutton.titleLabel.textColor = [UIColor colorWithRed:1.00 green:0.83 blue:0.20 alpha:1.00];
    [xibbutton setTitle:@"heheda" forState:UIControlStateNormal];
    view2.backgroundColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:0.50];
    loadxibview1.frame = CGRectMake(0, 0, 200, 100);
    
    for (int i =0;i < [views count];i++) {
        id obj = views[i];
        NSLog(@"%@",[obj class]);
    }
    for (int i =0;i < [views1 count];i++) {
        id obj = views1[i];
        NSLog(@"%@",[obj class]);    }
    NSLog(@"%lu",(unsigned long)[views count]);
    NSLog(@"%f,%f",self.view.frame.size.height,self.view.frame.size.height);
    UITapGestureRecognizer *uigr1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(show)];
    view2.userInteractionEnabled = YES;
    [view2 addGestureRecognizer:uigr1];
    [self.view addSubview:loadxibview1];
    _xiblable.userInteractionEnabled = YES;
    [_xiblable addGestureRecognizer:uigr1];
    [self.view bringSubviewToFront:view2];
    // Do any additional setup after loading the view.
}

-(void)butclick:(id)sender{
    UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"xib but click" message:@"good" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"fuck", nil];
    [alview show];
}
-(void)show{
    UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"xib but click" message:@"good" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"fuck", nil];
    [alview show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
