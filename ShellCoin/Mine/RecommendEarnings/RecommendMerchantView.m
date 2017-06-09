//
//  RecommendMerchantView.m
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "RecommendMerchantView.h"
#import "RecommendDetailTableViewCell.h"

@interface RecommendMerchantView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@end

@implementation RecommendMerchantView
- (void)reload
{
    [self.tableView.mj_header beginRefreshing];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"RecommendMerchantView" owner:nil options:nil][0];
        self.tableView.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        __weak RecommendMerchantView *weak_self = self;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weak_self request:YES];
        }];
        [self.tableView noDataSouce];
        [self reload];
    }
    return self;
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (void)request:(BOOL )isHeader
{
    NSDictionary *prams = @{
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/recommendProfit/mch/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"];
            for (NSDictionary *dic in array) {
                RecommendMerchantModel *model = [RecommendMerchantModel modelWithDic:dic];
                [self.dataSouceArray addObject:model];
            }
            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.tableView reloadData];
        }
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView showNoDataSouceNoNetworkConnection];
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
            
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
    return TWitdh*(150/750.);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RecommendDetailTableViewCell indentify]];
    if (!cell) {
        cell = [RecommendDetailTableViewCell newCell];
    }
    cell.merchantModel = self.dataSouceArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
