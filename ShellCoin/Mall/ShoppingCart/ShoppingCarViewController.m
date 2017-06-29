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

@interface ShoppingCarViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"购物车";
    self.totalPriceLabel.textColor = MacoColor;
    [self.tableView noDataSouce];
    
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShoopingCart" inManagedObjectContext:[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //谓词搜索
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"goodsId=11"];
//    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    //排序方法（这里为按照年龄升序排列）
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"age" ascending:YES];
//    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
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
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",money];
    
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
    MallSureOrderViewController *sureVC = [[MallSureOrderViewController alloc]init];
    sureVC.orderArry = [NSMutableArray arrayWithArray:array];
    [self.navigationController pushViewController:sureVC animated:YES];
}
@end
