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
#import "ShoopingCart+CoreDataProperties.h"
#import "CoreDataShoopingCarManagement.h"
#import "MallSureOrderViewController.h"

@interface ShoppingCarViewController ()<UITableViewDelegate,UITableViewDataSource,BasenavigationDelegate>

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"购物车";
    self.naviBar.delegate = self;
    self.totalPriceLabel.textColor = MacoColor;
    self.totalPriceLabel.adjustsFontSizeToFitWidth = YES;
    [self.tableView noDataSouce];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afterPayDeletOrder:) name:@"afterPayDeletOrder" object:nil];

}

- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"afterPayDeletOrder" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self checkShoppingCartFormCoredata];
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


#pragma mark - 查询数据
- (void)checkShoppingCartFormCoredata
{
    //查询数据
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShoopingCart" inManagedObjectContext:[CoreDataShoopingCarManagement shareManageMent].moc];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //谓词搜索
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"account=%@",[ShellCoinUserInfo shareUserInfos].userid];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    //排序方法（这里为按照年龄升序排列）
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[CoreDataShoopingCarManagement shareManageMent].moc executeFetchRequest:fetchRequest error:&error];
    [self.dataSouceArray removeAllObjects];
    if (fetchedObjects) {
        for (ShoopingCart *dic in fetchedObjects) {
            [self.dataSouceArray addObject:[ShoppingCarModel modelWithCoreData:dic]];
        }
    }
    [self.tableView judgeIsHaveDataSouce:self.dataSouceArray];
    [self calculateTheTotalAmount];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 全选
- (IBAction)selectBtn:(UIButton *)sender {
    sender.selected  = !sender.selected;
    
    for (ShoppingCarModel *model in self.dataSouceArray) {
        model.isSelect = sender.selected;
    }

    [self calculateTheTotalAmount];
    [self.tableView reloadData];
    
}

#pragma mark - 计算总金额
- (void)calculateTheTotalAmount
{
    double money =0;
    BOOL isallSelcet = YES;
    for (ShoppingCarModel *model in self.dataSouceArray) {
        if (model.isSelect) {
            money = money + (model.goodsPrice *model.goodsNum) + model.goodsFreight;
        }else{
            isallSelcet = NO;
        }
    }
    
    self.selectBtn.selected = isallSelcet;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计:¥%.2f",money];
    
}
#pragma mark - 去结算
- (IBAction)sureBtn:(UIButton *)sender {
    
    NSMutableArray *array = [NSMutableArray array];
    BOOL ishaveGoods = NO;
    for (ShoppingCarModel *model in self.dataSouceArray) {
        if (model.isSelect) {
            NSDictionary *dic = @{@"goodsId":model.goodsId,
                                  @"priceId":model.priceId,
                                  @"quantity":@(model.goodsNum)};
            [array addObject:dic];
            ishaveGoods = YES;
        }
    }
    if (!ishaveGoods) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您还没有选择相关商品" duration:2.];
        return;
    }
    //记录结算的订单
    
    NSMutableArray *yetSelectarray = [NSMutableArray array];
    for (ShoppingCarModel *model in self.dataSouceArray) {
        if (model.isSelect) {
            NSDictionary *dic = @{@"goodsId":model.goodsId,
                                  @"priceId":model.priceId,
                                  @"quantity":@(model.goodsNum),
                                  @"seqsec":model.goodsSpec};
            [yetSelectarray addObject:dic];
        }
    }
    
    MallSureOrderViewController *sureVC = [[MallSureOrderViewController alloc]init];
    sureVC.orderArry = [NSMutableArray arrayWithArray:array];
    sureVC.isFormShoppingCart = YES;
    sureVC.yetSelectarray =[NSMutableArray arrayWithArray:yetSelectarray];
    [self.navigationController pushViewController:sureVC animated:YES];
}

#pragma mark - 购买之后删除购物车订单

- (void)afterPayDeletOrder:(NSNotification *)fication
{
    
    NSMutableArray *array = fication.object;
    //查询是否已经有该规格商品
    for (NSDictionary *dic in array) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShoopingCart" inManagedObjectContext:[CoreDataShoopingCarManagement shareManageMent].moc];
        [fetchRequest setEntity:entity];
        // Specify criteria for filtering which objects to fetch
        //谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"goodsId=%@&&goodsSpec=%@&&account=%@",dic[@"goodsId"],dic[@"seqsec"],[ShellCoinUserInfo shareUserInfos].userid];
        [fetchRequest setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [[CoreDataShoopingCarManagement shareManageMent].moc executeFetchRequest:fetchRequest error:&error];
        for (ShoopingCart *cart in fetchedObjects) {
            [[CoreDataShoopingCarManagement shareManageMent].moc deleteObject:cart];
        }
        [CoreDataShoopingCarManagement shareManageMent].isAddShopCart = NO;
        [[CoreDataShoopingCarManagement shareManageMent] saveContext];
        
    }

}

@end
