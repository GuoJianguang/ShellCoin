//
//  LoanOtherViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "LoanOtherViewController.h"
#import "LoanOtherTableViewCell.h"
#import "LoanTableViewCell.h"

@interface LoanOtherViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@end

@implementation LoanOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"车房易购";
    __weak LoanOtherViewController *weak_self = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weak_self.page = 1;
        [weak_self getRequest:YES withType:self.loanType];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self getRequest:NO withType:self.loanType];
    }];
    [self.tableView noDataSouce];
    
    [self.tableView.mj_header beginRefreshing];

}



- (void)getRequest:(BOOL)isHeader withType:(Loan_type)type
{
    
    NSString *urlStr = [NSString string];
    if (type == Loan_type_audit) {
        urlStr = @"user/userLoan/authing/get";
    }else{
       urlStr =@"user/userLoan/fail/get";
    }
    NSDictionary *prams = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:urlStr parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                LoanAuditOrFailModel *model = [LoanAuditOrFailModel modelWithDic:dic];
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

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}
#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoanOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LoanOtherTableViewCell indentify]];
    if (!cell) {
        cell = [LoanOtherTableViewCell newCell];
    }
    if (self.loanType == Loan_type_audit) {
        if (indexPath.row%5 == 0) {
            cell.bgImageView.image = [UIImage imageNamed:@"bg_loan_orange"];
        }
        if (indexPath.row%5 == 1) {
            cell.bgImageView.image = [UIImage imageNamed:@"bg_loan_purple"];
            
        }
        if (indexPath.row%5 == 2) {
            cell.bgImageView.image = [UIImage imageNamed:@"bg_loan_red"];
            
        }
        if (indexPath.row%5 == 3) {
            cell.bgImageView.image = [UIImage imageNamed:@"bg_loan_blue"];
            
        }
        if (indexPath.row%5 == 4) {
            cell.bgImageView.image = [UIImage imageNamed:@"bg_loan_green"];
        }
        cell.statusLabel.text = @"审核中";
        
    }else{
        cell.bgImageView.image = [UIImage imageNamed:@"bg_application_failed_list"];
        cell.statusLabel.text = @"申请失败";


    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.dataModel = self.dataSouceArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return TWitdh*(300/750.);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count ;
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
