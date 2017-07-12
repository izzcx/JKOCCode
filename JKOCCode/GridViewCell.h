//
//  GridViewCell.h
//  JKOCCode
//
//  Created by silence on 2017/3/14.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomImgeView.h"

@interface GridViewCell : UICollectionViewCell

@property (nonatomic, strong) ZoomImgeView *imageView;
@property (nonatomic, strong) UIImageView *livePhotoBadgeImageView;

@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) UIImage *livePhotoBadgeImage;

@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, copy) NSString *representedAssetIdentifier;

@end
