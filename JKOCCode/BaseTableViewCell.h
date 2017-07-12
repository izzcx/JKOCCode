//
//  BaseTableViewCell.h
//  JKOCCode
//
//  Created by silence on 2017/3/1.
//  Copyright © 2017年 silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

- (void)initSubViews;
- (void)addContraintsForSubViews;
- (void)updateConstraintsForSubViews;

@end
