//
//  Bill3View.m
//  ShellCoin
//
//  Created by Guo on 2017/4/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "Bill3View.h"
#import "IntergralRecordTableViewCell.h"

@interface Bill3View()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@end

@implementation Bill3View

- (void)reload
{
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"Bill3View" owner:nil options:nil][0];
        self.backgroundColor = [UIColor cyanColor];
        self.tableView.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        __weak Bill3View *weak_self = self;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page = 1;
            [weak_self getshouyijilujiluRequest:YES];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getshouyijilujiluRequest:NO];
        }];
        [self.tableView noDataSouce];
        [self reload];
        
    }
    return self;
}

- (void)getshouyijilujiluRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/wallet/feedback/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                FanxianModel *model = [FanxianModel modelWithDic:dic];
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
    return TWitdh*(190/750.);

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntergralRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[IntergralRecordTableViewCell indentify]];
    if (!cell) {
        cell = [IntergralRecordTableViewCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


@end
