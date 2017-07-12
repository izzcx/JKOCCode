//
//  SbNetInterface.h
//  JKOCCode
//
//  Created by silence on 2017/3/6.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShouBaNetInterface : NSObject

#pragma mark --------------------- 服务器地址
/**
 获取当前环境下的服务器地址

 @return NSString 对象
 */
+ (NSString *)GetRequestBaseUrlOfCurrentEnvironment;

#pragma mark --------------------- 首页请求接口
/**
 请求首页地址

 @param requestObject 请求信息对象
 @param finishBlock 返回完成的block
 */
+ (void)sbHomeNetRequestListInfoWithNetRequestObject:(NetRequestObject *)requestObject responseObject:(NetworkFinishBlock)finishBlock;

@end
