//
//  SecondViewController.m
//  JKOCCode
//
//  Created by silence on 2017/2/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "TestViewController.h"
#import "JKBaseGraphicsView.h"
#import "ShouBaCounterView.h"

@interface TestViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *subView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) ShouBaCounterView *counterView;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Test";
    
    JY_Fun_Log(@"什么也没有");
    JY_L_Log(@"在这里");
    JY_Log(@"输出什么了");
    
    [self.view addSubview:self.counterView];
    NSString* textContent = @"100000玩的柳树";
    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.alignment = NSTextAlignmentRight;
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: 8], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};

    CGRect textSize = [textContent boundingRectWithSize: CGSizeMake(1000, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil];
    JY_Log(@"test ----%@",NSStringFromCGRect(textSize));
    
    JKBaseGraphicsView *baseGraphics = [[JKBaseGraphicsView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 400)];
    baseGraphics.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseGraphics];
    
    
    NSString *testString = @"mknsikcksl";
    NSString *subString = [testString substringWithRange:NSMakeRange(0, 0)];
    
    JY_Log(@"----- substing ---- %@",subString);
    
}

- (ShouBaCounterView *)counterView{
    if (!_counterView) {
        _counterView = [[ShouBaCounterView alloc] initShowBaCounterView];
    }
    return _counterView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
