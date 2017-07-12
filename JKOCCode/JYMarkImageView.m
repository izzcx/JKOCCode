//
//  JYMarkImageView.m
//  JKOCCode
//
//  Created by silence on 2017/7/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JYMarkImageView.h"

@implementation JYMarkImageView

- (void)downLoadImageWithImgUrl:(NSString *)imgUrl addWaterMarkImg:(NSString *)imgName{
    
    __weak typeof(self) warkSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imgUrl]
                                                    options:SDWebImageRefreshCached
                                                   progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                       
                                                   } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                       
                                                       __strong typeof(self) strongSelf = warkSelf;
                                                       [strongSelf createWatermarkPicWithImage:image waterMarkImage:[UIImage imageNamed:imgName]];
                                                   }];

    
}

- (void)createWatermarkPicWithImage:(UIImage *)image waterMarkImage:(UIImage *)waterMarkImage{
    
    CGFloat imgSizeW = image.size.width;
    CGFloat imgSizeH = image.size.height;
    
    CGFloat bWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat bHeight = UIScreen.mainScreen.bounds.size.height;
    
    CGFloat imgScaleW = imgSizeW/bWidth;
    CGFloat imgScaleH = imgSizeH/bHeight;
    
    if (imgScaleW > imgScaleH) {
        imgSizeW = bWidth;
        imgSizeH = bHeight * bWidth/imgSizeW;
    }else{
        imgSizeH = bHeight;
        imgSizeW = bHeight * bWidth/imgSizeH;
    }
    
    CGFloat markSizeW = waterMarkImage.size.width;
    CGFloat markSizeH = waterMarkImage.size.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(imgSizeW, imgSizeH));
    [image drawInRect:CGRectMake(0, 0, imgSizeW, imgSizeH)];
    [waterMarkImage drawInRect:CGRectMake((imgSizeW-markSizeW)/2.0, (imgSizeH-markSizeH)/2.0, markSizeW, markSizeH)];
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = fullImage;
    });
}

- (void)showImageWithImage:(UIImage *)image addWaterMarkImg:(NSString *)imgName{
    
    [self createWatermarkPicWithImage:image waterMarkImage:[UIImage imageNamed:imgName]];
}


@end
