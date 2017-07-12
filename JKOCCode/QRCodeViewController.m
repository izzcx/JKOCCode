//
//  QRCodeViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/7.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "QRCodeViewController.h"
#import "JKQRCodeCreateObject.h"
#import "ViewController.h"
#import "UIImage+RoundRectImage.h"
#import "UIImage+LXDCreateBarcode.h"
#import "QRScanViewController.h"

@interface QRCodeViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIImageView *qrImageView;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.qrImageView];
    self.qrImageView.center = self.view.center;
    
    //生成二维码 zxing
    [self showQRImageView:nil];
    
    //扫描二维码 zxing
    [self buttonActionSwipQR];
    
    //生成二维码 ios
    [self showQRBySystem:@"www.baidu.com//////////"];
    
    //扫描二维码 ios
    [self buttonActionSwipiOSQR];
}


- (void)showQRImageView:(NSString *)qrString{
    if (!qrString) {
        qrString = [NSString stringWithFormat: @"https://appsto.re/cn/Jd2W-.i "];
    }
    UIImage *qrImage = [JKQRCodeCreateObject createQRCodeImageWithString:qrString];
    self.qrImageView.image = qrImage;
}

- (UIImageView *)qrImageView{
    if (!_qrImageView) {
        _qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    }
    return _qrImageView;
}

- (void)buttonActionSwipQR{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor redColor]];
    button.frame = CGRectMake(10, 70, 100, 100);
    [button setTitle:@"你好" forState:UIControlStateNormal];
    UIImage *buttonImage = [UIImage imageNamed:@"jkoc-1"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.highImageName = @"jkoccode.jpeg";
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonActionSwipiOSQR{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor greenColor]];
    button.frame = CGRectMake(200, 70, 100, 100);
    [button setTitle:@"iosQR 扫描" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonSwipiOSQRAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction:(UIButton *)button{
    UIViewController *viewVC = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController pushViewController:viewVC animated:YES];
}

- (void)showQRBySystem:(NSString *)qrString{
    
    UIImage * image = [UIImage imageOfQRFromURL:qrString
                                       codeSize:1000
                                            red: 77
                                          green: 100
                                           blue: 177
                                    insertImage: [UIImage imageNamed: @"都是什么啊.jpg"]
                                    roundRadius: 15.0f];
      self.qrImageView.image = image;
    
}

- (void)buttonSwipiOSQRAction:(UIButton *)button{
    
    [self checkAVMediaAuthorizationStatus];
}

//获取摄像设备
- (void)checkAVMediaAuthorizationStatus{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                         completionHandler:^(BOOL granted) {
                                             if (granted) {
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     //进入扫描界面
                                                     [self showScanViewController];
                                                 });
                                             }else{
                                                 //提示先开启摄像头权限
                                                 [self alertUserAuthorizeAVMediaAuthorization];
                                             }
                                         }];
            }
                break;
            case AVAuthorizationStatusRestricted:
            {
                //系统原因不能访问
            }
                break;
            case AVAuthorizationStatusDenied:
            {
                //提示先开启摄像头权限
                [self alertUserAuthorizeAVMediaAuthorization];
            }
                break;
            case AVAuthorizationStatusAuthorized:
            {
                //进入扫描界面
                [self showScanViewController];
            }
                break;
            default:
                break;
        }
        
    }
}

- (void)alertUserAuthorizeAVMediaAuthorization{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                       message:@"请先允许使用您的摄像头，\n才能进行下一步"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    [alerView show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        //进入权限设置界面
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

- (void)showScanViewController{
    QRScanViewController *scanVC = [[QRScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
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
