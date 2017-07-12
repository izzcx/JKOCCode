//
//  FirstViewController.m
//  JKOCCode
//
//  Created by silence on 2017/2/27.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "ExampleListViewController.h"
#import "RunTimeViewController.h"
#import "InterfaceViewController.h"
#import "GCDViewController.h"
#import "BlockViewController.h"
#import "NetworkViewController.h"
#import "TestViewController.h"
#import "QRCodeViewController.h"
#import "LayerViewController.h"
#import "PhotoViewController.h"
#import "ChartViewController.h"
#import "GraphicsViewController.h"
#import "BaseViewController.h"

@interface ExampleListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *exampleTableView;
@property (nonatomic, strong) NSArray *tableArray;
@property (nonatomic, strong) NSDictionary *tableDic;

@end

@implementation ExampleListViewController

- (UITableView *)exampleTableView{
    
    if (!_exampleTableView) {
        _exampleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _exampleTableView.delegate = self;
        _exampleTableView.dataSource = self;
        _exampleTableView.tableFooterView = [[UIView alloc] init];
    }
    return _exampleTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ExampleList";
    self.tableArray = @[@"UI",@"Runtime",@"GCD",@"Block",@"Network",@"QRCode",@"Layer",@"PHPhoto",@"Chart",@"Graphics"];
    self.tableDic   = @{@"UI":@"InterfaceViewController",
                        @"Runtime":@"RunTimeViewController",
                        @"GCD":@"GCDViewController",
                        @"Block":@"BlockViewController",
                        @"Network":@"NetworkViewController",
                        @"QRCode":@"QRCodeViewController",
                        @"Layer":@"LayerViewController",
                        @"PHPhoto":@"PhotoViewController",
                        @"Chart":@"ChartViewController",
                        @"Graphics":@"GraphicsViewController",
                        @"test":@"TestViewController",
                        @"baseVC":@"BaseViewController"};
    [self.view addSubview:self.exampleTableView];
}

#pragma mark ---- delegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"jkocCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.textLabel.textColor = [UIColor colorWithRed:arc4random()%255/255.0
                                                   green:arc4random()%255/255.0
                                                    blue:arc4random()%255/255.0
                                                   alpha:1.0];
    }
    NSString *title = [self.tableArray objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = [self.tableArray objectAtIndex:indexPath.row];
    NSString *vcString = [self.tableDic objectForKey:title];
    Class vcClass = NSClassFromString(vcString);
    id vcInstance = [[vcClass alloc] init];
    if ([vcInstance isKindOfClass:[UIViewController class]]) {
        UIViewController *pushVc = (UIViewController *)vcInstance;
        pushVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vcInstance animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
