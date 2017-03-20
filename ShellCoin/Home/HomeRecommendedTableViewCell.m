//
//  HomeRecommendedTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HomeRecommendedTableViewCell.h"
#import "HighQualityCollectionViewCell.h"
#import "ForyouCollectionViewCell.h"

@interface HomeRecommendedTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation HomeRecommendedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.highqualityCollectionVIew.delegate = self;
    self.highqualityCollectionVIew.dataSource = self;
    self.foryouCollectionView.delegate = self;
    self.foryouCollectionView.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (self.foryouCollectionView == collectionView) {
        NSString *identifier =[ForyouCollectionViewCell indentify];
        static BOOL nibri =NO;
        if(!nibri)
        {
            UINib *nib = [ForyouCollectionViewCell newCell];
            [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
            nibri =YES;
        }
        ForyouCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        //    cell.dataModel = self.privteDataSouceArray[indexPath.item];
        nibri=NO;
        return cell;
    }
    NSString *identifier =[HighQualityCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [HighQualityCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    HighQualityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    cell.dataModel = self.privteDataSouceArray[indexPath.item];
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.sortDataSouceArray.count < 5) {
    //        return CGSizeMake(TWitdh/self.sortDataSouceArray.count, 50);
    //    }
    return CGSizeMake((TWitdh- 24 - 12)/3., TWitdh * (35/64.) -  TWitdh * (10/120.));
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 2, 0, 2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}


@end
