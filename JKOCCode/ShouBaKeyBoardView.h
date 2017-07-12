//
//  ShouBaKeyBoardView.h
//  JKOCCode
//
//  Created by silence on 2017/3/22.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShouBaKeyBoardView;
@class KeyBoardElement;
@protocol ShouBaKeyBoardViewDelegate <NSObject>

@optional
- (void)shouBaKeyBoardView:(ShouBaKeyBoardView *)keyBoardView didSelectElement:(KeyBoardElement *)element;

@end

@interface ShouBaKeyBoardView : UIView

@property (nonatomic, strong) NSArray *keyBoardElements;
@property (nonatomic, weak) id<ShouBaKeyBoardViewDelegate> kbDelegate;

@end
