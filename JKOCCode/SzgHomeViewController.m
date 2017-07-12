
//
//  SzgHomeViewController.m
//  JKOCCode
//
//  Created by silence on 2017/5/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "SzgHomeViewController.h"
#import "AppDelegate.h"

#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface SzgHomeViewController ()

@end

@implementation SzgHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark ----- 数据请求

- (void)reqeustCurrentVCData{
    
    if (![self willRequestData]) {
        return;
    }
    
    [self startReuestData];
    
    NetRequestObject *requestObject = [[NetRequestObject alloc] init];
    requestObject.modelClsString = @"HomeInfoModel";
    requestObject.requestType = NetRequestTypePOST;
    requestObject.hostUrl = @"http://vcis.ifeng.com/api/liveAddress?adapterNo=7.2.0&platformType=iPhone&protocol=1.0.0";
    
    
    [ShouBaNetInterface sbHomeNetRequestListInfoWithNetRequestObject:requestObject responseObject:^(NetResponseObject *reponseObject) {
        
        if (reponseObject.isSuccess) {
            JY_Log(@" 请求成功  ");
        }else{
            JY_Log(@" 请求失败  ");
        }
        
        [self afterReqeustData];
        
    }];

}

- (void)afterReqeustData{
    
    [self finishRequestData];
    
}

//将要请求网络
- (BOOL)willRequestData{
//网络
    if (APP_DELEGATE.isNetEnable) {
        return YES;
    }else{
        
        return NO;
    }
}

//开始请求网络
- (void)startReuestData{
    if (self.reponseArray.count > 0) {
       //no show loading
    }else{
       //show loading
    }
}

//完成请求网络
- (void)finishRequestData{
    
    //hidden loading
}

//请求成功
- (void)successRequestData{
    
}

//请求失败
- (void)failRequestData{
    
    if (self.reponseArray.count > 0) {
    
        // 提示错误
    }else{
        
        // 显示错误界面
    }
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
