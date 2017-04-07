//
//  RecommentDefaltTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RecommentSpecialTableViewCell.h"
#import "RecommentSpecilCollectionViewCell.h"


@interface RecommentSpecialTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation RecommentSpecialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detailCollectionView.delegate = self;
    self.detailCollectionView.dataSource = self;
    self.title_label.textColor = MacoTitleColor;
    self.detail_label.textColor = MacoDetailColor;
    
}

- (void)setDataModel:(RecommentModel *)dataModel
{
    _dataModel = dataModel;
    self.title_label.text = _dataModel.name;
    self.detail_label.text = _dataModel.name;
    [self.detailCollectionView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataModel.picArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier =[RecommentSpecilCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [RecommentSpecilCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    RecommentSpecilCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.pic = self.dataModel.picArray[indexPath.item];
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
    //        return CGSizeMake(TWitdh/self.sortDataSouceA rray.count, 50);
    //    }
    return CGSizeMake((TWitdh- 16 - 12)/3., TWitdh * (130/320.) - 8- TWitdh * (50/304.));
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
