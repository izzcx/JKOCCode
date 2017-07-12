//
//  ShouBaCounterView.m
//  JKOCCode
//
//  Created by silence on 2017/3/22.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "ShouBaCounterView.h"
#import "ShouBaDisplaySumView.h"
#import "ShouBaKeyBoardView.h"
#import "KeyBoardElement.h"

@interface ShouBaCounterView ()<ShouBaKeyBoardViewDelegate,ShouBaDisplaySumViewDelegate>

@property (nonatomic, strong) NSMutableArray *kbElements;
@property (nonatomic, strong) ShouBaKeyBoardView *keyBoardView;
@property (nonatomic, strong) ShouBaDisplaySumView *disPlayView;

@property (nonatomic, strong) NSMutableArray  *countStack;

@property (nonatomic, copy) NSString *equationString;
@property (nonatomic, copy) NSString *inputString;
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, assign) float sum;

@end

@implementation ShouBaCounterView

- (id)initShowBaCounterView{
    
    self = [super initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64-49)];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self initKeyBoardElements];
        _isAdd = YES;
        self.keyBoardView.frame = CGRectMake(0, SCREENHEIGHT-64-SCREENWIDTH-49, SCREENWIDTH, SCREENWIDTH);
        self.keyBoardView.keyBoardElements = _kbElements;
        self.disPlayView.frame = CGRectMake(10, 10, SCREENWIDTH-20, SCREENHEIGHT-64-49-SCREENWIDTH-20);

        [self addSubview:self.keyBoardView];
        [self addSubview:self.disPlayView];
        
    }
    return self;
}

- (ShouBaKeyBoardView *)keyBoardView{
    
    if (!_keyBoardView) {
        _keyBoardView = [[ShouBaKeyBoardView alloc] init];
        _keyBoardView.backgroundColor = [UIColor whiteColor];
        _keyBoardView.kbDelegate = self;
    }
    return _keyBoardView;
}

- (ShouBaDisplaySumView *)disPlayView{
    
    if (!_disPlayView) {
        _disPlayView = [[ShouBaDisplaySumView alloc] init];
        _disPlayView.backgroundColor = [UIColor whiteColor];
        _disPlayView.displayDelegate = self;
       
    }
    return _disPlayView;
}

- (NSMutableArray *)kbElements{
    
    if (!_kbElements) {
        _kbElements = [NSMutableArray arrayWithCapacity:16];
    }
    return _kbElements;
}

- (NSMutableArray *)countStack{
    
    if (!_countStack) {
        _countStack = [NSMutableArray array];
    }
    return _countStack;
}

- (void)initKeyBoardElements{
    NSArray *values = @[@"1",@"2",@"3",@"←",
                        @"4",@"5",@"6",@"+",
                        @"7",@"8",@"9",@"-",
                        @".",@"0",@"=",@"收款"];
    @autoreleasepool {
        for (NSString *value in values) {
            KeyBoardElement *element = [[KeyBoardElement alloc] init];
            element.value = value;
            if ([@"0123456789" containsString:value]){
                element.valueType = KBElementValueTypeNumber;
            }else if ([@"+-=" containsString:value]){
                element.valueType = KBElementValueTypeOperator;
            }else if ([value isEqualToString:@"←"]) {
                element.valueType = KBElementValueTypeDelete;
            }else if ([value isEqualToString:@"收款"]){
                element.valueType = KBElementValueTypeCash;
            }else if ([value isEqualToString:@"."]){
                element.valueType = KBElementValueTypeDot;
            }
            [self.kbElements addObject:element];
        }
    }
}

#pragma mark --- ShouBaDisplaySumViewDelegate

- (void)clearDisplayInShouBaDisplaySumView:(ShouBaDisplaySumView *)displayView{

    self.equationString = nil;
    self.inputString = nil;
    self.isAdd = YES;
    self.sum = 0.00;
    [self.countStack removeAllObjects];
}

#pragma mark --- ShouBaKeyBoardViewDelegate

- (void)shouBaKeyBoardView:(ShouBaKeyBoardView *)keyBoardView didSelectElement:(KeyBoardElement *)element{
    
    if (!self.inputString) {
        switch (element.valueType) {
            case KBElementValueTypeNumber:
            {
                if (element.valueType == KBElementValueTypeNumber) {
                    self.inputString = [NSString stringWithFormat:@"%@",element.value] ;
                    if (self.equationString) {
                        self.equationString = [self.equationString stringByAppendingString:element.value];
                    }else{
                        self.equationString = [NSString stringWithFormat:@"%@",element.value];
                    }
                    self.disPlayView.sumString = self.equationString;
                    self.disPlayView.equationString = nil;
                }
            }
                break;
            case KBElementValueTypeDelete:
            {
                [self deletePreInputElement];
            }
                break;
            case KBElementValueTypeCash:
            {
                //收款
            }
                break;
            default:
                break;
        }
    }else{
        switch (element.valueType) {
            case KBElementValueTypeNumber:
            {
                [self inPutNumberElement:element];
            }
                break;
            case KBElementValueTypeOperator:
            {
                [self inPutOperatorElement:element];
            }
                break;
            case KBElementValueTypeDot:
            {
                [self inPutDotElement:element];
            }
                break;
            case KBElementValueTypeDelete:
            {
                [self deletePreInputElement];
            }
                break;
            case KBElementValueTypeCash:
            {
               //收款
            }
                break;
            default:
                break;
        }
    }
    
    JY_Log(@"input ---- %@",self.inputString);
}

