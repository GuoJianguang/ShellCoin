//
//  HomeRecommendedTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeRecommendedTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *highqualityCollectionVIew;

@property (weak, nonatomic) IBOutlet UICollectionView *foryouCollectionView;

@end
