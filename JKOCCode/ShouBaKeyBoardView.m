//
//  ShouBaKeyBoardView.m
//  JKOCCode
//
//  Created by silence on 2017/3/22.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "ShouBaKeyBoardView.h"
#import "KeyBoardElement.h"

@interface ShouBaKeyBoardView ()

@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGPoint selectPoint;

@end

@implementation ShouBaKeyBoardView

- (void)drawRect:(CGRect)rect {
    
    if (!self.keyBoardElements || self.keyBoardElements.count == 0) return;
    
    NSInteger elementCount = self.keyBoardElements.count;
    NSInteger row = self.keyBoardElements.count/4;
    CGFloat cellHeight = SCREENWIDTH/4.0;
    self.cellHeight = cellHeight;
    self.cellWidth = cellHeight;
    
//    UIColor *fillColor = kUIColorFromRGB(0xdcdcdc);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(currentContext, 0.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(currentContext, 1.0);
    CGContextSaveGState(currentContext);
    
    //绘制背景线
    for (int i = 0; i<row-1; i++) {
       
        //横向线
        CGPoint hstartPoint = CGPointMake(0, cellHeight*(i+1));
        CGPoint hendPoint = CGPointMake(SCREENWIDTH, cellHeight*(i+1));
        CGContextMoveToPoint(currentContext,hstartPoint.x, hstartPoint.y);
        CGContextAddLineToPoint(currentContext, hendPoint.x, hendPoint.y);
        CGContextStrokePath(currentContext);
        
         //纵向线
        CGPoint vstartPoint = CGPointMake(cellHeight*(i+1), 0);
        CGPoint vendPoint = CGPointMake(cellHeight*(i+1),SCREENWIDTH);
        CGContextMoveToPoint(currentContext, vstartPoint.x, vstartPoint.y);
        CGContextAddLineToPoint(currentContext, vendPoint.x, vendPoint.y);
        CGContextStrokePath(currentContext);
    }
    
    //绘制元素
    for (int i = 0; i<elementCount; i++) {
        
        CGRect elementRect = CGRectMake(cellHeight*(i%4), cellHeight*(i/4), cellHeight, cellHeight);
        JY_Log(@"--- elelment --- %@",NSStringFromCGRect(elementRect));
        KeyBoardElement *element = [self.keyBoardElements objectAtIndex:i];
        JY_Log(@"--- elelment --- %@",element.value);
        UIColor * textColor = [UIColor blackColor];
        UIFont *font = [UIFont systemFontOfSize:35];
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
        textStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* textFontAttributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle};
        
        CGRect textSize = [element.value boundingRectWithSize: CGSizeMake(INFINITY, INFINITY)
                                                    options: NSStringDrawingUsesLineFragmentOrigin
                                                 attributes: textFontAttributes
                                                    context: nil];
        CGFloat textX =  elementRect.origin.x + (cellHeight-textSize.size.width)/2.0;
        CGFloat textY =  elementRect.origin.y + (cellHeight-textSize.size.height)/2.0;
        CGPoint textPoint = CGPointMake(textX, textY);
        textSize.origin = textPoint;
        JY_Log(@"--- elelment --- %@",NSStringFromCGRect(textSize));
        [element.value drawInRect: textSize withAttributes: textFontAttributes];
    }
    
    CGContextRestoreGState(currentContext);
    
}

- (UIView *)selectView{
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH/4.0, SCREENWIDTH/4.0)];
        _selectView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        _selectView.hidden = YES;
    }
    return _selectView;
}

- (void)showSelectView{
    
    CGRect selectFrame = self.selectView.frame;
    selectFrame.origin = self.selectPoint;
    self.selectView.frame = selectFrame;
    
    if (!self.selectView.superview) {
        [self addSubview:self.selectView];
    }
    self.selectView.hidden = NO;
    self.selectView.alpha = 1;
}

- (void)hiddenSelectView{
   [UIView animateWithDuration:0.2 animations:^{
       self.selectView.alpha = 0;
   }completion:^(BOOL finished) {
       self.selectView.hidden = YES;
   }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger column = point.x/self.cellWidth;
    NSInteger row = point.y/self.cellHeight;
    CGPoint showPoint = CGPointMake(column*self.cellHeight, row*self.cellWidth);
    self.selectPoint = showPoint;
    [self showSelectView];
    JY_Log(@"point -- begint -- %@",NSStringFromCGPoint(self.selectPoint));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger column = point.x/self.cellHeight;
    NSInteger row = point.y/self.cellHeight;
    CGPoint showPoint = CGPointMake(column*self.cellHeight, row*self.cellWidth);
    self.selectPoint = showPoint;
    JY_Log(@"point -- move -- %@",NSStringFromCGPoint(self.selectPoint));
    
    CGRect selectFrame = self.selectView.frame;
    selectFrame.origin = self.selectPoint;
    self.selectView.frame = selectFrame;

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.selectPoint = CGPointZero;
    [self hiddenSelectView];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger column = point.x/self.cellHeight;
    NSInteger row = point.y/self.cellHeight;
    NSInteger index = 4*row+column;
    if (index >= self.keyBoardElements.count) {
        return;
    }
    KeyBoardElement *element = [self.keyBoardElements objectAtIndex:index];

    JY_Log(@"select text -- key --- %@",element.value);
    if ([self.kbDelegate respondsToSelector:@selector(shouBaKeyBoardView:didSelectElement:)]) {
        [self.kbDelegate shouBaKeyBoardView:self didSelectElement:element];
    }
}


@end
