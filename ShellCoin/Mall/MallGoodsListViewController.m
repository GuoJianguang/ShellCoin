//
//  MallGoodsListViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallGoodsListViewController.h"
#import "MallGoodsCollectionViewCell.h"
#import "MallSortView.h"
#import "GoodsDetailViewController.h"
#import "MallSearchViewController.h"

@interface MallGoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,BasenavigationDelegate>
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (nonatomic, strong)MallSearchViewController *searchVC;

@property (nonatomic,strong)MallSortView *sortView;
@end

@implementation MallGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"商品列表";
    self.naviBar.delegate = self;
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_search"];
    self.sortView.hidden = YES;

}
#pragma mark -  搜索按钮
- (void)detailBtnClick
{
    //    [self.navigationController pushViewController:self.searchVC animated:YES];
    [self.navigationController.view addSubview:self.searchVC.view];
}
 
- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (MallSearchViewController *)searchVC
{
    if (!_searchVC) {
        _searchVC = [[MallSearchViewController alloc]init];
        _searchVC.view.frame = CGRectMake(0, 0, TWitdh, THeight);
    }
    return _searchVC;
}

- (MallSortView *)sortView
{
    if (!_sortView) {
        _sortView = [[MallSortView alloc]init];
        _sortView.frame = CGRectMake(0, 64 + TWitdh *(79/320.), TWitdh, TWitdh *(230/750.));
    }
    return _sortView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)sort1Btn:(UIButton *)sender {
}
- (IBAction)sort2Btn:(UIButton *)sender {
}

- (IBAction)sort3Btn:(UIButton *)sender {
}
- (IBAction)moreSortBtn:(UIButton *)sender {
    [self.view addSubview:self.sortView];
    self.sortView.hidden = !self.sortView.hidden;
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
    [self.navigationController pushViewController:goodsDetailVC animated:YES];
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


@end
