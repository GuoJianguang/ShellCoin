//
//  MallRootViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/16.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallRootViewController.h"
#import "MallRootBannerCollectionViewCell.h"
#import "MallGoodsCollectionViewCell.h"
#import "ShoppingCarViewController.h"

@interface MallRootViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong)NSMutableArray *dataSouceArray;

@end

@implementation MallRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviBar.hidden = YES;
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.borderWidth = 1;
    self.searchView.layer.borderColor  = [UIColor whiteColor].CGColor;
    [self.searchBtn setTitleColor:[UIColor colorFromHexString:@"#a0a0a0"] forState:UIControlStateNormal];
    [self.searchTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    
}


- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 搜索
- (IBAction)searchBtn:(UIButton *)sender {
}

#pragma mark - 购物车
- (IBAction)buyCarBtn:(UIButton *)sender {
    ShoppingCarViewController *shoppCarVC = [[ShoppingCarViewController alloc]init];
    [self.navigationController pushViewController:shoppCarVC animated:YES];
}


#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        NSString *identifier =[MallRootBannerCollectionViewCell indentify];
        static BOOL nibri =NO;
        if(!nibri)
        {
            UINib *nib = [MallRootBannerCollectionViewCell newCell];
            [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
            nibri =YES;
        }
        MallRootBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        nibri=NO;
        return cell;
    }
    
    
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
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        return CGSizeMake(TWitdh, TWitdh*(473/750.));
    }
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
