//
//  MessageListViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageTableViewCell.h"
#import "MessageDetailViewController.h"

@interface MessageListViewController ()<UITableViewDelegate,UITableViewDataSource,BasenavigationDelegate>
@property (nonatomic, strong)NSMutableArray *datasouceArray;

@property (nonatomic, assign)NSInteger page;
@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.naviBar.title = @"消息";
    self.naviBar.delegate = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self alldetailReqest:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self alldetailReqest:NO];
    }];

    [self.tableView noDataSouce];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)alldetailReqest:(BOOL)isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient GET:@"user/message/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.datasouceArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            }
            [self.tableView.mj_footer endRefreshing];
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                [self.datasouceArray addObject:[MessafeModel modelWithDic:dic]];
            }
            //判断数据源有无数据
            [self.tableView reloadData];
            [self.tableView judgeIsHaveDataSouce:self.datasouceArray];
            return ;
        }
        if (isHeader) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView showNoDataSouceNoNetworkConnection];
        
    }];
}

#pragma mark - UITableView
- (NSMutableArray *)datasouceArray
{
    if (!_datasouceArray) {
        _datasouceArray = [NSMutableArray array];
    }
    return _datasouceArray;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasouceArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return TWitdh*(120/750.);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:[MessageTableViewCell indentify]];
    if (!cell) {
        cell = [MessageTableViewCell newCell];
    }
    if (self.datasouceArray.count > 0) {
        cell.dataModel = self.datasouceArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *messageid = ((MessafeModel*)self.datasouceArray[indexPath.row]).messageid;
    NSDictionary *dic = @{@"id":messageid,
                          @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/message/update" parameters:dic success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.tableView.mj_header beginRefreshing];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    
    MessageDetailViewController *detailVC = [[MessageDetailViewController alloc]init];
    detailVC.dataModel = self.datasouceArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
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
