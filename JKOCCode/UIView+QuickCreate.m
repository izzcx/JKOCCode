//
//  UIView+QuickCreate.m
//  JKOCCode
//
//  Created by silence on 2017/3/1.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIView+QuickCreate.h"

@implementation UIView (QuickCreate)

+ (UIView *)createViewBackgroundColor:(UIColor *)color alpha:(CGFloat)alpha{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    view.alpha = alpha;
    return view;
}

@end
