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
@end

@interface WithDrawalRecodTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic, strong)WithDrawalRecodModel *dataModel;

@end
