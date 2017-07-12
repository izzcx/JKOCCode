//
//  JYCashScuessViewController.m
//  ShouBa
//
//  Created by silence on 2017/3/28.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "JYCashScuessViewController.h"

@interface JYCashScuessViewController ()

@property (nonatomic, strong) UILabel *receviedLabel;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *lookButton;

@end

@implementation JYCashScuessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收款成功";
    [self initSubViews];
    
    self.sumString = @"183.00";
}

- (void)initSubViews{
    
    [self.view addSubview:self.receviedLabel];
    [self.view addSubview:self.sumLabel];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.lookButton];
    
    [self updateViewConstraints];
}

#pragma mark -- set

- (void)setSumString:(NSString *)sumString{
    
    if (_sumString != sumString ) {
        _sumString = sumString;
        
        NSString *sum = [NSString stringWithFormat:@"￥%@",_sumString];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:sum];
        [attribute addAttribute:NSFontAttributeName
                                value:[UIFont boldSystemFontOfSize:20.0f]
                                range:NSMakeRange(0, sum.length-2)];
        _sumLabel.attributedText = attribute;
    }
}

#pragma mark --- get

- (UILabel *)receviedLabel{
    
    if (!_receviedLabel) {
        _receviedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _receviedLabel.font = [UIFont systemFontOfSize:12];
        _receviedLabel.backgroundColor = [UIColor clearColor];
        _receviedLabel.textAlignment = NSTextAlignmentCenter;
        _receviedLabel.textColor = [UIColor blackColor];
        _receviedLabel.text = @"已收款";
        _receviedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _receviedLabel;
}

- (UILabel *)sumLabel{
    
    if (!_sumLabel) {
        _sumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _sumLabel.font = [UIFont systemFontOfSize:13];
        _sumLabel.backgroundColor = [UIColor clearColor];
        _sumLabel.textAlignment = NSTextAlignmentCenter;
        _sumLabel.textColor = [UIColor blackColor];
        _sumLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _sumLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor orangeColor];
        _imageView.image = [UIImage imageNamed:@""];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

- (UIButton *)lookButton{
    
    if (!_lookButton) {
        _lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookButton setBackgroundColor:[UIColor lightGrayColor]];
        [_lookButton setTitle:@"查看" forState:UIControlStateNormal];
        [_lookButton setTitle:@"查看" forState:UIControlStateHighlighted];
        [_lookButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_lookButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_lookButton addTarget:self action:@selector(lookCashDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        _lookButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _lookButton;
}

#pragma mark --- layout

- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    
    __weak typeof(self) weakSelf = self;
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(196, 196));
        make.center.equalTo(weakSelf.view).centerOffset(CGPointMake(0, -50));
      }];
    
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(weakSelf.imageView.mas_top).with.offset(-30);
    }];
    
    [self.receviedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.bottom.equalTo(weakSelf.sumLabel.mas_top).offset(-10);
    }];
    
    [self.lookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.equalTo(weakSelf.imageView.mas_bottom).with.offset(50);
    }];
    
}

#pragma mark --- event

- (void)lookCashDetailAction:(UIButton *)button{
    
    NSLog(@"进入收款详情--- ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
