//
//  ShouBaDisplayView.h
//  JKOCCode
//
//  Created by silence on 2017/3/22.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShouBaDisplaySumView;
@protocol ShouBaDisplaySumViewDelegate <NSObject>

@optional
- (void)clearDisplayInShouBaDisplaySumView:(ShouBaDisplaySumView *)displayView;

@end

@interface ShouBaDisplaySumView : UIView

@property (nonatomic, copy) NSString *equationString;
@property (nonatomic, copy) NSString *sumString;

@property (nonatomic, weak) id<ShouBaDisplaySumViewDelegate> displayDelegate;

@end
