//
//  MyorderView.m
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MyorderView.h"
#import "OrderTableViewCell.h"
#import "OrderModel.h"
#import "OrderDetailViewController.h"
#import "AfterSalesDetailViewController.h"
#import "MallSureOrderViewController.h"

@interface MyorderView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@end

@implementation MyorderView

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

- (void)setOrderType:(Myorder_type)orderType
{
    _orderType = orderType;
    [self reload];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"MyorderView" owner:nil options:nil][0];
        self.tableView.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        __weak MyorderView *weak_self = self;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page = 1;
            [weak_self getmyOrderRequest:YES];
        }];
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getmyOrderRequest:NO];
        }];
        [self.tableView noDataSouce];
        
    }
    return self;
}

- (void)getmyOrderRequest:(BOOL)isHeader
{
    NSDictionary *prams = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"flag":@(self.orderType)};
    [HttpClient POST:@"shop/order/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                OrderModel *model = [OrderModel modelWithDic:dic];
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
    if (TWitdh == 320) {
        return TWitdh*(410/750.);

    }
    return TWitdh*(360/750.);
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OrderTableViewCell indentify]];
    if (!cell) {
        cell = [OrderTableViewCell newCell];
    }
    cell.orderType = self.orderType;
    cell.dataModel = self.dataSouceArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (self.orderType) {
        case Myorder_type_compelte:
        {
            OrderModel *model = self.dataSouceArray[indexPath.row];
            switch ([model.state integerValue]) {
                case 5://已退款
                {
                    AfterSalesDetailViewController *afterDetailVC =[[AfterSalesDetailViewController alloc]init];
                    afterDetailVC.dataModel = self.dataSouceArray[indexPath.row];
                    [self.viewController.navigationController pushViewController:afterDetailVC animated:YES];
                    return;
                }
                    break;
                case 3://已完成
                {
                    OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc]init];
                    orderDetailVC.orderType = self.orderType;
                    orderDetailVC.orderModel = self.dataSouceArray[indexPath.row];
                    [self.viewController.navigationController pushViewController:orderDetailVC animated:YES];
                    return;
                }
                    break;
                    
                default:
                    break;
            }

        }
            break;
            
        case Myorder_type_waitPay:
        {
            OrderModel *model = self.dataSouceArray[indexPath.row];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:model.goodsId forKey:@"goodsId"];
            [dic setObject:model.priceId forKey:@"priceId"];
            [dic setObject:model.quantity forKey:@"quantity"];
            NSDictionary *orderDic = @{@"data":@{@"orderId":model.orderId,
                                                 @"type":@"1"}};
            MallSureOrderViewController *sureVC = [[MallSureOrderViewController alloc]init];
            sureVC.orderArry = [NSMutableArray arrayWithArray:@[dic]];
            sureVC.waiPayOrderDic = orderDic;
            sureVC.isFormWaitPayOrder = YES;
            [self.viewController.navigationController pushViewController:sureVC animated:YES];
            return;
            
        }
            break;
        default:
            break;
    }
    
    OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc]init];
    orderDetailVC.orderType = self.orderType;
    orderDetailVC.orderModel = self.dataSouceArray[indexPath.row];
    [self.viewController.navigationController pushViewController:orderDetailVC animated:YES];
}

@end
