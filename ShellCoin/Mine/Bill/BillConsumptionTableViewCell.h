//
//  BillConsumptionTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BillDataModel;

@interface BillConsumptionTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIImageView *sortImageview;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong)BillDataModel *xiaofeijiluModel;

@property (weak, nonatomic) IBOutlet UILabel *buyCardLabel;


@end
