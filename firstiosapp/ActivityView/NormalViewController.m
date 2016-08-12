//
//  NormalViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/7/1.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "NormalViewController.h"
#import "SecondViewController.h"
#import "XibViewController.h"
#import "ListView.h"
#import "CollectionView.h"

@interface NormalViewController ()

@property (nonatomic,strong) UIButton *button;

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Normal View";
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor colorWithRed:0.07 green:0.82 blue:0.99 alpha:1.00];
    [self.view addSubview:view];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 80, 111)];
    lable.text = [[NSString alloc] initWithFormat:@"fffdfffffffffffffffffffffffffffffffffffffffffffff%d",123];
//    [lable setFont:[UIFont systemFontOfSize:25]];
    lable.font = [UIFont systemFontOfSize:25];
    lable.backgroundColor = [UIColor greenColor];
    lable.textColor = [UIColor yellowColor];
    lable.textAlignment = NSTextAlignmentCenter;
//    lable.adjustsFontSizeToFitWidth = YES;
    lable.lineBreakMode = NSLineBreakByCharWrapping;
    lable.numberOfLines = 0;
    CGSize labelsize =  [lable.text sizeWithFont:lable.font constrainedToSize:CGSizeMake(80, 10000) lineBreakMode:NSLineBreakByCharWrapping];
    lable.frame = CGRectMake(100, 100, 80, labelsize.height);
    UITapGestureRecognizer *uiges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tolistvc)];
    lable.userInteractionEnabled = YES;
    [lable addGestureRecognizer:uiges];
    NSString *path = [[NSBundle mainBundle] resourcePath];
//    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[path stringByAppendingString:@"/1.png"]];
//    NSLog([path stringByAppendingString:@"/1.png"]);
    UIImage *image = [UIImage imageNamed:@"1.png"];
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    imageview.frame = CGRectMake(200, 200, image.size.width, image.size.height);
    UITapGestureRecognizer *imagtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toCollectionView)];
    imageview.userInteractionEnabled = YES;
    [imageview addGestureRecognizer:imagtap];
    [view addSubview:imageview];
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 150, 30)];
    self.button.backgroundColor = [UIColor colorWithRed:0.56 green:0.34 blue:0.02 alpha:1.00];
    self.button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.button setTitle:@"好麻烦啊" forState:UIControlStateNormal];
    
    [_button addTarget:self action:@selector(toXibvc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"loadxib" owner:self options:nil];
    UIView *loadxibview1 = [views lastObject];
    NSArray *views1 = [loadxibview1 subviews];
    UIView *view2 = [views1 lastObject];
    view2.userInteractionEnabled = YES;
    UIButton *xibbutton = [[view2 subviews] lastObject];
    xibbutton.userInteractionEnabled = YES;
    [xibbutton addTarget:self action:@selector(gun) forControlEvents:UIControlEventTouchUpInside];
    xibbutton.backgroundColor =[UIColor colorWithRed:0.16 green:0.16 blue:0.16 alpha:1.00];
    xibbutton.titleLabel.textColor = [UIColor colorWithRed:1.00 green:0.83 blue:0.20 alpha:1.00];
    [xibbutton setTitle:@"heheda" forState:UIControlStateNormal];
//    NSLog([[NSString alloc] initWithFormat:@"width%d",WIDTH]);
//    NSLog([[NSString alloc] initWithFormat:@"width%f",self.screenWidth]);

//    lable.lineBreakMode  = UILineBreakModeHeadTruncation;
    
    [view addSubview:lable];
    UITextView *textview = [[UITextView alloc]init];
    textview.frame = CGRectMake(150, 100, 50, 20);
    textview.text = @"1235";
    [view addSubview:textview];
    [view addSubview:loadxibview1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)gun{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.navigationController == nil){
        NSLog(@"navigation is nil");
    } else{
        NSLog(@"navigation is not nil");
    }
    if (!self.navigationController){
        NSLog(@"navigation is nil ++");
    } else{
        NSLog(@"navigation is not nil ++");
    }
    NSLog(@"caonima");
    NSLog(@"%f,%f",_button.frame.size.width,_button.frame.size.height);
}

- (void)startActivity{
    [self gun];
    SecondViewController *vc = [[SecondViewController alloc] init];
    vc.name = @"test";
//    [self presentViewController:vc animated:YES completion:nil];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem = item;
    item.title = @"返回";
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) toXibvc{
    [self gun];
//    XibViewController *xibvc = [[XibViewController alloc] initWithNibName:@"firstxib" bundle:nil];
    XibViewController *xibvc = [[XibViewController alloc] init];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.navigationController pushViewController:xibvc animated:YES];
}

- (void) tolistvc {
    ListView *list = [[ListView alloc] init];
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.navigationController pushViewController:list animated:YES];
}

-(void) toCollectionView{
    CollectionView *cvc = [[CollectionView alloc] init];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.navigationController pushViewController:cvc animated:YES];
}
- (void) viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
}
- (void) viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear");
//    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
//    self.navigationController.navigationBarHidden = YES;
}

@end
