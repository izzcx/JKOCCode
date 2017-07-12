//
//  PieChartData.h
//  JKOCCode
//
//  Created by silence on 2017/3/17.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYChartNodeObject.h"

@interface JYPieChartNode : JYChartNodeObject

@property (nonatomic, assign) CGFloat dataPercent;
@property (nonatomic, strong) UIColor *pieColor;
@property (nonatomic, assign) CGFloat beignRac;
@property (nonatomic, assign) CGFloat rac;
@property (nonatomic, copy)   NSString *pieTitle;
@property (nonatomic, assign) BOOL isMax;

@end
