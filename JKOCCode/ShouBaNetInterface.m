//
//  SbNetInterface.m
//  JKOCCode
//
//  Created by silence on 2017/3/6.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "ShouBaNetInterface.h"

@implementation ShouBaNetInterface

+ (NSString *)GetRequestBaseUrlOfCurrentEnvironment{
    NSString *hostUrl = nil;
    switch (DEVELOP) {
        case 0:
        {
            hostUrl = @"";
        }
            break;
        case 1:
        {
            hostUrl = @"";
        }
            break;
        case 2:
        {
            hostUrl = @"";
        }
            break;
        default:
            break;
    }
    
    return hostUrl;
}

+ (void)sbHomeNetRequestListInfoWithNetRequestObject:(NetRequestObject *)requestObject responseObject:(NetworkFinishBlock)finishBlock{
    
//    NSString *hostUrl = [ShouBaNetInterface GetRequestBaseUrlOfCurrentEnvironment];
//    requestObject.hostUrl = hostUrl;
    
    NSURLSessionDataTask *dataTask =  [NetworkManager requestNetworkByRequestObject:requestObject
                                                                        finishBlock:^(NetResponseObject *reponseObject) {
                                                                    
                                                                            if (reponseObject.isSuccess) {
                                                                                const char *clsString = [requestObject.modelClsString UTF8String];
                                                                                id datas = objc_msgSend((id)objc_getClass(clsString), sel_registerName("modelFromResponseObject:"),reponseObject.responseObject);
                                                                                if ([datas isKindOfClass:[NSArray class]]) {
                                                                                    reponseObject.reponseData = datas;
                                                                                }else{
                                                                                    reponseObject.reponseData = nil;
                                                                                }
                                                                            }else{
                                                                                //http://vcis.ifeng.com/api/liveAddress?adapterNo=7.2.0&platformType=iPhone&protocol=1.0.0
                                                                                JY_Log(@"----- %@",reponseObject.reponseError);
                                                                            }
                                                                            finishBlock(reponseObject);
    }];
    requestObject.dataTask = dataTask;
}

@end
