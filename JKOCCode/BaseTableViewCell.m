//
//  BaseTableViewCell.m
//  JKOCCode
//
//  Created by silence on 2017/3/1.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
    
        [self initSubViews];
        [self addContraintsForSubViews];
        
    }
    return self;
}

- (void)initSubViews{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bgView];
}

- (void)addContraintsForSubViews{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)updateConstraintsForSubViews{
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)reMarkConstraintsForSubViews{
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

// get

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIButton *)button{
    
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        [_button setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [_button setTitle:@"test" forState:UIControlStateNormal];
        [_button setTitle:@"test" forState:UIControlStateHighlighted];
    }
    return _button;
}


@end
