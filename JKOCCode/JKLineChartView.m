//
//  LineChartView.m
//  JKOCCode
//
//  Created by silence on 2017/3/16.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JKLineChartView.h"

@implementation JKLineChartView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // This code was generated by Trial version of PaintCode, therefore cannot be used for commercial purposes.
    // http://www.paintcodeapp.com
        //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    
    //// Text Drawing
    CGRect textRect = CGRectMake(16, 26, 29, 9);
    {
        NSString* textContent = @"10000";
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
        textStyle.alignment = NSTextAlignmentRight;
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 8], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (textRect.size.height - textTextHeight) / 2, textRect.size.width, textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 2 Drawing
    CGRect text2Rect = CGRectMake(16, 36, 29, 10);
    {
        NSString* textContent = @"8000";
        NSMutableParagraphStyle* text2Style = [[NSMutableParagraphStyle alloc] init];
        text2Style.alignment = NSTextAlignmentRight;
        NSDictionary* text2FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 8], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: text2Style};
        
        CGFloat text2TextHeight = [textContent boundingRectWithSize: CGSizeMake(text2Rect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: text2FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text2Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text2Rect), CGRectGetMinY(text2Rect) + (text2Rect.size.height - text2TextHeight) / 2, text2Rect.size.width, text2TextHeight) withAttributes: text2FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(rect) + 0.5, CGRectGetMinY(rect) + 4.5)];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 119.5, CGRectGetMinY(rect) + 4.5)];
   // [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 0.5, CGRectGetMinY(rect) + 4.5)];
    [bezierPath closePath];
    [UIColor.grayColor setFill];
    [bezierPath fill];
    [color setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezierPath stroke];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(rect) + 1.5, CGRectGetMinY(rect) + 27.5)];
    [bezier3Path addLineToPoint: CGPointMake(165.5, 53.5)];
   // [bezier3Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 1.5, CGRectGetMinY(rect) + 27.5)];
    [bezier3Path closePath];
    [UIColor.grayColor setFill];
    [bezier3Path fill];
    [UIColor.blackColor setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezier3Path stroke];
    
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(CGRectGetMinX(rect) + 1, CGRectGetMinY(rect) + 40.5)];
    [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 120, CGRectGetMinY(rect) + 40.5)];
   // [bezier4Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 1, CGRectGetMinY(rect) + 40.5)];
    [bezier4Path closePath];
    [UIColor.grayColor setFill];
    [bezier4Path fill];
    [UIColor.blackColor setStroke];
    bezier4Path.lineWidth = 1;
    [bezier4Path setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezier4Path stroke];
    
    
    //// Bezier 5 Drawing
    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint: CGPointMake(CGRectGetMinX(rect) + 0.5, CGRectGetMinY(rect) + 53)];
    [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 119.5, CGRectGetMinY(rect) + 53)];
   // [bezier5Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 0.5, CGRectGetMinY(rect) + 53)];
    [bezier5Path closePath];
    [UIColor.grayColor setFill];
    [bezier5Path fill];
    [UIColor.blackColor setStroke];
    bezier5Path.lineWidth = 1;
    [bezier5Path setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezier5Path stroke];
    
    
    //// Text 3 Drawing
    CGRect text3Rect = CGRectMake(22, 48, 23, 9);
    {
        NSString* textContent = @"6000";
        NSMutableParagraphStyle* text3Style = [[NSMutableParagraphStyle alloc] init];
        text3Style.alignment = NSTextAlignmentRight;
        NSDictionary* text3FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 8], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: text3Style};
        
        CGFloat text3TextHeight = [textContent boundingRectWithSize: CGSizeMake(text3Rect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: text3FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text3Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text3Rect), CGRectGetMinY(text3Rect) + (text3Rect.size.height - text3TextHeight) / 2, text3Rect.size.width, text3TextHeight) withAttributes: text3FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 4 Drawing
    CGRect text4Rect = CGRectMake(22, 62, 23, 9);
    {
        NSString* textContent = @"4000";
        NSMutableParagraphStyle* text4Style = [[NSMutableParagraphStyle alloc] init];
        text4Style.alignment = NSTextAlignmentRight;
        NSDictionary* text4FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 8], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: text4Style};
        
        CGFloat text4TextHeight = [textContent boundingRectWithSize: CGSizeMake(text4Rect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: text4FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text4Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text4Rect), CGRectGetMinY(text4Rect) + (text4Rect.size.height - text4TextHeight) / 2, text4Rect.size.width, text4TextHeight) withAttributes: text4FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 5 Drawing
    CGRect text5Rect = CGRectMake(22, 74.5, 23, 9);
    {
        NSString* textContent = @"2000";
        NSMutableParagraphStyle* text5Style = [[NSMutableParagraphStyle alloc] init];
        text5Style.alignment = NSTextAlignmentRight;
        NSDictionary* text5FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 8], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: text5Style};
        
        CGFloat text5TextHeight = [textContent boundingRectWithSize: CGSizeMake(text5Rect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: text5FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text5Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text5Rect), CGRectGetMinY(text5Rect) + (text5Rect.size.height - text5TextHeight) / 2, text5Rect.size.width, text5TextHeight) withAttributes: text5FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(rect) + 1, CGRectGetMinY(rect) + 15)];
    [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 120, CGRectGetMinY(rect) + 15)];
    //[bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 1, CGRectGetMinY(rect) + 15)];
    [bezier2Path closePath];
    [UIColor.grayColor setFill];
    [bezier2Path fill];
    [UIColor.blackColor setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezier2Path stroke];
    
    
    //// Text 6 Drawing
    CGRect text6Rect = CGRectMake(45, 93, 23, 9);
    {
        NSString* textContent = @"2-03";
        NSMutableParagraphStyle* text6Style = [[NSMutableParagraphStyle alloc] init];
        text6Style.alignment = NSTextAlignmentRight;
        NSDictionary* text6FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 6], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: text6Style};
        
        CGFloat text6TextHeight = [textContent boundingRectWithSize: CGSizeMake(text6Rect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: text6FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text6Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text6Rect), CGRectGetMinY(text6Rect) + (text6Rect.size.height - text6TextHeight) / 2, text6Rect.size.width, text6TextHeight) withAttributes: text6FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 7 Drawing
    CGRect text7Rect = CGRectMake(66, 93, 23, 9);
    {
        NSString* textContent = @"2-04";
        NSMutableParagraphStyle* text7Style = [[NSMutableParagraphStyle alloc] init];
        text7Style.alignment = NSTextAlignmentRight;
        NSDictionary* text7FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 6], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: text7Style};
        
        CGFloat text7TextHeight = [textContent boundingRectWithSize: CGSizeMake(text7Rect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: text7FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text7Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text7Rect), CGRectGetMinY(text7Rect) + (text7Rect.size.height - text7TextHeight) / 2, text7Rect.size.width, text7TextHeight) withAttributes: text7FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 8 Drawing
    CGRect text8Rect = CGRectMake(89, 93, 23, 9);
    {
        NSString* textContent = @"2-05";
        NSMutableParagraphStyle* text8Style = [[NSMutableParagraphStyle alloc] init];
        text8Style.alignment = NSTextAlignmentRight;
        NSDictionary* text8FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 6], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: text8Style};
        
        CGFloat text8TextHeight = [textContent boundingRectWithSize: CGSizeMake(text8Rect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: text8FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text8Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text8Rect), CGRectGetMinY(text8Rect) + (text8Rect.size.height - text8TextHeight) / 2, text8Rect.size.width, text8TextHeight) withAttributes: text8FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 9 Drawing
    CGRect text9Rect = CGRectMake(112, 93, 23, 9);
    {
        NSString* textContent = @"2-06";
        NSMutableParagraphStyle* text9Style = [[NSMutableParagraphStyle alloc] init];
        text9Style.alignment = NSTextAlignmentRight;
        NSDictionary* text9FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 6], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: text9Style};
        
        CGFloat text9TextHeight = [textContent boundingRectWithSize: CGSizeMake(text9Rect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: text9FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text9Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text9Rect), CGRectGetMinY(text9Rect) + (text9Rect.size.height - text9TextHeight) / 2, text9Rect.size.width, text9TextHeight) withAttributes: text9FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Text 10 Drawing
    CGRect text10Rect = CGRectMake(135, 93, 23, 9);
    {
        NSString* textContent = @"2-07";
        NSMutableParagraphStyle* text10Style = [[NSMutableParagraphStyle alloc] init];
        text10Style.alignment = NSTextAlignmentRight;
        NSDictionary* text10FontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 6], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: text10Style};
        
        CGFloat text10TextHeight = [textContent boundingRectWithSize: CGSizeMake(text10Rect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: text10FontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, text10Rect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(text10Rect), CGRectGetMinY(text10Rect) + (text10Rect.size.height - text10TextHeight) / 2, text10Rect.size.width, text10TextHeight) withAttributes: text10FontAttributes];
        CGContextRestoreGState(context);
    }
    
    
    //// Bezier 8 Drawing
    UIBezierPath* bezier8Path = [UIBezierPath bezierPath];
    [bezier8Path moveToPoint: CGPointMake(101.5, 25.5)];
    [bezier8Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 56.5, CGRectGetMinY(rect) + 66.5)];
    //[bezier8Path addLineToPoint: CGPointMake(101.5, 25.5)];
    [bezier8Path closePath];
    [UIColor.grayColor setFill];
    [bezier8Path fill];
    [UIColor.blackColor setStroke];
    bezier8Path.lineWidth = 1;
    [bezier8Path setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezier8Path stroke];
    
    
    //// Bezier 9 Drawing
    UIBezierPath* bezier9Path = [UIBezierPath bezierPath];
    [bezier9Path moveToPoint: CGPointMake(CGRectGetMinX(rect) + 82, CGRectGetMinY(rect) + 0.5)];
    [bezier9Path addLineToPoint: CGPointMake(127, 93.5)];
    //[bezier9Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 82, CGRectGetMinY(rect) + 0.5)];
    [bezier9Path closePath];
    [UIColor.grayColor setFill];
    [bezier9Path fill];
    [UIColor.blackColor setStroke];
    bezier9Path.lineWidth = 1;
    [bezier9Path setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezier9Path stroke];
    
    
    //// Bezier 10 Drawing
    UIBezierPath* bezier10Path = [UIBezierPath bezierPath];
    [bezier10Path moveToPoint: CGPointMake(CGRectGetMinX(rect) + 104.5, CGRectGetMinY(rect) + 0.5)];
    [bezier10Path addLineToPoint: CGPointMake(149.5, 93.5)];
    //[bezier10Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 104.5, CGRectGetMinY(rect) + 0.5)];
    [bezier10Path closePath];
    [UIColor.grayColor setFill];
    [bezier10Path fill];
    [UIColor.blackColor setStroke];
    bezier10Path.lineWidth = 1;
    [bezier10Path setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezier10Path stroke];
    
    
    //// Bezier 7 Drawing
    UIBezierPath* bezier7Path = [UIBezierPath bezierPath];
    [bezier7Path moveToPoint: CGPointMake(CGRectGetMinX(rect) + 16, CGRectGetMinY(rect) + 0.5)];
    [bezier7Path addLineToPoint: CGPointMake(61, 93.5)];
    //[bezier7Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 16, CGRectGetMinY(rect) + 0.5)];
    [bezier7Path closePath];
    [UIColor.grayColor setFill];
    [bezier7Path fill];
    [UIColor.blackColor setStroke];
    bezier7Path.lineWidth = 1;
    [bezier7Path setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezier7Path stroke];
    
    
    //// Bezier 6 Drawing
    UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path moveToPoint: CGPointMake(CGRectGetMinX(rect) + 36, CGRectGetMinY(rect) + 0.5)];
    [bezier6Path addLineToPoint: CGPointMake(81, 93.5)];
   // [bezier6Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 36, CGRectGetMinY(rect) + 0.5)];
    [bezier6Path closePath];
    [UIColor.grayColor setFill];
    [bezier6Path fill];
    [UIColor.blackColor setStroke];
    bezier6Path.lineWidth = 1;
    [bezier6Path setLineDash: (CGFloat[]){2, 2} count: 2 phase: 0];
    [bezier6Path stroke];
    
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(rect) + 15, CGRectGetMinY(rect) + 20, 3, 3)];
    [UIColor.grayColor setFill];
    [ovalPath fill];
    
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(rect) + 35, CGRectGetMinY(rect) + 39, 3, 3)];
    [UIColor.grayColor setFill];
    [oval2Path fill];
    
    
    //// Oval 3 Drawing
    UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(rect) + 55, CGRectGetMinY(rect) + 22, 3, 3)];
    [UIColor.grayColor setFill];
    [oval3Path fill];
    
    
    //// Oval 4 Drawing
    UIBezierPath* oval4Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(rect) + 81, CGRectGetMinY(rect) + 4, 3, 3)];
    [UIColor.grayColor setFill];
    [oval4Path fill];
    
    
    //// Oval 5 Drawing
    UIBezierPath* oval5Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(rect) + 103, CGRectGetMinY(rect) + 13.5, 3, 3)];
    [UIColor.grayColor setFill];
    [oval5Path fill];
    
    
    //// Bezier 11 Drawing
    UIBezierPath* bezier11Path = [UIBezierPath bezierPath];
    [bezier11Path moveToPoint: CGPointMake(CGRectGetMinX(rect) + 17.5, CGRectGetMinY(rect) + 20.5)];
    [bezier11Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 36.5, CGRectGetMinY(rect) + 40.5)];
    [bezier11Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 56.5, CGRectGetMinY(rect) + 23.5)];
    [bezier11Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 82.5, CGRectGetMinY(rect) + 6.5)];
    [bezier11Path addLineToPoint: CGPointMake(CGRectGetMinX(rect) + 105.5, CGRectGetMinY(rect) + 15.5)];
    [UIColor.blackColor setStroke];
    bezier11Path.lineWidth = 1;
    [bezier11Path stroke];

}


@end