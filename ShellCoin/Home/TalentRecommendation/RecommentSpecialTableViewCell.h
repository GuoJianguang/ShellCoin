//
//  RecommentDefaltTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommentModel.h"

@interface RecommentSpecialTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title_label;

@property (weak, nonatomic) IBOutlet UILabel *detail_label;

@property (weak, nonatomic) IBOutlet UICollectionView *detailCollectionView;

@property (nonatomic, strong)RecommentModel *dataModel;

@end
