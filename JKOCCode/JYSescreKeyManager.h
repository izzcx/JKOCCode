//
//  JYSescreKeyManager.h
//  ShouBa
//
//  Created by silence on 2017/4/7.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FinishBlock)(BOOL isHas);

@interface JYSescreKeyManager : NSObject

+ (instancetype)shareSecrekeyManager;

-(void)checkSecreKeyFinishBlock:(FinishBlock)finishBlock;

@end
