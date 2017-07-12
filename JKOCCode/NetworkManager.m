
//
//  NetworkManager.m
//  JKOCCode
//
//  Created by silence on 2017/3/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NetworkManager.h"

#define REQUESTOUTTIME 10

@interface NetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation NetworkManager

+(instancetype)shareManager{
    static NetworkManager *_networkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networkManager = [[NetworkManager alloc] init];
        NSURLSessionConfiguration *configur = [NSURLSessionConfiguration defaultSessionConfiguration];
        configur.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        configur.timeoutIntervalForRequest = REQUESTOUTTIME;
        AFHTTPSessionManager *sessionManger = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configur];
        
        sessionManger.requestSerializer = [AFHTTPRequestSerializer serializer];
        [sessionManger.requestSerializer  setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        sessionManger.responseSerializer = [AFJSONResponseSerializer serializer];
        //[sessionManger.responseSerializer setValue:@"en-us" forKey:@"Accept-Language"];
        sessionManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/xml", @"text/html", @"text/javascript", @"application/javascript", @"application/x-javascript", @"text/plain", nil];
        
        _networkManager.sessionManager = sessionManger;
        
    });
    return _networkManager;
}

+ (NSURLSessionDataTask *)requestNetworkByRequestObject:(NetRequestObject *)requestObject finishBlock:(NetworkFinishBlock)finishBlock{
    
    
    JY_Fun_Log();
    NetworkManager *networkManager = [NetworkManager shareManager];
    NSURLSessionDataTask *dataTask = nil;
    NSString *requestUrl = nil;
    if (requestObject.hostUrl) {
        requestUrl = requestObject.hostUrl;
    }
    
    if (requestObject.requestUrl) {
        requestUrl = [requestUrl stringByAppendingPathComponent:requestObject.requestUrl];
    }
    
    if (![requestUrl hasPrefix:@"http://"]) {
        NetResponseObject *response = [[NetResponseObject alloc] init];
        response.isSuccess = NO;
        finishBlock(response);
        return nil;
    }
    
    switch (requestObject.requestType) {
        case NetRequestTypeDefault:
        case NetRequestTypeGET:
        {
            dataTask = [networkManager.sessionManager GET:requestUrl
                                    parameters:requestObject.requestParams
                                      progress:nil
                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                           dispatch_main_sync_safe(^{
                                              NetResponseObject *response = [[NetResponseObject alloc] init];
                                              response.isSuccess = YES;
                                              response.responseObject = responseObject;
                                              finishBlock(response);
                                           });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                dispatch_main_sync_safe(^{
                    NetResponseObject *response = [[NetResponseObject alloc] init];
                    response.isSuccess = NO;
                    response.reponseError = error;
                    finishBlock(response);
                });
            }];
        }
            break;
        case NetRequestTypePOST:
        {
            dataTask = [networkManager.sessionManager POST:requestUrl
                                     parameters:requestObject.requestParams
                                       progress:nil
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            dispatch_main_sync_safe(^{
                                                NetResponseObject *response = [[NetResponseObject alloc] init];
                                                response.isSuccess = YES;
                                                response.responseObject = responseObject;
                                                finishBlock(response);
                                            });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                dispatch_main_sync_safe(^{
                    NetResponseObject *response = [[NetResponseObject alloc] init];
                    response.isSuccess = NO;
                    response.reponseError = error;
                    finishBlock(response);
                });
            }];
        }
            break;
        case NetRequestTypeUpload:
        {
            //上传
        }
            break;
        case NetRequestTypeDownload:
        {
            //下载
        }
            break;
        case NetRequestTypeOther:
        {
            //预留
        }
            break;
        default:
            break;
    }
    
    return dataTask;
}


@end
