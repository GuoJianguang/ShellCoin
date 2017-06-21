//
//  StoreAllGoodsView.m
//  ShellCoin
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "StoreAllGoodsView.h"
#import "MallGoodsCollectionViewCell.h"
#import "GoodsDetailViewController.h"
@interface StoreAllGoodsView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@property (nonatomic, assign)NSInteger page;
@end


@implementation StoreAllGoodsView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"StoreAllGoodsView" owner:nil options:nil][0];

        __weak StoreAllGoodsView *weak_self = self;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weak_self.page = 1;
            [weak_self getRequest:YES];
        }];
        self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weak_self getRequest:NO];
        }];
        [self.collectionView noDataSouce];
        [self reload];
        
    }
    return self;
}

- (void)reload
{
    [self.collectionView reloadData];
}

#pragma mark - 数据请求
- (void)getRequest:(BOOL )isHeader
{
    
}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
    return self.dataSouceArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier =[MallGoodsCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [MallGoodsCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    MallGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController *goodsDetailVC = [[GoodsDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:goodsDetailVC animated:YES];
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((TWitdh- 18)/2., (TWitdh- 18)/2. +  (TWitdh- 18)/2. * (130/355.));
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(6, 6, 6, 6);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3;
}


- (IBAction)priceBtn:(UIButton *)sender {
    self.priceImage.image = [UIImage imageNamed:@"btn_shangxueze"];
    self.timeImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.priceBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    [self.salesBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    
}
- (IBAction)salesBtn:(UIButton *)sender {
    
    self.priceImage.image = [UIImage imageNamed:@"btn_paixu"];
    self.timeImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.priceBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.salesBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
}
- (IBAction)timeBtn:(UIButton *)sender {
    self.priceImage.image = [UIImage imageNamed:@"btn_paixu"];
    self.timeImage.image = [UIImage imageNamed:@"btn_shangxueze"];
    [self.priceBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.salesBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
}

@end
