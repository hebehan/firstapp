//
//  UITextFiledViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/8/26.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "UITextFiledViewController.h"
#import "Toast.h"

/**
 * uitextfiled我能玩一年
 */
@interface UITextFiledViewController()<UITextFieldDelegate>

@end
@implementation UITextFiledViewController{
    UITextField *field;
    UIView *bigLayout;
    UISegmentedControl *typeSegment;
    UILabel *lengthLabel;
}

- (void)viewDidLoad {
    bigLayout = [[UIView alloc] initWithFrame:CGRectMake(0,StartY,SCREEN_WIDTH,SCREEN_HEIGHT-StartY)];
    bigLayout.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:bigLayout];

    field = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100,bigLayout.frame.size.height-100,200,50)];
    field.backgroundColor = [UIColor redColor];
    field.delegate = self;
    field.placeholder = @"限制输入4个数字";
    field.keyboardType = UIKeyboardTypeNumberPad;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;

    lengthLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100,field.frame.origin.y-40-10,200,40)];
    lengthLabel.textAlignment = NSTextAlignmentCenter;
    lengthLabel.textColor = [UIColor blackColor];
    lengthLabel.font = [UIFont systemFontOfSize:14];

    [bigLayout addSubview:field];
    NSArray *items = [[NSArray alloc] initWithObjects:@"数字键盘",@"英文键盘",@"电话键盘",nil];
    typeSegment = [[UISegmentedControl alloc] initWithItems:items];
    typeSegment.segmentedControlStyle = UISegmentedControlStylePlain;
    typeSegment.selectedSegmentIndex = 0;
    typeSegment.backgroundColor = [UIColor whiteColor];
    typeSegment.frame = CGRectMake((SCREEN_WIDTH-typeSegment.frame.size.width)/2,10,typeSegment.frame.size.width,typeSegment.frame.size.height);
    [typeSegment addTarget:self action:@selector(onSegmentClick:) forControlEvents:UIControlEventValueChanged];
//    [self addKeyBoardNotification];
    [bigLayout addSubview:typeSegment];
    [bigLayout addSubview:lengthLabel];

}

/**
 * 注册键盘显示监听
 */
-(void)addKeyBoardNotification{
    //UIKeyboardDidShowNotification 显示name
    //UIKeyboardDidHideNotification 隐藏name
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyBoardShow:) name:UIKeyboardDidShowNotification  object:nil];
}

/**
 * 监听键盘显示
 * @param notification
 */
-(void)onKeyBoardShow:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyBoard:%f", keyboardSize.height);
}

-(void)onSegmentClick:(UISegmentedControl *)segment{
    [field resignFirstResponder];
    switch (segment.selectedSegmentIndex){
        case 0:{
            field.keyboardType = UIKeyboardTypeNumberPad;
            field.placeholder = @"限制输入4个数字";
            field.text = @"";
        }
            break;
        case 1:{
            field.keyboardType = UIKeyboardTypeDefault;
            field.placeholder = @"不限制输入";
            field.text = @"";
        }
            break;
        case 2:{
            field.keyboardType = UIKeyboardTypePhonePad;
            field.placeholder = @"限制输入11个数字";
            field.text = @"";
        }
            break;
    }
    [field becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [field resignFirstResponder];//点击屏幕 收键盘
    [UIView beginAnimations:@"back" context:nil];
    [UIView setAnimationDuration:0.2];
    bigLayout.frame = CGRectMake(0,StartY,SCREEN_WIDTH,SCREEN_HEIGHT-StartY);//主界面恢复原始高度
    [UIView commitAnimations];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ((SCREEN_HEIGHT - textField.superview.frame.origin.y-textField.frame.origin.y-textField.frame.size.height) < KEYBORD_HEIGHT){
        NSTimeInterval animationTime = (KEYBORD_HEIGHT - (SCREEN_HEIGHT - textField.frame.origin.y-textField.frame.size.height))/KEYBORD_HEIGHT*0.3f;
        [UIView beginAnimations:@"123" context:nil];
        [UIView setAnimationDuration:animationTime];
        textField.superview.frame = CGRectMake(textField.superview.frame.origin.x,textField.superview.frame.origin.y-(KEYBORD_HEIGHT - (SCREEN_HEIGHT -textField.superview.frame.origin.y- textField.frame.origin.y-textField.frame.size.height)),textField.superview.frame.size.width,textField.superview.frame.size.height);
        [UIView commitAnimations];

    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(range.length+range.location > textField.text.length){
        return NO;
    }
    if (textField == field){
        NSUInteger newlength = [field.text length] + [string length] - range.length;
        lengthLabel.text = [[NSString alloc] initWithFormat:@"已输入%d字符",newlength];
        if (typeSegment.selectedSegmentIndex == 0){
            return newlength <=4&& [self validateNumber:string];
        } else if (typeSegment.selectedSegmentIndex == 2){
            return newlength <=11;
        } else if (typeSegment.selectedSegmentIndex == 1){
            return YES;
        } else{
            return YES;
        }

    } else{
        return YES;
    }
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    lengthLabel.text = [[NSString alloc] initWithFormat:@"已输入%d字符",0];
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
@end
