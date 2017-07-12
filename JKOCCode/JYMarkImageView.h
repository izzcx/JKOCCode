//
//  JYMarkImageView.h
//  JKOCCode
//
//  Created by silence on 2017/7/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYMarkImageView : UIImageView

/**
 显示带水印图片
 
 @param imgUrl 图片地址
 @param imgName 水印图片名字
 */
- (void)downLoadImageWithImgUrl:(NSString *)imgUrl addWaterMarkImg:(NSString *)imgName;


/**
 显示带水印图片
 
 @param image 图片
 @param imgName 水印图片名字
 */
- (void)showImageWithImage:(UIImage *)image addWaterMarkImg:(NSString *)imgName;


@end
