//
//  IntergralRecordTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillIntegaralModel.h"

@interface IntergralRecordTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong)BillIntegaralModel *integaralModel;

@property (nonatomic, strong)IntegralShellCoinModel *shellCoinModel;

@end
