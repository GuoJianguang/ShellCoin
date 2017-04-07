//
//  MerchantSearchRsultViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MerchantSearchRsultViewController.h"
#import "MerchantTableViewCell.h"
#import "MerchantDetailViewController.h"

@interface MerchantSearchRsultViewController ()<UITableViewDelegate,UITableViewDataSource,SortButtonSwitchViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (nonatomic, assign)NSInteger page;

@property (nonatomic, assign)BOOL isContinueRequest;

@end

@implementation MerchantSearchRsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.hidden = YES;
    self.titleLabel.text = self.keyWord;
    self.seqId = @"1";
    self.sortView.titleArray = @[@"默认",@"距离从近到远"];
    self.sortView.delegate = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        self.isContinueRequest = YES;
        [self searchReqest:YES andCity:self.currentCity];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self searchReqest:NO andCity:self.currentCity];
    }];
    [self.tableView noDataSouce];
//    [self.tableView addNoDatasouceWithCallback:^{
//        [self.tableView.mj_header beginRefreshing];
//    } andAlertSting:@"暂时没有数据" andErrorImage:@"pic_1" andRefreshBtnHiden:YES];
    
    [self.tableView.mj_header beginRefreshing];

    
}
#pragma mark - 请求商家列表的网络请求
- (void)searchReqest:(BOOL)isHeader andCity:(NSString *)city
{
    
    if (!isHeader && !self.isContinueRequest) {
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    
    NSString *searchcity = [self.currentCity substringToIndex:2];
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"trade":NullToSpace(self.currentIndustry),
                            @"mchCity":searchcity,
                            @"keyword":NullToSpace(self.keyWord),
                            @"longitude":@([ShellCoinUserInfo shareUserInfos].locationCoordinate.longitude),
                            @"latitude":@([ShellCoinUserInfo shareUserInfos].locationCoordinate.latitude),
                            @"seqId":NullToSpace(self.seqId)};
    [HttpClient GET:@"mch/search" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (self.page == [NullToNumber(jsonObject[@"data"][@"totalPage"]) integerValue]) {
                self.isContinueRequest= NO;
            }
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
            }
            [self.tableView.mj_footer endRefreshing];
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                MerchantModel *model = [MerchantModel modelWithDic:dic];
                model.isSearchResult = YES;
                [self.dataSouceArray addObject:model];
            }
            //判断数据源有无数据
            [self.tableView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        //        self.keyWord = @"";
        [self.tableView showNoDataSouceNoNetworkConnection];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
//        [self.tableView showRereshBtnwithALerString:@"网络连接不好"];
    }];
}


- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

#pragma mark - UITalbeView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MerchantTableViewCell indentify]];
    if (!cell) {
        cell = [MerchantTableViewCell newCell];
    }
    if (self.dataSouceArray.count > 0) {
        cell.dataModel = self.dataSouceArray[indexPath.row];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh*(290/750.);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantDetailViewController *merchantDetailVC = [[MerchantDetailViewController alloc]init];
    merchantDetailVC.mchCode = ((MerchantModel *)self.dataSouceArray[indexPath.row]).code;
    [self.navigationController pushViewController:merchantDetailVC animated:YES];
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
#pragma mark - SortButtonSwitchViewDelegate
- (void)sortBtnDselect:(SortButtonSwitchView *)sortView withSortId:(NSString *)sortId
{
    
    if ([sortId isEqualToString:@"1"]) {
        self.seqId = @"1";
    }else{
        self.seqId = @"2";
        
    }
    [self.tableView.mj_header beginRefreshing];
    
}
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
