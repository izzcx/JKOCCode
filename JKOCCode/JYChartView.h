//
//  JYChartView.h
//  JKOCCode
//
//  Created by silence on 2017/3/17.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYChartView : UIView

@property (nonatomic, copy) NSString *chartTitle;

- (void)drawRectWithContext:(CGContextRef)context;

@end
