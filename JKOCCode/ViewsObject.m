//
//  ViewsObject.m
//  JKOCCode
//
//  Created by silence on 2017/3/1.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "ViewsObject.h"

@interface ViewsObject ()

@property (nonatomic, strong)UIView *baseView;

@end

@implementation ViewsObject

- (UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor whiteColor];
    }
    return _baseView;
}

@end
