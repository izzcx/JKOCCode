
//
//  BaseErrorView.m
//  JKOCCode
//
//  Created by silence on 2017/5/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "BaseErrorView.h"

@implementation BaseErrorView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.descLabel];
        [self addSubview:self.imgView];
        [self addSubview:self.retryButton];
    }
    return self;
}

- (UILabel *)descLabel{
    
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.font = [UIFont systemFontOfSize:15];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.textColor = [UIColor blackColor];
    }
    return _descLabel;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.image = [UIImage imageNamed:@""];
    }
    return _imgView;
}

- (UIButton *)retryButton{
    
    if (!_retryButton) {
        _retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_retryButton setTitle:nil forState:UIControlStateNormal];
        [_retryButton setTitle:nil forState:UIControlStateHighlighted];
        [_retryButton setTitle:nil forState:UIControlStateSelected];
        [_retryButton setImage:nil forState:UIControlStateNormal];
        [_retryButton setImage:nil forState:UIControlStateHighlighted];
        [_retryButton setImage:nil forState:UIControlStateSelected];
        [_retryButton addTarget:self action:@selector(retryAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryButton;
}

- (void)retryAction:(UIButton *)button{
    
    
}

@end
