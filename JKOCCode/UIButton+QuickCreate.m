//
//  UIButton+QuickCreate.m
//  JKOCCode
//
//  Created by silence on 2017/3/1.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIButton+QuickCreate.h"
#import <objc/runtime.h>

static NSString *nomaltitleString;
static NSString *hightitleString;
static NSString *normalimagenameString;
static NSString *highimagenameString;

@implementation UIButton (QuickCreate)

- (void)setNormalTitle:(NSString *)normalTitle{
    objc_setAssociatedObject(self, &nomaltitleString, normalTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

- (void)setHighTitle:(NSString *)highTitle{
    objc_setAssociatedObject(self, &hightitleString, highTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setTitle:highTitle forState:UIControlStateHighlighted];
}

- (void)setNormalImageName:(NSString *)normalImageName{
    objc_setAssociatedObject(self, &normalimagenameString, normalImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    [self setImage:normalImage forState:UIControlStateNormal];
}

- (void)setHighImageName:(NSString *)highImageName{
    objc_setAssociatedObject(self, &highimagenameString, highImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIImage *highImage = [UIImage imageNamed:highImageName];
    [self setImage:highImage forState:UIControlStateHighlighted];
}

- (NSString *)normalTitle{
    return objc_getAssociatedObject(self, &nomaltitleString);
}

- (NSString *)highTitle{
    return objc_getAssociatedObject(self, &hightitleString);
}
- (NSString *)highImageName{
    return objc_getAssociatedObject(self, &highimagenameString);
}
- (NSString *)normalImageName{
    return objc_getAssociatedObject(self, &normalimagenameString);
}


@end
