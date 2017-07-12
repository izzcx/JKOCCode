//
//  BaseViewController.h
//  JKOCCode
//
//  Created by silence on 2017/5/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    RequestStateDefault,
    RequestStateNetNO,
    RequestStateFail,
    RequestStateScuess,
    RequestStateNoData,
} RequestState;

@interface BaseViewController : UIViewController

@property (nonatomic, assign) RequestState requestState;
@property (nonatomic, assign) NSArray *reponseArray;


- (void)reqeustCurrentVCData;

- (BOOL)willRequestData;

- (void)startReuestData;

- (void)finishRequestData;

- (void)successRequestData;

- (void)failRequestData;

@end
