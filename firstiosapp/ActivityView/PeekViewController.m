//
//  PeekViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/10/12.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import "PeekViewController.h"

@interface PeekViewController ()

@end

@implementation PeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageview =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    self.view.frame = CGRectMake(0, 0, 200, 200);
    [self.view addSubview:imageview];
    // Do any additional setup after loading the view.
}

-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"action1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action1");
    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"action2" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action2");
    }];
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"action3" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"action3");
    }];
    NSArray *actions = @[action1,action2,action3];
    UIPreviewActionGroup *group = [UIPreviewActionGroup actionGroupWithTitle:@"acotions" style:UIPreviewActionStyleDefault actions:actions];
    NSArray *previews = @[group];
    return previews;
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
