//
//  NetworkManager.h
//  JKOCCode
//
//  Created by silence on 2017/3/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetRequestObject.h"
#import "NetResponseObject.h"

typedef void(^NetworkFinishBlock)(NetResponseObject *reponseObject);

@interface NetworkManager : NSObject

+(instancetype)shareManager;

+ (NSURLSessionDataTask *)requestNetworkByRequestObject:(NetRequestObject *)requestObject finishBlock:(NetworkFinishBlock)rquestFinishBlock;

@end
