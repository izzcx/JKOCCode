//
//  KeyBoardElement.h
//  JKOCCode
//
//  Created by silence on 2017/3/23.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    KBElementValueTypeNumber,
    KBElementValueTypeOperator,
    KBElementValueTypeDot,
    KBElementValueTypeDelete,
    KBElementValueTypeCash,
} KBElementValueType;

@interface KeyBoardElement : NSObject

@property (nonatomic, copy)   NSString *value;
@property (nonatomic, assign) KBElementValueType valueType;

@end
