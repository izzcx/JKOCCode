//
//  NewFrontierActivityView.h
//  LTM_iOS
//
//  Created by 黄翩翩 on 16/7/1.
//  Copyright © 2016年 Lavion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFrontierActivityView : UIView

@property (nonatomic , strong) UIImageView * baseImageView;

@property (nonatomic , copy) NSArray* activiteArray;

@property (nonatomic , copy) void (^tapImageView)(NSString *string,NSInteger index);
@end
