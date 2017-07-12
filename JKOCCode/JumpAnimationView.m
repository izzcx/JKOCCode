//
//  JumpAnimationView.m
//  JKOCCode
//
//  Created by zouchao on 2017/4/5.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JumpAnimationView.h"

@interface JumpAnimationView ()

@property (nonatomic, strong) NSMutableArray *layersArray;

@end

@implementation JumpAnimationView

- (id)initJumpAnimationView{
    self = [super initWithFrame:CGRectMake(0, 0, 70, 30)];
    if (self){
        [self addJumpBallsForView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:CGRectMake(0, 0, 70, 30)];
    if (self){
        [self addJumpBallsForView];
    }
    return self;
}

- (void)addJumpBallsForView{
    _layersArray = [NSMutableArray arrayWithCapacity:3];
    for (int i = 0; i<3; i++) {
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(15+20*i, 15, 10, 10);
        layer.cornerRadius = 5;
        layer.backgroundColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:layer];
        [_layersArray addObject:layer];
        [self animationforLayer:layer index:i];
    }
}

- (void)animationforLayer:(CALayer *)layer index:(NSInteger)index{
    CGPoint point = layer.frame.origin;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    switch (index) {
        case 0:
        {
            animation.timeOffset = 0.3;
        }
        break;
        case 1:
        {
            animation.timeOffset = 0.15;
        }
        break;
        case 2:
        {
            animation.timeOffset = 0.0;
        }
        break;
        default:
        break;
    }
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(point.x, point.y-7)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
    animation.values=@[value1,value2,value3,value4];
    animation.keyTimes = @[@0.25,@0.5,@0.75,@1.0];
    animation.repeatCount=MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.9;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [layer addAnimation:animation forKey:nil];
}

- (void)setBallBackground:(UIColor *)ballBackground{
    
    if (_ballBackground != ballBackground) {
        _ballBackground = ballBackground;
        for (CALayer *sublayer in self.layersArray) {
            sublayer.backgroundColor = _ballBackground.CGColor;
        }
    }
}

@end
