//
//  LoopLayout.m
//  LTM_iOS
//
//  Created by FW on 2016/12/14.
//  Copyright © 2016年 FW. All rights reserved.
//

#import "LoopLayout.h"

@implementation LoopLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = CGSizeMake(kScreenWidth, (int)(170 * kScreenWidth / 375));
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}


- (CGPoint)nearByOffSet:(CGPoint)contentOffSet withVeloctiy:(CGPoint)velocity
{
    // 以中线位置为基准的偏移量
    CGFloat center_x = contentOffSet.x + kScreenWidth * 0.5;
    // 在中线之前 完整cell + interva的个数
    NSInteger index = (center_x) / self.itemSize.width;
    // 剩余偏移量：cell在中线左边的宽度 正数
    CGFloat remain_x = (center_x) - (index * self.itemSize.width);
    // 滑动最小量：这个参数控制cell偏移到什么程度才会跳转到下一个。也可以写死一个数
    CGFloat minOffset = (self.itemSize.width/20);
    if (remain_x > (self.itemSize.width*0.5+minOffset) && velocity.x > 0) {
        index += 1;
    }
    else if (remain_x < (self.itemSize.width * 0.5 - minOffset) && velocity.x < 0)
    {
        index -= 1;
    }
    else if (remain_x > (self.itemSize.width-minOffset) && velocity.x == 0)
    {
        index += 1;
    }
    else if (remain_x < minOffset && velocity.x == 0)
    {
        index -= 1;
    }
    // 应该停靠的位置
    CGFloat point_x = (index * self.itemSize.width) + self.itemSize.width * 0.5 - (kScreenWidth * 0.5);
    CGPoint targetOffSet = CGPointMake(point_x - (CGRectGetWidth(self.collectionView.frame) - kScreenWidth) * 0.5,contentOffSet.y);
    return targetOffSet;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGPoint targetContentOffset;
    CGPoint endDraggingVelocity = velocity;
    if (endDraggingVelocity.x == 0) {
        targetContentOffset = [self nearByOffSet:self.collectionView.contentOffset withVeloctiy:velocity];
    }
    else
    {
        targetContentOffset = [self nearByOffSet:self.collectionView.contentOffset withVeloctiy:velocity];
    }
    
    return targetContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    // 返回yes会实时更新layout
    return YES;
}

@end
