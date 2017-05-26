//
//  MyRecommendViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MyRecommendViewController.h"
#import "DiscoverRecommendTableViewCell.h"
#import "DiscoverQrCodeViewController.h"

@interface MyRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@end

@implementation MyRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
    self.totalAmount.adjustsFontSizeToFitWidth = self.activatedAmount.adjustsFontSizeToFitWidth = YES;
    
    __weak MyRecommendViewController *weak_self = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.page = 1;
        [weak_self getRequest:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getRequest:NO];
    }];
    [self.tableView noDataSouce];
    [self.tableView.mj_header beginRefreshing];
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
    [HttpClient POST:@"find/recommend/profit/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            if (self.page == 1) {
                
                self.activatedAmount.text = [NSString stringWithFormat:@"¥%.2f",[NullToNumber(jsonObject[@"data"][@"totalCostRebateAmount"]) doubleValue]];
                self.totalAmount.text = [NSString stringWithFormat:@"¥%.2f",[NullToNumber(jsonObject[@"data"][@"totalRecommendRebateAmount"]) doubleValue]];

            }
            NSArray *array =jsonObject[@"data"][@"list"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                DiscoverRecommendModel *model = [DiscoverRecommendModel modelWithDic:dic];
                model.sysTime = NullToNumber(jsonObject[@"data"][@"sysTime"]);
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
    DiscoverRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DiscoverRecommendTableViewCell indentify]];
    if (!cell) {
        cell = [DiscoverRecommendTableViewCell newCell];
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

- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addBtn:(UIButton *)sender {
    DiscoverQrCodeViewController *qrVC = [[DiscoverQrCodeViewController alloc]init];
    qrVC.goodsId = self.goodsId;
    [self.navigationController pushViewController:qrVC animated:YES];
}
@end
