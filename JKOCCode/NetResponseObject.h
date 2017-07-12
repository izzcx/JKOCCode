//
//  NetResponseObject.h
//  JKOCCode
//
//  Created by silence on 2017/3/6.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetResponseObject : NSObject

@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, assign) id  responseObject;
@property (nonatomic, strong) NSArray *reponseData;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSError *reponseError;

@end
