//
//  MallSortCollectionViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeIndustryTableViewCell.h"


@interface MallSortCollectionViewCell : BaseCollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *itemBtn;

@property (nonatomic,strong)NewHomeActivityModel *dataModel;

@end
