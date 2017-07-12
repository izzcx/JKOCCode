//
//  PhotoCollectionViewController.h
//  JKOCCode
//
//  Created by silence on 2017/3/14.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewController : UIViewController

@property (nonatomic, strong) PHFetchResult<PHAsset *> *fetchResult;
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end
