
//
//  JYSescreKeyManager.m
//  ShouBa
//
//  Created by silence on 2017/4/7.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JYSescreKeyManager.h"
//#import "JYHttpServiceManager+AppSecretKey.h"

typedef void(^callBlock)(void);

@interface JYSescreKeyManager ()

@property (nonatomic, copy) FinishBlock finishBlock;

@end

@implementation JYSescreKeyManager

static JYSescreKeyManager * manager;

+ (instancetype)shareSecrekeyManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JYSescreKeyManager alloc] init];
    });
    return manager;
}

//-(void)checkSecreKeyFinishBlock:(FinishBlock)finishBlock{
//    [JYSescreKeyManager shareSecrekeyManager].finishBlock = finishBlock;
//    if (!GetSecretKey) {
//        self.finishBlock(YES);
//    }else{
//        [self getSecrekeyForServer];
//    }
//}
//
//- (void)getSecrekeyForServer{
//    [JYHttpServiceManager getSecreKeyWithBlock:^(NSString *secreKey, NSError *error) {
//        if (secreKey) {
//            self.finishBlock(YES);
//        }else{
//            [self getSecrekeyForServer];
//        }
//    }];
//}


@end
