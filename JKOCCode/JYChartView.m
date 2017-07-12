
//
//  JYChartView.m
//  JKOCCode
//
//  Created by silence on 2017/3/17.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JYChartView.h"

@implementation JYChartView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    [self drawRectWithContext:currentContext];
    
}

- (void)drawRectWithContext:(CGContextRef)context{
    
    
}

@end
