//
//  HomeInfoModel.m
//  JKOCCode
//
//  Created by silence on 2017/3/9.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "HomeInfoModel.h"

@implementation HomeInfoModel

+ (NSArray *)modelFromResponseObject:(id)reponseObject{
    
    if (![reponseObject isKindOfClass:[NSDictionary class]]) return nil;
    NSDictionary *infoDic = [NSDictionary dictionaryWithDictionary:reponseObject];
    NSArray *liveInfo = [infoDic objectForKey:@"liveInfo"];
    NSMutableArray *infoModels = [NSMutableArray arrayWithCapacity:liveInfo.count];
    for (NSDictionary *liveDic in liveInfo) {
        HomeInfoModel *infoModel = [HomeInfoModel modelWithDictionary:liveDic];
        [infoModels addObject:infoModel];
    }
    if (infoModels.count == 0) {
        return nil;
    }
    
    return infoModels;
}

@end
