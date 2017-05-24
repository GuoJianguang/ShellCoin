//
//  DiscoverRootTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "DiscoverRootTableViewCell.h"
#import "DiscoverCollectionViewCell.h"
#import "DiscoverWithdrawalViewController.h"
#import "BuyRecodViewController.h"
#import "DiscovergoodsDetailViewController.h"
#import "MyRecommendViewController.h"

@interface DiscoverRootTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation DiscoverRootTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.notConsumersView.hidden = YES;
    
    self.checkRecommendView.hidden = self.withDrawlBtn.hidden = self.earnings.hidden = self.earningsLabel.hidden = !self.notConsumersView.hidden;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buyRecodeBtn:(UIButton *)sender {
    BuyRecodViewController *buyRecodVC = [[BuyRecodViewController alloc]init];
    [self.viewController.navigationController pushViewController:buyRecodVC animated:YES];
}

- (IBAction)helpBtn:(UIButton *)sender {
    
}
- (IBAction)notConsumerBtn:(UIButton *)sender {
    
}
- (IBAction)checkRecommendBtn:(UIButton *)sender {
    MyRecommendViewController *recommendVC = [[MyRecommendViewController alloc]init];
    [self.viewController.navigationController pushViewController:recommendVC animated:YES];
}
- (IBAction)withDrawlBtn:(UIButton *)sender {
    DiscoverWithdrawalViewController *withDrawalVC = [[DiscoverWithdrawalViewController alloc]init];
    [self.viewController.navigationController pushViewController:withDrawalVC animated:YES];
    
}
#pragma mark - collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier =[DiscoverCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [DiscoverCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    DiscoverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiscovergoodsDetailViewController *detailVC = [[DiscovergoodsDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.sortDataSouceArray.count < 5) {
    //        return CGSizeMake(TWitdh/self.sortDataSouceArray.count, 50);
    //    }
    return CGSizeMake(TWitdh, collectionView.bounds.size.height);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}




@end
