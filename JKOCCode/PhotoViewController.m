
//
//  PhotoViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/13.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "PhotoViewController.h"
#import "PHLibraryViewController.h"

@interface PhotoViewController ()<UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Photo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    photoButton.normalTitle = @"相册";
    photoButton.backgroundColor = [UIColor greenColor];
    photoButton.frame = CGRectMake(50, 120, 150, 70);
    [photoButton addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];
    
    UIButton *camerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    camerButton.normalTitle = @"拍照";
    camerButton.backgroundColor = [UIColor redColor];
    camerButton.frame = CGRectMake(50, 230, 150, 70);
    [camerButton addTarget:self action:@selector(camerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:camerButton];
    
    UIButton *libraryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    libraryButton.normalTitle = @"单选照片";
    libraryButton.backgroundColor = [UIColor redColor];
    libraryButton.frame = CGRectMake(50, 340, 150, 70);
    [libraryButton addTarget:self action:@selector(libraryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:libraryButton];

}

- (void)libraryButtonAction:(UIButton *)button{
    
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePickerVC animated:YES completion:^{
        
    }];
}

- (void)photoButtonAction:(UIButton *)button{
    
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    [self dealWithAuthorizationStatus:photoAuthStatus];
    
}

- (void)reqestAuthForPhotoLibrary{
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        [self dealWithAuthorizationStatus:status];
    }];
}

- (void)dealWithAuthorizationStatus:(PHAuthorizationStatus)status{
    
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
        {
            [self reqestAuthForPhotoLibrary];
        }
            break;
        case PHAuthorizationStatusRestricted:
        {
            [self alerUserConfiguerAuthForPhotoLibrary];
        }
            break;
        case PHAuthorizationStatusDenied:
        {
            [self alerUserConfiguerAuthForPhotoLibrary];
        }
            break;
        case PHAuthorizationStatusAuthorized:
        {
            [self showPhotoLibrary];
        }
            break;
        default:
            break;
    }

}

- (void)alerUserConfiguerAuthForPhotoLibrary{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请先允许使用您的相册库，\n才能进行下一步"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    [alerView show];

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        //进入权限设置界面
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"]];
        NSURL *url = [NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID&path=boundleId"];
        if ([UIDevice currentDevice].systemVersion.floatValue <= 10.0) {
            [[UIApplication sharedApplication] openURL:url];
        }else{
            // iOS10 之后, 比较特殊, 只能跳转到设置界面 , UIApplicationOpenSettingsURLString这个只支持iOS8之后.
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                //还可以跳过success这个bool值进行更加精确的判断.
                JY_Log(@"跳转成功回调");
            }];
        }
        
    }
}


- (void)showPhotoLibrary{
    PHLibraryViewController *library = [[PHLibraryViewController alloc] init];
    [self.navigationController pushViewController:library animated:YES];
}

- (void)camerButtonAction:(UIButton *)button{
    UIImagePickerController *ctrl = [[UIImagePickerController alloc] init];
    ctrl.delegate = (id)self;
    ctrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    ctrl.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    [self presentViewController:ctrl animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    NSLog(@"pickimg-------%@--- ",editingInfo);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
