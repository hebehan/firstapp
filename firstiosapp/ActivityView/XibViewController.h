//
//  XibViewController.h
//  firstiosapp
//
//  Created by Hebe on 16/7/12.
//  Copyright © 2016年 Hebe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface XibViewController : BaseViewController{
//    UILabel *xiblable;
}
@property (nonatomic,retain) IBOutlet UILabel *xiblable;
@property (nonatomic,retain) IBOutlet UIButton *xibbut;
-(IBAction)butclick:(id)sender;
@end