//输入数字
- (void)inPutNumberElement:(KeyBoardElement *)numberElement{
    if (self.inputString) {
        self.inputString = [self.inputString stringByAppendingString:numberElement.value];
        self.equationString = [self.equationString stringByAppendingString:numberElement.value];
        self.disPlayView.sumString = self.equationString;
        self.disPlayView.equationString = nil;
    }
}

//输入运算符
- (void)inPutOperatorElement:(KeyBoardElement *)operatorElement{
    if (self.inputString) {
        if ([operatorElement.value isEqualToString:@"="] && (self.countStack.count == 0)) {
            return;
        }else{
            [self.countStack addObject:self.inputString];
            self.inputString = nil;
            self.sum = 0;
        }
    }
    id lastObjectd = self.countStack.lastObject;
    if ([lastObjectd isKindOfClass:[KeyBoardElement class]]) {
        return;
    }
    
    self.equationString = [self.equationString stringByAppendingString:operatorElement.value];
    self.disPlayView.sumString = self.equationString;
    self.disPlayView.equationString = nil;
    
    if ([operatorElement.value isEqualToString:@"="]) {
        [self countCurrentSum];
    }else{
        if (self.sum > 0.00) {
            self.sum = 0.00;
        }
        [self.countStack addObject:operatorElement];
    }
}

//输入小数点时判断当前数字中是否有小数点
- (void)inPutDotElement:(KeyBoardElement *)dotElement{
    
    if (self.inputString && ![self.inputString containsString:@"."]) {
        self.inputString = [self.inputString stringByAppendingString:dotElement.value];
        self.equationString = [self.equationString stringByAppendingString:dotElement.value];
        self.disPlayView.sumString = self.equationString;
        self.disPlayView.equationString = nil;
    }
}

//删除前一个输入元素
- (void)deletePreInputElement{
    
    if ( !self.inputString && self.countStack.count == 0) {
        return;
    }
    
    if (self.inputString && self.inputString.length > 0) {
        self.inputString = [self.inputString substringWithRange:NSMakeRange(0, self.inputString.length-1)];
        if (self.inputString.length == 0) {
            self.inputString = nil;
        }
    }else{
        if (self.countStack.count > 0) {
            id lastObject = self.countStack.lastObject;
            if ([lastObject isKindOfClass:[KeyBoardElement class]]) {
                KeyBoardElement *element = (KeyBoardElement *)lastObject;
                if (element.valueType == KBElementValueTypeOperator) {
                    [self.countStack removeLastObject];
                    if (self.countStack.count > 0) {
                        self.inputString = [self.countStack lastObject];
                        [self.countStack removeLastObject];
                    }
                }
            }
        }
    }
    [self decreaseEquationString];
}

- (void)decreaseEquationString{
    if (self.equationString.length > 0) {
        self.equationString = [self.equationString substringWithRange:NSMakeRange(0, self.equationString.length - 1)];
        if (self.equationString.length == 0) {
            self.equationString = nil;
        }
    }
    self.disPlayView.sumString = self.equationString;
    self.disPlayView.equationString = nil;
}

//计算当前总和
- (void)countCurrentSum{
    NSInteger count = self.countStack.count;
    if (count == 0) return;
    CGFloat sum = self.sum;
    for (NSInteger i = 0; i<count; i++) {
        id object = [self.countStack objectAtIndex:i];
        if ([object isKindOfClass:[NSString class]]) {
            NSString *number = (NSString *)object;
            if (self.isAdd) {
                sum += number.floatValue;
            }else{
                sum -= number.floatValue;
            }
        }else if ([object isKindOfClass:[KeyBoardElement class]]){
            KeyBoardElement *operator = (KeyBoardElement *)object;
            if (operator.valueType == KBElementValueTypeOperator) {
                NSString *oper = operator.value;
                self.isAdd = [oper isEqualToString:@"+"]?YES:NO;
            }
        }
    }

    self.sum = sum;
    NSString *sumString = [NSString stringWithFormat:@"%.2f",self.sum];
    self.disPlayView.sumString = sumString;
    self.disPlayView.equationString = self.equationString;
    //计算一次时要清理输入队列
    [self.countStack removeAllObjects];
    self.inputString = sumString;
    self.equationString = [NSString stringWithFormat:@"%@",sumString];
    self.isAdd = YES;
}

@end
