//
//  UIImage+QRImage.h
//  JKOCCode
//
//  Created by silence on 2017/3/8.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRImage)

+ (UIImage *)imageInsertedImage: (UIImage *)originImage insertImage: (UIImage *)insertImage radius: (CGFloat)radius;

+ (UIImage *)imageOfRoundRectWithImage: (UIImage *)image size: (CGSize)size radius: (CGFloat)radius;

+(UIImage *)addSubImage:(UIImage *)img sub:(UIImage *) subImage;

@end
