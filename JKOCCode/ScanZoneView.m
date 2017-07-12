
//
//  ScanZoneView.m
//  JKOCCode
//
//  Created by silence on 2017/3/10.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "ScanZoneView.h"

@interface ScanZoneView ()

@property (nonatomic, strong) UIView *overLayView;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, assign) CGRect scanRect;
@property (nonatomic, strong) UIButton *lightButton;

@end

@implementation ScanZoneView

- (id)initWithFrame:(CGRect)frame scanFrame:(CGRect)scanFrame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.scanRect = scanFrame;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        //去掉扫描中心区域
        UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:scanFrame cornerRadius:0];
        [path appendPath:clipPath.bezierPathByReversingPath];
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        
        [linePath addLineToPoint:scanFrame.origin];
        
       
        CAShapeLayer *fillLayer = [CAShapeLayer layer];
        fillLayer.path = path.CGPath;
        fillLayer.lineWidth = 2.0;
        fillLayer.fillColor = [UIColor greenColor].CGColor;
        [self.overLayView.layer setMask:fillLayer];
        [self.overLayView setNeedsDisplay];
        [self addSubview:self.overLayView];
        
        CGFloat linex = scanFrame.origin.x;
        CGFloat liney = scanFrame.origin.y;
        CGFloat lineWidth = scanFrame.size.width;

        self.lineImageView.frame = CGRectMake(linex, liney, lineWidth, 2);
        [self addSubview:self.lineImageView];
        [self addGradientLayerForSwipLineView];
        
        [self addSwipLineView];
        
        self.lightButton.frame = CGRectMake((SCREENWIDTH-32)/2, liney+lineWidth+50, 32, 32);
        [self addSubview:self.lightButton];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    if (self.scanRect.size.width == 0) {
        return;
    }
    
    CGFloat scanXmin = CGRectGetMinX(self.scanRect);
    CGFloat scanYmin = CGRectGetMinY(self.scanRect);
    
    CGFloat scanXmax = CGRectGetMaxX(self.scanRect);
    CGFloat scanYmax = CGRectGetMaxY(self.scanRect);

    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(currentContext, 0.0, 1.0, 0.0, 1.0);
    CGContextSetLineWidth(currentContext, 3.0);
    
    //左上角
    CGContextMoveToPoint(currentContext,scanXmin, scanYmin+20);
    CGContextAddLineToPoint(currentContext, scanXmin, scanYmin);
    CGContextAddLineToPoint(currentContext, scanXmin+20, scanYmin);

    //右上角
    CGContextMoveToPoint(currentContext,scanXmax-20, scanYmin);
    CGContextAddLineToPoint(currentContext, scanXmax, scanYmin);
    CGContextAddLineToPoint(currentContext, scanXmax, scanYmin+20);

    //左下角
    CGContextMoveToPoint(currentContext,scanXmin, scanYmax-20);
    CGContextAddLineToPoint(currentContext, scanXmin, scanYmax);
    CGContextAddLineToPoint(currentContext, scanXmin+20, scanYmax);
    
    //右下角
    CGContextMoveToPoint(currentContext,scanXmax-20, scanYmax);
    CGContextAddLineToPoint(currentContext, scanXmax, scanYmax);
    CGContextAddLineToPoint(currentContext, scanXmax, scanYmax-20);
    
    CGContextStrokePath(currentContext);
}

- (void)addSwipLineView{
    
    UIViewAnimationCurve cur = UIViewAnimationCurveLinear;
    [UIView beginAnimations:@"animationID" context:NULL];
    [UIView setAnimationDuration:2.5];
    [UIView setAnimationCurve:cur];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    CGRect rect =  self.lineImageView.frame;
    rect.origin.y += self.scanRect.size.height;
    self.lineImageView.frame = rect;
    [UIView commitAnimations];
}

- (void)addGradientLayerForSwipLineView{
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    
    layer.locations = @[@(0.0),@(0.5),@(1.0)];
    [layer setStartPoint:CGPointMake(0.0, 1.0)];
    [layer setEndPoint:CGPointMake(1.0, 1.0)];
    
    UIColor *color1 = [UIColor clearColor];
    UIColor *green = [UIColor greenColor];
    UIColor *clear2 = [UIColor clearColor];
    
    NSMutableArray *colors = [NSMutableArray array];
    [colors addObject:(__bridge id)color1.CGColor];
    [colors addObject:(__bridge id)green.CGColor];
    [colors addObject:(__bridge id)clear2.CGColor];
    
    [layer setColors:[NSArray arrayWithArray:colors]];
   
    layer.frame = CGRectMake(0, 0, CGRectGetWidth(self.scanRect), 2);
    
    [self.lineImageView.layer addSublayer:layer];
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
        _lineImageView.backgroundColor = [UIColor clearColor];
        
    }
    return _lineImageView;
}

- (UIButton *)lightButton{
    if (!_lightButton) {
        _lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lightButton setImage:[UIImage imageNamed:@"lightOn"] forState:UIControlStateNormal];
        [_lightButton setImage:[UIImage imageNamed:@"lightOff"] forState:UIControlStateSelected];
        [_lightButton addTarget:self action:@selector(lightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lightButton;
}

- (void)lightButtonAction:(UIButton *)button{
    
    button.selected = !button.selected;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.hasTorch) {
        [device lockForConfiguration:nil];
        device.torchMode = button.selected?AVCaptureTorchModeOn:AVCaptureTorchModeOff;
        [device unlockForConfiguration];
    }
}

@end
