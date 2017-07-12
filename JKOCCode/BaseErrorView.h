//
//  BaseErrorView.h
//  JKOCCode
//
//  Created by silence on 2017/5/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ErrorStateDefault,
    ErrorStateNoContent,
    ErrorStateNONet,
} ErrorState;

typedef void(^ActionBlock)(ErrorState state);

@interface BaseErrorView : UIView

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *retryButton;

@property (nonatomic, assign) ErrorState errorState;
@property (nonatomic, copy) ActionBlock actionBlock;

@end
