//
//  ShoppingCarTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ShoppingCarTableViewCell.h"
#import "ShoppingCarViewController.h"
#import "CoreDataShoopingCarManagement.h"
#import "ShoppingCarViewController.h"

@implementation ShoppingCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.goodsImage.layer.masksToBounds = YES;
    self.goodsSpec.adjustsFontSizeToFitWidth = self.goodsDetail.adjustsFontSizeToFitWidth =self.price.adjustsFontSizeToFitWidth= YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)subBtn:(UIButton *)sender {
    int count = [self.goodsNum.text intValue];
    if (count == 1) {
        return;
    }
    
    self.goodsNum.text = [NSString stringWithFormat:@"%d",--count ];
    self.price.text = [NSString stringWithFormat:@"¥%.2f",(_dataModel.goodsPrice *count) + _dataModel.goodsFreight];
    
    
    
    for (ShoppingCarModel *model in ((ShoppingCarViewController *)self.viewController).dataSouceArray) {
        if ([model.goodsId isEqualToString:self.dataModel.goodsId] && [model.goodsSpec isEqualToString:self.dataModel.goodsSpec]) {
            model.goodsNum = count;
            [(ShoppingCarViewController *)self.viewController calculateTheTotalAmount];
        }
    }
    
    //查询是否已经有该规格商品
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShoopingCart" inManagedObjectContext:[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //谓词搜索
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"goodsId=%@&&goodsSpec=%@&&account=%@",_dataModel.goodsId,_dataModel.goodsSpec,[ShellCoinUserInfo shareUserInfos].userid];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects &&fetchedObjects.count > 0) {
        ((ShoopingCart *)fetchedObjects[0]).goodsNum = count;
        [CoreDataShoopingCarManagement shareManageMent].isAddShopCart = NO;
        [[CoreDataShoopingCarManagement shareManageMent] saveContext];
        return ;
    }


}
- (IBAction)addBtn:(UIButton *)sender {
    int count = [self.goodsNum.text intValue];

    self.goodsNum.text = [NSString stringWithFormat:@"%d",++count];
    
    self.price.text = [NSString stringWithFormat:@"¥%.2f",(_dataModel.goodsPrice *count) + _dataModel.goodsFreight];
    
    for (ShoppingCarModel *model in ((ShoppingCarViewController *)self.viewController).dataSouceArray) {
        if ([model.goodsId isEqualToString:self.dataModel.goodsId] && [model.goodsSpec isEqualToString:self.dataModel.goodsSpec]) {
            model.goodsNum = count;
            [(ShoppingCarViewController *)self.viewController calculateTheTotalAmount];
        }
    }

    
    //查询是否已经有该规格商品
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShoopingCart" inManagedObjectContext:[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //谓词搜索
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"goodsId=%@&&goodsSpec=%@&&account=%@",_dataModel.goodsId,_dataModel.goodsSpec,[ShellCoinUserInfo shareUserInfos].userid];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects &&fetchedObjects.count > 0) {
        ((ShoopingCart *)fetchedObjects[0]).goodsNum = count;
        [CoreDataShoopingCarManagement shareManageMent].isAddShopCart = NO;
        [[CoreDataShoopingCarManagement shareManageMent] saveContext];
        return ;
    }



}
- (IBAction)deletBtn:(UIButton *)sender {
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定删除此商品,删除后无法恢复" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //查询是否已经有该规格商品
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ShoopingCart" inManagedObjectContext:[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext];
        [fetchRequest setEntity:entity];
        // Specify criteria for filtering which objects to fetch
        //谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"goodsId=%@&&goodsSpec=%@&&account=%@",_dataModel.goodsId,_dataModel.goodsSpec,[ShellCoinUserInfo shareUserInfos].userid];
        [fetchRequest setPredicate:predicate];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
        for (ShoopingCart *cart in fetchedObjects) {
            [[CoreDataShoopingCarManagement shareManageMent].persistentContainer.viewContext deleteObject:cart];
        }
        [CoreDataShoopingCarManagement shareManageMent].isAddShopCart = NO;
        [[CoreDataShoopingCarManagement shareManageMent] saveContext];

        [((ShoppingCarViewController *)self.viewController).dataSouceArray removeObjectAtIndex:self.dataModel.index];
        [(ShoppingCarViewController *)self.viewController calculateTheTotalAmount];
        [((ShoppingCarViewController *)self.viewController).tableView judgeIsHaveDataSouce:((ShoppingCarViewController *)self.viewController).dataSouceArray];

        [((ShoppingCarViewController *)self.viewController).tableView reloadData];

    }];
    [alertcontroller addAction:cancelAction];
    [alertcontroller addAction:otherAction];
    [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
}

#pragma mark - 选中
- (IBAction)selectBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.backImageView.image = [UIImage imageNamed:@"bj_shangpinxuanzhong"];
        ((ShoppingCarModel *)((ShoppingCarViewController *)self.viewController).dataSouceArray[_dataModel.index]).isSelect = YES;
    }else{
        self.backImageView.image = [UIImage imageNamed:@"bj_shangpin"];
        ((ShoppingCarModel *)((ShoppingCarViewController *)self.viewController).dataSouceArray[_dataModel.index]).isSelect = NO;
    }
    [(ShoppingCarViewController *)self.viewController calculateTheTotalAmount];
}

- (void)setDataModel:(ShoppingCarModel *)dataModel
{
    _dataModel = dataModel;
    if (_dataModel.isSelect) {
        self.backImageView.image = [UIImage imageNamed:@"bj_shangpinxuanzhong"];
    }else{
        self.backImageView.image = [UIImage imageNamed:@"bj_shangpin"];
    }
    self.goodsName.text = _dataModel.goodsName;
    self.goodsNum.text = [NSString stringWithFormat:@"%ld",_dataModel.goodsNum];
    
    if (![_dataModel.goodsSpec isEqualToString:@""]) {
        self.goodsSpec.text =[NSString stringWithFormat:@"%@/邮费:%.2f元",_dataModel.goodsSpec,_dataModel.goodsFreight];
    }else{
        self.goodsSpec.text =[NSString stringWithFormat:@"邮费:%.2f元",_dataModel.goodsFreight];
    }
    self.goodsDetail.text = [NSString stringWithFormat:@"现金:%.2f元／贝壳币:%.2f个/购物券:%.2f元",_dataModel.cash, _dataModel.shellCoin,_dataModel.coupons];
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.pic] placeholderImage:LoadingErrorDefaultImageSquare];
    
    self.price.text = [NSString stringWithFormat:@"¥%.2f",(_dataModel.goodsPrice *_dataModel.goodsNum) + _dataModel.goodsFreight];
    
    self.selcetBtn.selected = _dataModel.isSelect;
}

@end
