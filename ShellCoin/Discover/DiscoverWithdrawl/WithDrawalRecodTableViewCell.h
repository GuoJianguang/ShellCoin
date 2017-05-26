//
//  BillTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillDataModel.h"


@interface WithDrawalRecodModel : BaseModel

@property (nonatomic, copy)NSString *amount;
@property (nonatomic, copy)NSString *time;
/**
 * 提现状态 0待审核  1审核通过  2提现中   3提现成功  4提现失败
 */
@property (nonatomic, copy)NSString *state;
@property (nonatomic, copy)NSString *withDrawalId;

@end

@interface WithDrawalRecodTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong)WithDrawalRecodModel *dataModel;

@end
