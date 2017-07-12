//
//  ZoomImgeView.h
//  WXWeibo
//
#import <UIKit/UIKit.h>

@protocol ZoomImageViewDelegate <NSObject>

@optional
//1.图片放大协议方法
- (void)imageWillZoomIn:(UIView *)view;
- (void)imageDidZoomIn:(UIView *)view;

//2.图片缩小协议方法
- (void)imageWillZoomOut:(UIView *)view;
- (void)imageDidZoomOut:(UIView *)view;

@end


@class DDProgressView;
@interface ZoomImgeView : UIImageView<NSURLConnectionDataDelegate> {
@private
    UIScrollView *_scrollView;
    UIImageView  *_fullImageView;
    DDProgressView *_progressView;
    UIButton        *_saveButton;
    
    //大图数据的长度
    double _length;
    NSMutableData *_data;
}

@property(nonatomic,copy)NSString *urlstring;
@property(nonatomic,retain)NSURLConnection *connection;
@property(nonatomic,assign)id<ZoomImageViewDelegate> delegate;
@property(nonatomic,assign)BOOL isGif;

- (void)addZoom:(NSString *)urlstring;
- (void)zoomOutAction;

@end
