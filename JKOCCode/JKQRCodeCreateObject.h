//
//  JKQRCodeCreateObject.h
//  JKOCCode
//
//  Created by silence on 2017/3/7.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKQRCodeCreateObject : NSObject

+ (UIImage *)createQRCodeImageWithString:(NSString *)codeString;

@end
