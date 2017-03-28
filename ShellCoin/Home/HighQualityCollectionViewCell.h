//
//  HighQualityCollectionViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeRecommendedTableViewCell.h"


@interface HighQualityCollectionViewCell : BaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *merchantImageView;
@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (nonatomic, strong)PopularMerModel *dataModel;
@end
