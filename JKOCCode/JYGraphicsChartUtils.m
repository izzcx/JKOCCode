//
//  GraphicsChartUtils.m
//  JKOCCode
//
//  Created by silence on 2017/3/17.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JYGraphicsChartUtils.h"

@implementation JYGraphicsChartUtils

//绘制线
+ (void)drawChartLine:(CGContextRef)context fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint{
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: fromPoint];
    [bezierPath addLineToPoint: toPoint];
    [bezierPath closePath];
    [UIColor.grayColor setFill];
    [bezierPath fill];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezierPath stroke];
    
}

//绘制线
+ (void)drawChartLinefromPoint:(CGPoint)fromPoint
                       toPoint:(CGPoint)toPoint
                     lineColor:(UIColor *)lineColor
                     lineWidth:(CGFloat)lineWidth
                     lineStyle:(BOOL)lineStyle{
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: fromPoint];
    [bezierPath addLineToPoint: toPoint];
    [bezierPath closePath];
    [UIColor.grayColor setFill];
    [bezierPath fill];
    [lineColor setStroke];
    bezierPath.lineWidth = lineWidth;
    [bezierPath setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezierPath stroke];

}

//绘制文本
+ (void)drawChartText:(CGContextRef)context content:(NSString *)text {
    
    NSString* textContent = text;
    UIColor * textColor = [UIColor redColor];
    UIFont *font = [UIFont systemFontOfSize:8];
    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.alignment = NSTextAlignmentRight;
    NSDictionary* textFontAttributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle};
    
    CGRect textSize = [textContent boundingRectWithSize: CGSizeMake(INFINITY, INFINITY)
                                                options: NSStringDrawingUsesLineFragmentOrigin
                                             attributes: textFontAttributes
                                                context: nil];
    CGContextSaveGState(context);
    CGContextClipToRect(context, textSize);
    [textContent drawInRect: textSize withAttributes: textFontAttributes];
    CGContextRestoreGState(context);

}

/**
 绘制图片
 
 @param context 当前上下文
 @param image 图片
 @param rect 绘制位置
 */
+ (void)drawChartImage:(CGContextRef)context image:(UIImage *)image drawRect:(CGRect)rect{
    
    
}

//绘制折线
+ (void)drawChartBrokenLines:(NSArray *)lineChartNodes{
    
    if (!lineChartNodes) {
        return;
    }
    NSInteger nodesCount = lineChartNodes.count;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i = 0; i < nodesCount; i++) {
        JYLineChartNode *lineNode = [lineChartNodes objectAtIndex:i];
        if (i == 0) {
            [bezierPath moveToPoint:lineNode.nodePoint];
        }else{
            [bezierPath addLineToPoint:lineNode.nodePoint];
        }
    }
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1.0;
    [bezierPath stroke];
    
}
//绘制原点
+ (void)drawChartNodes:(NSArray *)lineChartNodes{
    
    if (!lineChartNodes) {
        return;
    }
    if (lineChartNodes.count == 0) {
        return;
    }
    for (JYLineChartNode *node in lineChartNodes) {
        CGRect nodeRect = CGRectMake(node.nodePoint.x-node.nodeRadius/2, node.nodePoint.y-node.nodeRadius/2, 2*node.nodeRadius, 2*node.nodeRadius);
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect:nodeRect];
        [UIColor.grayColor setFill];
        [oval2Path fill];
    }
    
}


@end
