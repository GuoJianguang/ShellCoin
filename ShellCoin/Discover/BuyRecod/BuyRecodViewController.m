//
//  WithDrawalRecodViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BuyRecodViewController.h"
#import "BuyRecodTableViewCell.h"

@interface BuyRecodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@end

@implementation BuyRecodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"购买记录";
    __weak BuyRecodViewController *weak_self = self;
    self.talbeView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.page = 1;
        [weak_self getRequest:YES];
    }];
    self.talbeView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getRequest:NO];
    }];
    [self.talbeView noDataSouce];
    [self.talbeView.mj_header beginRefreshing];

}
- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}
- (void)getRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"find/order/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                BuyRecodeModel *model = [BuyRecodeModel modelWithDic:dic];
                [self.dataSouceArray addObject:model];
            }
            [self.talbeView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.talbeView reloadData];
        }
        if (isHeader) {
            [self.talbeView.mj_header endRefreshing];
        }else{
            [self.talbeView.mj_footer endRefreshing];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.talbeView showNoDataSouceNoNetworkConnection];
        if (isHeader) {
            [self.talbeView.mj_header endRefreshing];
        }else{
            [self.talbeView.mj_footer endRefreshing];
            
        }
    }];
}
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSouceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh*(175/750.);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyRecodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BuyRecodTableViewCell indentify]];
    if (!cell) {
        cell = [BuyRecodTableViewCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
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
