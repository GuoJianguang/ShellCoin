//
//  RecommentEarningsViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RecommentEarningsViewController.h"
#import "RecommendTableViewCell.h"
#import "MyQrCodeViewController.h"
#import "WithdrawalViewController.h"


@interface RecommentEarningsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (nonatomic, assign)NSInteger page;//页数


@end

@implementation RecommentEarningsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
    self.talbeView.backgroundColor = [UIColor clearColor];
    __weak RecommentEarningsViewController *weak_self = self;
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
    [HttpClient POST:@"user/recommendProfit/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (self.page == 1) {
                self.totalMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",NullToNumber(jsonObject[@"data"][@"totalqueryAmount"])];
            }
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                RecommendModel *model = [RecommendModel modelWithDic:dic];
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

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return self.dataSouceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RecommendTableViewCell indentify]];
    if (!cell) {
        cell = [RecommendTableViewCell newCell];
    }
    if (self.dataSouceArray.count > 0) {
        cell.dataModel = self.dataSouceArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh*(165/750.);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 推广码
- (IBAction)qrcodeBtn:(id)sender {
    MyQrCodeViewController *myQrVC = [[MyQrCodeViewController alloc]init];
    [self.navigationController pushViewController:myQrVC animated:YES];
}

#pragma mark - 抵换
- (IBAction)withdrawalBtn:(UIButton *)sender {
    WithdrawalViewController *withDrawVC = [[WithdrawalViewController alloc]init];
    [self.navigationController pushViewController:withDrawVC animated:YES];
}
@end
