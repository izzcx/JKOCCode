//
//  JKBaseGraphicsView.m
//  JKOCCode
//
//  Created by silence on 2017/3/17.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JKBaseGraphicsView.h"

@implementation JKBaseGraphicsView


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIBezierPath* bezier10Path = [UIBezierPath bezierPath];
    [bezier10Path moveToPoint: CGPointMake(133.5, 38.5)];
    [bezier10Path addLineToPoint: CGPointMake(142.5, 60.5)];
    [bezier10Path addLineToPoint: CGPointMake(159.5, 50.5)];
    [bezier10Path addLineToPoint: CGPointMake(171.5, 81.5)];
    [bezier10Path addLineToPoint: CGPointMake(184.5, 66.5)];
    [bezier10Path addLineToPoint: CGPointMake(216.5, 60.5)];
    [bezier10Path addLineToPoint: CGPointMake(241.5, 50.5)];
    [bezier10Path addLineToPoint: CGPointMake(266.5, 18.5)];
    [[UIColor redColor] setStroke];
    bezier10Path.lineWidth = 1;
    [bezier10Path stroke];

    
}


@end
