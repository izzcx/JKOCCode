//
//  JYLineChartView.h
//  JKOCCode
//
//  Created by silence on 2017/3/17.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JYChartView.h"

@interface JYLineChartView : JYChartView

/**
 水平、垂直空白间距
 */
@property (nonatomic, assign) CGFloat verticalSpace;
@property (nonatomic, assign) CGFloat horizontalSpace;

/**
 横、竖坐标标题
 */
@property (nonatomic, copy) NSString *titleX;
@property (nonatomic, copy) NSString *titleY;

/**
 横竖坐标上的子标题
 */
@property (nonatomic, strong) NSArray *lineNodesX;
@property (nonatomic, strong) NSArray *lineNodesY;

//表格属性
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;


@end
