//
//  TakePhotoViewController.m
//  firstiosapp
//
//  Created by Hebe on 16/8/22.
//  Copyright (c) 2016 Hebe. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "Toast.h"

@interface  TakePhotoViewController()<UIActionSheetDelegate,UIImagePickerControllerDelegate>
@end
@implementation TakePhotoViewController{
    UIImageView *imageView;
}

- (void)viewDidLoad {
    UIButton *takeButton = [[UIButton alloc] initWithFrame:CGRectMake(0,StartY,100,60)];
    [takeButton setTitle:@"选择" forState:UIControlStateNormal];
    [takeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    takeButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:takeButton];
    [takeButton addTarget:self action:@selector(showSelect) forControlEvents:UIControlEventTouchUpInside];
    imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0,0,150,150);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
}

-(void)showSelect{
    UIActionSheet *sheet123 = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",nil];
    [sheet123 showInView:self.view];
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:@"拍照",@"相册",nil];
//    actionSheet.delegate = self;
//    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex){
        case 0:{
            if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerSourceTypeCamera]){
                [Toast show:@"不支持相机"];
                return;
            }
            UIImagePickerController *upvc = [[UIImagePickerController alloc] init];
            upvc.sourceType = UIImagePickerControllerSourceTypeCamera;
            upvc.allowsEditing = YES;
            upvc.delegate = self;
            [self presentModalViewController:upvc animated:YES];
        }

            break;
        case 1:{
            UIImagePickerController *upvc = [[UIImagePickerController alloc] init];
            upvc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            upvc.allowsEditing = YES;
            upvc.delegate = self;
            [self presentModalViewController:upvc animated:YES];
        }
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
    imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
            [Toast show:@"保存到相册"];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
    [Toast show:@"取消选择"];
}

@end
