//
//  OtherXib.m
//  firstiosapp
//
//  Created by Hebe on 16/7/14.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "OtherXib.h"

@interface OtherXib ()

@end

@implementation OtherXib

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_button1 addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    // Dispose of any resources that can be recreated.
}

-(void)show{
    UIAlertView *alview = [[UIAlertView alloc] initWithTitle:@"otherxib" message:@"show by other xib" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"fuck", nil];
    [alview show];
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
