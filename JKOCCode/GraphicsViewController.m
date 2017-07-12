//
//  GraphicsViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/16.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "GraphicsViewController.h"
#import "JKLineChartView.h"
#import "JKPieChartView.h"
#import "JKNetChartView.h"

@interface GraphicsViewController ()

@end

@implementation GraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Graphics";
    
    JKPieChartView *pieChartView = [[JKPieChartView alloc] initWithFrame:CGRectMake(0, 70, SCREENWIDTH, 100)];
    pieChartView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:pieChartView];
    
    JKNetChartView *netChartView = [[JKNetChartView alloc] initWithFrame:CGRectMake(0, 180, SCREENWIDTH, 150)];
    netChartView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:netChartView];
    
    
    JYLineChartView *lineChartView = [[JYLineChartView alloc] initWithFrame:CGRectMake(0, 320, SCREENWIDTH, 250)];
    lineChartView.chartTitle = @"收款额度统计";
    lineChartView.verticalSpace = 20;
    lineChartView.horizontalSpace = 20;
    lineChartView.lineColor = [UIColor blackColor];
    lineChartView.lineWidth = 1.0;
    lineChartView.titleX = @"金额（元）";
    lineChartView.titleY = nil;
    [self.view addSubview:lineChartView];
    
    NSMutableArray *lineNodesX = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0; i < 6; i++) {
        JYLineChartNode *lineNode = [[JYLineChartNode alloc] init];
        lineNode.nodeValue = @"3050";
        lineNode.nodeKey = @"";
        lineNode.nodeColor = [UIColor redColor];
        [lineNodesX addObject:lineNode];
    }
    lineChartView.lineNodesX = lineNodesX;
    
    NSMutableArray *lineNodesY = [NSMutableArray arrayWithCapacity:6];
    for (int i = 0; i < 6; i++) {
        JYLineChartNode *lineNode = [[JYLineChartNode alloc] init];
        lineNode.nodeValue = @"3050";
        lineNode.nodeKey = @"";
        lineNode.nodeColor = [UIColor redColor];
        [lineNodesY addObject:lineNode];
    }
    lineChartView.lineNodesY = lineNodesY;
    
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
