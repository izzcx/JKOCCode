
//
//  LayerViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/13.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "LayerViewController.h"

@interface LayerViewController ()

@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Layer";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self showReplicatorLayerAnimation];
    [self showMusicReplicatorLayer];
    [self textLayerShow];
}


- (void)textLayerShow{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 64, 200, 200)];
    
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint: CGPointMake(96, 14)];
    [starPath addLineToPoint: CGPointMake(104.82, 26.86)];
    [starPath addLineToPoint: CGPointMake(119.78, 31.27)];
    [starPath addLineToPoint: CGPointMake(110.27, 43.64)];
    [starPath addLineToPoint: CGPointMake(110.69, 59.23)];
    [starPath addLineToPoint: CGPointMake(96, 54)];
    [starPath addLineToPoint: CGPointMake(81.31, 59.23)];
    [starPath addLineToPoint: CGPointMake(81.73, 43.64)];
    [starPath addLineToPoint: CGPointMake(72.22, 31.27)];
    [starPath addLineToPoint: CGPointMake(87.18, 26.86)];
    [starPath closePath];
    [path appendPath:starPath];
   
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    
    CATextLayer *textlayer = [CATextLayer layer];
    textlayer.frame = self.view.bounds;
    textlayer.mask = shape;
    textlayer.string = @"fnsifnaifadfnksafnaksdfnsadkfnaslkfndsaklfnsa";
    textlayer.wrapped = YES;
    textlayer.alignmentMode = @"center";
    [self.view.layer addSublayer:textlayer];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

}

- (void)showReplicatorLayerAnimation{
    
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    [tPath moveToPoint:CGPointMake(SCREENWIDTH/2.0, 200)];
    [tPath addQuadCurveToPoint:CGPointMake(SCREENWIDTH/2.0, 400) controlPoint:CGPointMake(SCREENWIDTH/2.0 + 200, 20)];
    [tPath addQuadCurveToPoint:CGPointMake(SCREENWIDTH/2.0, 200) controlPoint:CGPointMake(SCREENWIDTH/2.0 - 200, 20)];
    [tPath closePath];
    
    UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    tView.center = CGPointMake(SCREENWIDTH/2.0, 200);
    tView.layer.cornerRadius = 5;
    tView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    CAKeyframeAnimation *loveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    loveAnimation.path = tPath.CGPath;
    loveAnimation.duration = 8;
    loveAnimation.repeatCount = MAXFLOAT;
    [tView.layer addAnimation:loveAnimation forKey:@"loveAnimation"];
    
    CAReplicatorLayer *reLayer = [CAReplicatorLayer layer];
    reLayer.instanceCount = 40;
    reLayer.instanceDelay = 0.2;
    reLayer.instanceColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor;
    reLayer.instanceGreenOffset = -0.03;
    reLayer.instanceRedOffset = -0.02;
    reLayer.instanceBlueOffset = -0.01;
    [reLayer addSublayer:tView.layer];
    [self.view.layer addSublayer:reLayer];
}

- (void)showMusicReplicatorLayer{
    
    CAReplicatorLayer *musicLayer = [CAReplicatorLayer layer];
    musicLayer.frame = CGRectMake(0, 0, 60, 100);
    musicLayer.position = self.view.center;
    musicLayer.instanceCount = 3;
    musicLayer.instanceTransform = CATransform3DMakeTranslation(15, 0, 0);
    musicLayer.instanceDelay = 0.2;
    musicLayer.backgroundColor = [UIColor greenColor].CGColor;
    musicLayer.masksToBounds = YES;
    [self.view.layer addSublayer:musicLayer];
    
    CALayer *tLayer = [CALayer layer];
    tLayer.frame = CGRectMake(10, 100, 10, 50);
    tLayer.backgroundColor = [UIColor redColor].CGColor;
    [musicLayer addSublayer:tLayer];
    
    CABasicAnimation *musicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    musicAnimation.duration = 0.35;
    musicAnimation.fromValue = @(100);
    musicAnimation.toValue = @(80);
    musicAnimation.repeatCount = MAXFLOAT;
    musicAnimation.autoreverses = YES;
    
    [tLayer addAnimation:musicAnimation forKey:@"musicAnimation"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
