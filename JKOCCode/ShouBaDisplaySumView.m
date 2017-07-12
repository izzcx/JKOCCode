//
//  ShouBaDisplayView.m
//  JKOCCode
//
//  Created by silence on 2017/3/22.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "ShouBaDisplaySumView.h"

@interface ShouBaDisplaySumView ()

@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UILabel *equationLabel;

@end

@implementation ShouBaDisplaySumView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.clearButton];
        [self addSubview:self.sumLabel];
        [self addSubview:self.equationLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat centery = self.centerY;
    self.clearButton.frame = CGRectMake(10, centery+5, 60, 40);
    self.sumLabel.frame = CGRectMake(80, centery, SCREENWIDTH-20-90, 50);
    self.equationLabel.frame = CGRectMake(10, centery/2.0-20, SCREENWIDTH-40, 40);
}

- (void)drawSumString:(NSString *)sumString contextRef:(CGContextRef)currentContext{
    UIColor * textColor = sumString?[UIColor blackColor]:[UIColor lightGrayColor];
    UIFont *font = [UIFont systemFontOfSize:sumString?35:25];
    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.alignment = NSTextAlignmentRight;
    NSDictionary* textFontAttributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle};
    
    NSString *textContent = sumString?:@"请输入收款金额";
    CGRect textSize = [textContent boundingRectWithSize: CGSizeMake(SCREENWIDTH-40, INFINITY)
                                                options: NSStringDrawingUsesLineFragmentOrigin
                                             attributes: textFontAttributes
                                                context: nil];
    CGFloat textX = CGRectGetWidth(self.frame)- 20 - CGRectGetWidth(textSize);
    CGFloat textY = 0;
    if (sumString) {
        textY = self.centerY+20-(textSize.size.height/2.0);
    }else{
        textY = self.centerY-(textSize.size.height/2.0);
    }
    CGPoint textPoint = CGPointMake(textX, textY);
    textSize.origin = textPoint;
    JY_Log(@"--- elelment --- %@",NSStringFromCGRect(textSize));
    [textContent drawInRect: textSize withAttributes: textFontAttributes];

}

- (void)drawEquationString:(NSString *)equationString contextRef:(CGContextRef)currentContext{
    
    if (!equationString) return;
    UIColor * textColor = [UIColor lightGrayColor];
    UIFont *font = [UIFont systemFontOfSize:15];
    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.alignment = NSTextAlignmentRight;
    NSDictionary* textFontAttributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName: textColor, NSParagraphStyleAttributeName: textStyle};
    
    NSString *textContent = equationString;
    CGRect textSize = [textContent boundingRectWithSize: CGSizeMake(SCREENWIDTH-40, INFINITY)
                                                options: NSStringDrawingUsesLineFragmentOrigin
                                             attributes: textFontAttributes
                                                context: nil];
    CGFloat textX = CGRectGetWidth(self.frame)- 20 - CGRectGetWidth(textSize);
    CGFloat textY = 20+(self.centerY-10)/2-(textSize.size.height/2);
   
    CGPoint textPoint = CGPointMake(textX, textY);
    textSize.origin = textPoint;
    JY_Log(@"--- elelment --- %@",NSStringFromCGRect(textSize));
    [textContent drawInRect: textSize withAttributes: textFontAttributes];
    
}

- (UILabel *)sumLabel{
    
    if (!_sumLabel) {
        _sumLabel = [[UILabel alloc] init];
        _sumLabel.textAlignment = NSTextAlignmentRight;
        _sumLabel.textColor = [UIColor grayColor];
        _sumLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _sumLabel.font = [UIFont systemFontOfSize:35];
        _sumLabel.numberOfLines = 1;
        _sumLabel.lineBreakMode = NSLineBreakByTruncatingHead;
        _sumLabel.text = @"请输入收款金额";
    }
    return _sumLabel;
}

- (UILabel *)equationLabel{
    
    if (!_equationLabel) {
        _equationLabel = [[UILabel alloc] init];
        _equationLabel.textAlignment = NSTextAlignmentRight;
        _equationLabel.textColor = [UIColor grayColor];
        _equationLabel.font = [UIFont systemFontOfSize:23];
        _equationLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    }
    return _equationLabel;
}

- (UIButton *)clearButton{
    
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearButton.layer.cornerRadius = 20;
        _clearButton.backgroundColor = [UIColor lightGrayColor];
        [_clearButton setTitle:@"C" forState:UIControlStateNormal];
        _clearButton.hidden = YES;
        [_clearButton addTarget:self action:@selector(clearInputAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

- (void)clearInputAction:(UIButton *)button{
    self.equationLabel.text = nil;
    self.sumLabel.textColor = [UIColor grayColor];
    self.sumLabel.text = @"请输入收款金额";
    button.hidden = YES;
    if ([self.displayDelegate respondsToSelector:@selector(clearDisplayInShouBaDisplaySumView:)]) {
        [self.displayDelegate clearDisplayInShouBaDisplaySumView:self];
    }
}

- (void)setSumString:(NSString *)sumString{
    if (_sumString != sumString) {
        _sumString = sumString;
        self.clearButton.hidden = _sumString?NO:YES;
        if (_sumString) {
            self.sumLabel.textColor = [UIColor blackColor];
            self.sumLabel.text = _sumString;
        }else{
            self.sumLabel.textColor = [UIColor grayColor];
            self.sumLabel.text = @"请输入收款金额";
        }
        [self setNeedsLayout];
    }
}

- (void)setEquationString:(NSString *)equationString{
    if (_equationString != equationString) {
        _equationString = equationString;
        self.equationLabel.text = _equationString;
        [self setNeedsLayout];
    }
}

@end
