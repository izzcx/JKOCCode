//
//  NetRequestObject.h
//  JKOCCode
//
//  Created by silence on 2017/3/6.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NetRequestTypeDefault,
    NetRequestTypeGET,
    NetRequestTypePOST,
    NetRequestTypeUpload,
    NetRequestTypeDownload,
    NetRequestTypeOther,
} NetRequestType;

@interface NetRequestObject : NSObject

@property (nonatomic, copy)   NSString     *hostUrl;
@property (nonatomic, copy)   NSString     *requestUrl;
@property (nonatomic, strong) NSDictionary *requestParams;
@property (nonatomic, assign) NetRequestType requestType;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, copy)   NSString     *modelClsString;

@end
