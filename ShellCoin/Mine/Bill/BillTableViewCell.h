//
//  BillTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillAmountDataModel.h"


@interface BillTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic, strong)BillDihuanModel *dihuanModel;


@property (nonatomic, strong)BillDihuanModel *tixianModel;

@end
