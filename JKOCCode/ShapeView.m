//
//  ShapeView.m
//  JKOCCode
//
//  Created by silence on 2017/3/9.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "ShapeView.h"

@interface ShapeView ()

@property (nonatomic,strong)  UIView *overLayView;
@property (nonatomic, strong) UIImageView *lineImageView;

@end

@implementation ShapeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((SCREENWIDTH-320)/2, 250, 320, 320) cornerRadius:0];
        [path appendPath:clipPath.bezierPathByReversingPath];
        CAShapeLayer *fillLayer = [CAShapeLayer layer];
        fillLayer.path = path.CGPath;
        fillLayer.lineWidth = 2.0;
        [self.overLayView.layer setMask:fillLayer];
        [self.overLayView setNeedsDisplay];
        [self addSubview:self.overLayView];
        
        self.lineImageView.frame = CGRectMake((SCREENWIDTH-320)/2, 242, 320, 12);
        [self addSubview:self.lineImageView];
        
        [self addSwipLineView];
        
    }
    return self;
}

- (void)addSwipLineView{
    
    UIViewAnimationCurve cur = UIViewAnimationCurveEaseInOut;
    [UIView beginAnimations:@"animationID" context:NULL];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:cur];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    CGRect rect =  self.lineImageView.frame;
    rect.origin.y += 320;
    self.lineImageView.frame = rect;
    [UIView commitAnimations];
}

- (UIView *)overLayView{
    if (!_overLayView) {
        _overLayView = [[UIView alloc] initWithFrame:self.bounds];
        _overLayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return _overLayView;
}

- (UIImageView *)lineImageView{
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.image = [UIImage imageNamed:@"QRCodeLine"];
    }
    return _lineImageView;
}

@end
