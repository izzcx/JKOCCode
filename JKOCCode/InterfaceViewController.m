//
//  InterfaceViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "InterfaceViewController.h"
#import "ShapeView.h"
#import "JumpAnimationView.h"
#import "JYFiltResultController.h"

@interface InterfaceViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,
UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) ShapeView *shapeView;
@property (nonatomic, strong) UILabel *attLablel;

@property (nonatomic, strong) JumpAnimationView *jumpView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchController *searchVC;

@property (nonatomic, strong) UITableViewController *resultTableVC;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation InterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Interface";
    
    [self addImgView];
    
}

- (void)addImgView{
    
    [self.view addSubview:self.imgView];
    
    __weak typeof(self) warkSelf = self;
   [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:@"https://image1.jyall.com/v1/tfs/T1oNKgByxT1R4cSCrK.png"]
                                                   options:SDWebImageRefreshCached
                                                  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                      
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        __strong typeof(self) strongSelf = warkSelf;
        [strongSelf createWatermarkPicWithImage:image waterMarkImage:[UIImage imageNamed:@"watermark_big"]];
    }];

}

- (void)createWatermarkPicWithImage:(UIImage *)image waterMarkImage:(UIImage *)waterMarkImage{
    
    CGFloat imgSizeW = image.size.width;
    CGFloat imgSizeH = image.size.height;

    CGFloat bWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat bHeight = UIScreen.mainScreen.bounds.size.height;
    
    CGFloat imgScaleW = imgSizeW/bWidth;
    CGFloat imgScaleH = imgSizeH/bHeight;
    
    if (imgScaleW > imgScaleH) {
        imgSizeW = bWidth;
        imgSizeH = bHeight * bWidth/imgSizeW;
    }else{
        imgSizeH = bHeight;
        imgSizeW = bHeight * bWidth/imgSizeH;
    }
    
    CGFloat markSizeW = waterMarkImage.size.width;
    CGFloat markSizeH = waterMarkImage.size.height;

    UIGraphicsBeginImageContext(CGSizeMake(imgSizeW, imgSizeH));
    [image drawInRect:CGRectMake(0, 0, imgSizeW, imgSizeH)];
    [waterMarkImage drawInRect:CGRectMake((imgSizeW-markSizeW)/2.0, (imgSizeH-markSizeH)/2.0, markSizeW, markSizeH)];
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    dispatch_async(dispatch_get_main_queue(), ^{
        self.imgView.image = fullImage;
    });
}

-(UIImage *)addText:(UIImage *)img text:(NSString *)text1
{
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
    char* text = (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 0, 0, 1);
    CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

- (void)addTableView{
    self.tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableView];
}

- (void)filtViewController{
    
    JYFiltResultController *resultVC = [[JYFiltResultController alloc] init];
    resultVC.tableView.tag = 100;
    self.resultTableVC = resultVC;
    
    UISearchController *searchVC = [[UISearchController alloc] initWithSearchResultsController:resultVC];
    self.searchVC = searchVC;
    self.searchVC.searchResultsUpdater = self;
    [self.searchVC.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    
    self.resultTableVC.tableView.delegate = self;
    self.searchVC.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchVC.searchBar.delegate = self; // so we can monitor text changes + others
    self.definesPresentationContext = YES;

}

- (void)jumpAnimation{
    
    JumpAnimationView *jumpView = [[JumpAnimationView alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    jumpView.backgroundColor = [UIColor blackColor];
    jumpView.ballBackground = [UIColor whiteColor];
    [self.view addSubview:jumpView];
    
    [self buttonAssociatedObject];
    [self.view addSubview:self.shapeView];

}

- (void)attributeStringShow{
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"￥112.30"];
    [attributeString addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:30.0f]
                            range:NSMakeRange(1, 3)];
    
    self.attLablel.attributedText = attributeString;
    [self.view addSubview:self.attLablel];

}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark --- datasource tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell_result_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSString *stringIndexPath = indexPath.description;
    cell.textLabel.text = stringIndexPath;
    
    return cell;
    
}

#pragma mark --- delegate tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UILabel *)attLablel{
    
    if (!_attLablel) {
        _attLablel = [[UILabel alloc] initWithFrame:CGRectMake(0, 130, 200, 100)];
        _attLablel.textColor = [UIColor blackColor];
    }
    return _attLablel;
}

- (UIView *)shapeView{
    
    if (!_shapeView) {
        _shapeView = [[ShapeView alloc] initWithFrame:self.view.bounds];
    }
    return _shapeView;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    return _imgView;
}

//UIButton 属性关联
- (void)buttonAssociatedObject{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor redColor]];
    button.frame = CGRectMake(10, 100, 100, 100);
    [button setTitle:@"你好" forState:UIControlStateNormal];
    UIImage *buttonImage = [UIImage imageNamed:@"jkoc-1"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.highImageName = @"jkoccode.jpeg";
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
