//
//  LineChartNode.h
//  JKOCCode
//
//  Created by silence on 2017/3/17.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYChartNodeObject.h"

@interface JYLineChartNode : JYChartNodeObject

@property (nonatomic, assign) CGPoint nodePoint;
@property (nonatomic, assign) CGFloat nodeRadius;
@property (nonatomic, strong) UIColor *nodeColor;

@end
