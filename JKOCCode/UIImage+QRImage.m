//
//  UIImage+QRImage.m
//  JKOCCode
//
//  Created by silence on 2017/3/8.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "UIImage+QRImage.h"

@implementation UIImage (QRImage)

+ (UIImage *)imageInsertedImage: (UIImage *)originImage insertImage: (UIImage *)insertImage radius: (CGFloat)radius {
    
    if (!insertImage) { return originImage; }
    
     UIImage * whiteBG = [UIImage imageNamed: @"jcskqr"];
    
    insertImage = [UIImage imageOfRoundRectWithImage: insertImage size: insertImage.size radius: radius];
    
    whiteBG = [UIImage imageOfRoundRectWithImage: whiteBG size: whiteBG.size radius: radius];
    
    //白色边缘宽度
    
    const CGFloat whiteSize = 2.f;
    
    CGSize brinkSize = CGSizeMake(originImage.size.width / 4, originImage.size.height / 4);
    
    CGFloat brinkX = (originImage.size.width - brinkSize.width) * 0.5;
    
    CGFloat brinkY = (originImage.size.height - brinkSize.height) * 0.5;
    
    CGSize imageSize = CGSizeMake(brinkSize.width - 2 * whiteSize, brinkSize.height - 2 * whiteSize);
    
    CGFloat imageX = brinkX + whiteSize;
    
    CGFloat imageY = brinkY + whiteSize;
    
    UIGraphicsBeginImageContext(originImage.size);
    
    [originImage drawInRect: (CGRect){ 0, 0, (originImage.size) }];
    
    [whiteBG drawInRect: (CGRect){ brinkX, brinkY, (brinkSize) }];
    
    [insertImage drawInRect: (CGRect){ imageX, imageY, (imageSize) }];
    
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
    
}

+ (UIImage *)imageOfRoundRectWithImage: (UIImage *)image size: (CGSize)size radius: (CGFloat)radius

{
    
    if (!image) { return nil; }
    
    const CGFloat width = size.width;
    
    const CGFloat height = size.height;
    
    radius = MAX(5.f, radius);
    
    radius = MIN(10.f, radius);
    
    UIImage * img = image;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    //绘制圆角
    CGContextBeginPath(context);
    CGContextAddRect(context, rect);
   // CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
   // addRoundRectToPath(context, rect, radius, img.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    
    img = [UIImage imageWithCGImage: imageMasked];
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    CGImageRelease(imageMasked);
    
    return img;
    
}


+(UIImage *)addSubImage:(UIImage *)img sub:(UIImage *) subImage
{
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int subWidth = subImage.size.width;
    int subHeight = subImage.size.height;
    subWidth = 75;
    subHeight = 75;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake( (w-subWidth)/2, (h - subHeight)/2, subWidth, subHeight), [subImage CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    //  CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}

@end
