//
//  RecommendConsumersView.m
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "RecommendConsumersView.h"
#import "RecommendDetailTableViewCell.h"

@interface RecommendConsumersView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@end

@implementation RecommendConsumersView
- (void)reload
{
    [self.tableView.mj_header beginRefreshing];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"RecommendConsumersView" owner:nil options:nil][0];
        self.tableView.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        __weak RecommendConsumersView *weak_self = self;
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
    [HttpClient POST:@"user/recommendProfit/user/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                ConsumersModel *model = [ConsumersModel modelWithDic:dic];
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
    cell.consumersModel = self.dataSouceArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

@end
