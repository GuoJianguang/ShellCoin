//
//  LogisticsViewController.m
//  tiantianxin
//
//  Created by ttx on 16/4/18.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "LogisticsViewController.h"
#import "LogisticsDetailTableViewCell.h"
#import "LogisticsCompanyTableViewCell.h"
#import "BuyRecodTableViewCell.h"
//#import "CommonFunc.h"

@interface LogisticsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@end

@implementation LogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"物流信息";
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView noDataSouce];
    [self getLoginsticsRequest:self.dataModel];
}

- (void)getLoginsticsRequest:(BuyRecodeModel *)model
{
    NSDictionary *parms = @{@"orderId":model.buyId,
                             @"logisticsNumber":model.logisticsNumber,
                             @"logisticsCompanyCode":model.logisticsCompanyCode,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [HttpClient POST:@"shop/order/logistics/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD  dismiss];
        if (IsRequestTrue) {
            if ([NullToNumber(jsonObject[@"data"][@"Success"]) isEqualToString:@"1"]) {
                [self.dataSouceArray removeAllObjects];
                NSArray *array = jsonObject[@"data"][@"Traces"];
                for (NSDictionary *dic in array) {
                    [self.dataSouceArray addObject:[LogisticsModel modelWithDic:dic]];
                }
                [self.tableView judgeLogisticsIsHaveDataSouce:self.dataSouceArray];
                [self.tableView reloadData];
            }
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD  dismiss];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        LogisticsCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LogisticsCompanyTableViewCell indentify]];
        if (!cell) {
            cell = [LogisticsCompanyTableViewCell newCell];
        }
        cell.dataModel = self.dataModel;
        return cell;
    }else{
        LogisticsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LogisticsDetailTableViewCell indentify]];
        if (!cell) {
            cell = [LogisticsDetailTableViewCell newCell];
        }
        if (indexPath.row == 1) {
//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, TWitdh-30, 100) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//            maskLayer.frame = cell.itemView.bounds;
//            maskLayer.path = maskPath.CGPath;
//            cell.itemView.layer.mask = maskLayer;
            cell.upView.hidden = YES;
            cell.firstLineView.hidden = NO;
            cell.isLastItem = YES;
        }else{
            cell.firstLineView.hidden = YES;
            cell.isLastItem = NO;

        }
        if (indexPath.row == self.dataSouceArray.count) {
//            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, TWitdh-30, 100) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//            maskLayer.frame = cell.itemView.bounds;
//            maskLayer.path = maskPath.CGPath;
//            cell.itemView.layer.mask = maskLayer;
            cell.downView.hidden = YES;
            cell.lineView.hidden = YES;
        }
        
        cell.dataModel = self.dataSouceArray[self.dataSouceArray.count -indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90;
    }else{
        return 90;
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD  dismiss];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
