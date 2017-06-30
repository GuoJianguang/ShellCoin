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

//1:价格降序 2:价格升序 3:销量降序 4:时间降序 5时间升序
@property (nonatomic, assign)NSInteger flag;
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
    [self.collectionView.mj_header beginRefreshing];
    self.flag = 0;
    self.priceBtn.selected = YES;
    self.priceImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.priceBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.timeImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.salesBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

#pragma mark - 数据请求
- (void)getRequest:(BOOL )isHeader
{
    NSDictionary *parms = @{@"pageNo":@(self.page),
                            @"pageSize":MacoRequestPageCount,
                            @"mchCode":NullToSpace(self.mchCode),
                            @"flag":@(self.flag)};
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"shop/merchantGoods/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
                [self.collectionView.mj_header endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
            NSArray *array = jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                MallGoodsModel *model = [MallGoodsModel modelWithDic:dic];
                [self.dataSouceArray addObject:model];
            }
            [self.collectionView reloadData];
            [self.collectionView judgeIsHaveDataSouce:self.dataSouceArray];
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [self.collectionView showNoDataSouceNoNetworkConnection];
        if (isHeader) {
            [self.collectionView.mj_header endRefreshing];
        }else{
            [self.collectionView.mj_footer endRefreshing];
        }
        
    }];

}

#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
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
    cell.dataModel = self.dataSouceArray[indexPath.item];
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailViewController *goodsDetailVC = [[GoodsDetailViewController alloc]init];
    goodsDetailVC.htmlUrl = ((MallGoodsModel *)self.dataSouceArray[indexPath.item]).detailUrl;
    goodsDetailVC.goodsId = ((MallGoodsModel *)self.dataSouceArray[indexPath.item]).goodsId;
    goodsDetailVC.isFormStore = YES;
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
    self.timeBtn.selected = YES;
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.flag = 2;
        self.priceImage.image = [UIImage imageNamed:@"btn_shangxueze"];
        
    }else{
        self.flag = 1;
        self.priceImage.image = [UIImage imageNamed:@"btn_xiaxuanzhong"];
        
    }
    [self.priceBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    self.timeImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.salesBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.collectionView.mj_header beginRefreshing];
    
}
- (IBAction)salesBtn:(UIButton *)sender {
    
    self.timeBtn.selected = YES;
    self.priceBtn.selected = YES;
    
    self.priceImage.image = [UIImage imageNamed:@"btn_paixu"];
    self.timeImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.priceBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.salesBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.flag = 3;
    [self.collectionView.mj_header beginRefreshing];
}
- (IBAction)timeBtn:(UIButton *)sender {
    self.priceBtn.selected = YES;
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.flag = 5;
        self.timeImage.image = [UIImage imageNamed:@"btn_shangxueze"];
        
    }else{
        self.flag = 4;
        self.timeImage.image = [UIImage imageNamed:@"btn_xiaxuanzhong"];
        
    }
    
    self.priceImage.image = [UIImage imageNamed:@"btn_paixu"];
    [self.priceBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.salesBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    [self.collectionView.mj_header beginRefreshing];
    
}

@end
