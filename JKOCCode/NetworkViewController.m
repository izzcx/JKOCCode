//
//  NetworkViewController.m
//  JKOCCode
//
//  Created by silence on 2017/3/3.
//  Copyright © 2017年 silence. All rights reserved.
//

#import "NetworkViewController.h"
#import "HomeInfoModel.h"

@interface NetworkViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation NetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Network";
    
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:1];
//    AFHTTPRequestOperation *operstion = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
//    [operstion start];
//    [operstion waitUntilFinished];
//    return operstion.responseData;
    
    
//    [self requestDataReloadTable];
    
}
- (void)requestDataReloadTable{
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
    NetRequestObject *requestObject = [[NetRequestObject alloc] init];
    requestObject.modelClsString = @"HomeInfoModel";
    requestObject.requestType = NetRequestTypePOST;
    requestObject.hostUrl = @"http://vcis.ifeng.com/api/liveAddress?adapterNo=7.2.0&platformType=iPhone&protocol=1.0.0";
    
    [ShouBaNetInterface sbHomeNetRequestListInfoWithNetRequestObject:requestObject responseObject:^(NetResponseObject *reponseObject) {
        
        if (reponseObject.isSuccess) {
            self.dataArray = reponseObject.reponseData;
            [self.tableView reloadData];
            JY_Log(@" 请求成功  ");
        }else{
            JY_Log(@" 请求失败  ");
        }
        
    }];

}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"netCellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    HomeInfoModel *infoModel = [self.dataArray objectAtIndex:indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:infoModel.img490_490]];
    cell.textLabel.text = infoModel.cName;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
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
