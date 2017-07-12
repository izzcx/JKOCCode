//
//  GraphicsChartUtils.h
//  JKOCCode
//
//  Created by silence on 2017/3/17.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYLineChartNode.h"

@interface JYGraphicsChartUtils : NSObject

//绘制线
+ (void)drawChartLine:(CGContextRef)context fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint;


/**
 绘制直线

 @param fromPoint 起始点
 @param toPoint 终止点
 @param lineColor 颜色
 @param lineWidth 宽度
 @param lineStyle 样式
 */
+ (void)drawChartLinefromPoint:(CGPoint)fromPoint
                       toPoint:(CGPoint)toPoint
                     lineColor:(UIColor *)lineColor
                     lineWidth:(CGFloat)lineWidth
                     lineStyle:(BOOL)lineStyle;

//绘制文本
+ (void)drawChartText:(CGContextRef)context content:(NSString *)text;

/**
 绘制图片

 @param context 当前上下文
 @param image 图片
 @param rect 绘制位置
 */
+ (void)drawChartImage:(CGContextRef)context image:(UIImage *)image drawRect:(CGRect)rect;


//+ (void)drawPieChart:(CGContextRef)context image:(UIImage *)image drawRect:(CGRect)rect;

//绘制折线
+ (void)drawChartBrokenLines:(NSArray *)lineChartNodes;
//绘制原点
+ (void)drawChartNodes:(NSArray *)lineChartNodes;

@end
