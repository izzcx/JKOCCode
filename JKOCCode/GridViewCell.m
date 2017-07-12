
//
//  GridViewCell.m
//  JKOCCode
//
//  Created by silence on 2017/3/14.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "GridViewCell.h"

@implementation GridViewCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.frame = self.bounds;
        [self.contentView addSubview:self.imageView];
        [self.imageView addZoom:nil];
        self.livePhotoBadgeImageView.frame = CGRectMake(0, 0, 28, 28);
        [self.contentView addSubview:self.livePhotoBadgeImageView];
    }
    return self;
}

- (void)setAsset:(PHAsset *)asset{
    
    if (_asset != asset) {
        _asset = asset;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:self.bounds.size contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                self.imageView.image = result;
        }];
    }
}

- (void)setThumbnailImage:(UIImage *)thumbnailImage{
    
    if (_thumbnailImage != thumbnailImage) {
        _thumbnailImage = thumbnailImage;
        
        self.imageView.image = thumbnailImage;
    }
}

- (void)setLivePhotoBadgeImage:(UIImage *)livePhotoBadgeImage{
    
    if (_livePhotoBadgeImage != livePhotoBadgeImage) {
        _livePhotoBadgeImage = livePhotoBadgeImage;
        
        self.livePhotoBadgeImageView.image = livePhotoBadgeImage;
    }
}

- (ZoomImgeView *)imageView{
    
    if (!_imageView) {
        _imageView = [[ZoomImgeView alloc] init];
    }
    return _imageView;
}

- (UIImageView *)livePhotoBadgeImageView{
    
    if (!_livePhotoBadgeImageView) {
        _livePhotoBadgeImageView = [[UIImageView alloc] init];
    }
    return _livePhotoBadgeImageView;
}

- (void)prepareForReuse{
    
    [super prepareForReuse];
    self.imageView.image = nil;
    self.livePhotoBadgeImageView.image = nil;
}

@end
