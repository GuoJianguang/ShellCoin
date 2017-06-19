//
//  ShoppingCarViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "ShoppingCarTableViewCell.h"
#import "ShoppingCarModel.h"
@interface ShoppingCarViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"购物车";
    
    NSDictionary *dic1 = @{@"pic":@"wwwdkadjkdjak",
                           @"goodsName":@"蛋黄派",
                           @"goodsSpec":@"规格：65个／颜色：哈啊／邮费：包邮",
                           @"goodsDetail":@"现金：300元／贝壳币：67个／优惠券：7张",
                           @"goodsNum":@"6"};
    NSDictionary *dic2 = @{@"pic":@"wwwdkadjkdjak",
                           @"goodsName":@"安踏",
                           @"goodsSpec":@"规格：65个／颜色：哈啊／邮费：包邮",
                           @"goodsDetail":@"现金：300元／贝壳币：67个／优惠券：7张",
                           @"goodsNum":@"1"};
    NSDictionary *dic3 = @{@"pic":@"wwwdkadjkdjak",
                           @"goodsName":@"三叶草T恤",
                           @"goodsSpec":@"规格：65个／颜色：哈啊／邮费：包邮",
                           @"goodsDetail":@"现金：300元／贝壳币：67个／优惠券：7张",
                           @"goodsNum":@"1"};
    NSDictionary *dic4 = @{@"pic":@"wwwdkadjkdjak",
                           @"goodsName":@"耐克666",
                           @"goodsSpec":@"规格：65个／颜色：哈啊／邮费：包邮",
                           @"goodsDetail":@"现金：300元／贝壳币：67个／优惠券：7张",
                           @"goodsNum":@"2"};
    NSDictionary *dic5 = @{@"pic":@"wwwdkadjkdjak",
                           @"goodsName":@"蛋黄派",
                           @"goodsSpec":@"规格：65个／颜色：哈啊／邮费：包邮",
                           @"goodsDetail":@"现金：300元／贝壳币：67个／优惠券：7张",
                           @"goodsNum":@"6"};
    NSDictionary *dic6 = @{@"pic":@"wwwdkadjkdjak",
                           @"goodsName":@"高压锅",
                           @"goodsSpec":@"规格：65个／颜色：哈啊／邮费：包邮",
                           @"goodsDetail":@"现金：300元／贝壳币：67个／优惠券：7张",
                           @"goodsNum":@"1"};
    [self.dataSouceArray addObject:[ShoppingCarModel modelWithDic:dic1]];
    [self.dataSouceArray addObject:[ShoppingCarModel modelWithDic:dic2]];
    [self.dataSouceArray addObject:[ShoppingCarModel modelWithDic:dic3]];
    [self.dataSouceArray addObject:[ShoppingCarModel modelWithDic:dic4]];
    [self.dataSouceArray addObject:[ShoppingCarModel modelWithDic:dic5]];
    [self.dataSouceArray addObject:[ShoppingCarModel modelWithDic:dic6]];
    [self.tableView reloadData];
}


#pragma mark - UITableView


- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ShoppingCarTableViewCell indentify]];
    if (!cell) {
        cell = [ShoppingCarTableViewCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];
    cell.dataModel.index = indexPath.row;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return TWitdh*(34/75.);
        

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 全选
- (IBAction)selectBtn:(UIButton *)sender {
    
    
}
#pragma mark - 去结算
- (IBAction)sureBtn:(UIButton *)sender {
    
}
@end
