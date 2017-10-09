//
//  NewFrontierActivityView.m
//  LTM_iOS
//
//  Created by 黄翩翩 on 16/7/1.
//  Copyright © 2016年 Lavion. All rights reserved.
//

#import "NewFrontierActivityView.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define LTMMAINCOLOR     [UIColor whiteColor]
#define PLACEHOLDERIMAGE [UIImage imageNamed:@"jcskqr.jpg"]

@interface NewFrontierActivityView()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UIPageControl * _pageControl;
    NSMutableArray < UIImageView * >* _imageViewArray;
    NSInteger        _currentPage;
    UIImageView * _singleImageView;
    dispatch_source_t _timer;
    NSInteger _timeCount;
}
@end


@implementation NewFrontierActivityView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageViewArray = [[NSMutableArray alloc] init];
        self.backgroundColor = LTMMAINCOLOR;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 170)];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        _scrollView.backgroundColor = [UIColor clearColor];
        _currentPage = 0;
    }
    return self;
}


- (void)setActiviteArray:(NSArray *)activiteArray
{
    if (activiteArray) {
        _activiteArray = activiteArray;
        
        if (_activiteArray.count == 0) {
            return ;
        }
        
        for (UIImageView * imageView in _imageViewArray) {
            [imageView removeFromSuperview];
        }
        [_imageViewArray removeAllObjects];
        [_singleImageView removeFromSuperview];
        _singleImageView = nil;
        _timeCount = 0;
        _currentPage = 0;
        if (activiteArray.count > 1) {
            for (int i = 0; i < 3; i ++) {
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake( (_scrollView.width * i), 0, SCREENWIDTH , _scrollView.height)];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
                [imageView addGestureRecognizer:tap];
                
                [_scrollView addSubview:imageView];
                [_imageViewArray addObject:imageView];
            }
            
            if (!_pageControl) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _pageControl = [[UIPageControl alloc] init];
                    _pageControl.userInteractionEnabled = NO;
                    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
                    _pageControl.currentPageIndicatorTintColor = LTMMAINCOLOR;
                    [self addSubview:_pageControl];
                });
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CGFloat width =[_pageControl sizeForNumberOfPages:_activiteArray.count].width;
                CGFloat height = [_pageControl sizeForNumberOfPages:_activiteArray.count].height;
                _pageControl.frame = CGRectMake(0, _scrollView.height-height, width, height);
                _pageControl.centerX = _scrollView.centerX;
                _pageControl.numberOfPages = activiteArray.count;
                _pageControl.currentPage = 0;
            });
            _scrollView.contentSize = CGSizeMake(SCREENWIDTH * 3, 0);
            _scrollView.contentOffset = CGPointMake(SCREENWIDTH, 0);
            [self loadPageWithIndex:0];
            if (!_timer) {
                [self startTime];
            }
        }
        else
        {
            
            if (_timer) {
                dispatch_source_cancel(_timer);
                _timer = nil;
            }
            
            if (!_singleImageView) {
                _singleImageView = [[UIImageView alloc] init];
                _singleImageView.userInteractionEnabled = YES;
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
                [_singleImageView addGestureRecognizer:tap];
                _singleImageView.layer.cornerRadius = 4.0f;
                _singleImageView.layer.masksToBounds = YES;
                [_scrollView addSubview:_singleImageView];
            }
            _singleImageView.frame = CGRectMake(0, 0, SCREENWIDTH , _scrollView.height);
//            [_singleImageView imageWithUrl:((FrontierActivityModel*)activiteArray[0]).image placeHolderImage:PLACEHOLDERIMAGE];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _timeCount = 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / SCREENWIDTH;
    if (index < 1) {
        _currentPage = _currentPage - 1 < 0 ? _activiteArray.count - 1 : _currentPage -  1;
        [self loadPageWithIndex:_currentPage];
    }
    else
    {
        _currentPage = _currentPage + 1 >= _activiteArray.count ? 0 : _currentPage + 1;
        [self loadPageWithIndex:_currentPage];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        NSInteger index = scrollView.contentOffset.x / SCREENWIDTH;
        if (index < 1) {
            _currentPage = _currentPage - 1 < 0 ? _activiteArray.count - 1 : _currentPage -  1;
            [self loadPageWithIndex:_currentPage];
        }
        else
        {
            _currentPage = _currentPage + 1 >= _activiteArray.count ? 0 : _currentPage + 1;
            [self loadPageWithIndex:_currentPage];
        }
    }
}

- (void)loadPageWithIndex:(NSInteger)index
{
    _pageControl.currentPage = index;
    _scrollView.contentOffset = CGPointMake(SCREENWIDTH, 0);
    UIImageView * imageView = _imageViewArray[0];
//    [imageView imageWithUrl:_activiteArray[(index - 1) >= 0 ? index - 1 : _activiteArray.count - 1].image placeHolderImage:PLACEHOLDERIMAGE];
    
    imageView = _imageViewArray[1];
//    [imageView imageWithUrl:_activiteArray[index].image placeHolderImage:PLACEHOLDERIMAGE];
    
    imageView = _imageViewArray[2];
//    [imageView imageWithUrl:_activiteArray[(index + 1) >= _activiteArray.count ? 0 : index + 1].image placeHolderImage:PLACEHOLDERIMAGE];
    
}

- (void)startTime
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        _timeCount ++;
        if (_timeCount == 3) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self rollScrollView];
            });
        }
    });
    dispatch_resume(_timer);
}

- (void)rollScrollView
{
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(_scrollView.width * 2, 0);
    } completion:^(BOOL finished) {
        NSInteger index = _scrollView.contentOffset.x/_scrollView.bounds.size.width;
        if (index > 1) {
            _currentPage ++;
        }
        else if (index < 1)
        {
            _currentPage --;
        }
        
        if (_currentPage >= _activiteArray.count) {
            _currentPage = 0;
        }
        if (_currentPage < 0) {
            _currentPage = _activiteArray.count - 1;
        }
        [self loadPageWithIndex:_currentPage];
    }];
}

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    if (_tapImageView) {
        _tapImageView(_activiteArray[_currentPage],_currentPage);
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return [super hitTest:point withEvent:event];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
