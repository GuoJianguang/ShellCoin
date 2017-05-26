//
//  BillTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "WithDrawalRecodTableViewCell.h"

@implementation WithDrawalRecodModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    WithDrawalRecodModel *model = [[WithDrawalRecodModel alloc]init];
    model.time  = NullToSpace(dic[@"successTime"]);
    model.amount = NullToNumber(dic[@"withdrawAmout"]);
    model.state = NullToNumber(dic[@"state"]);
    model.withDrawalId = NullToNumber(dic[@"withDrawalId"]);
    return model;
}

@end

@implementation WithDrawalRecodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.textColor = MacoDetailColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setDataModel:(WithDrawalRecodModel *)dataModel
{
    _dataModel = dataModel;
    self.timeLabel.text = _dataModel.time;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[_dataModel.amount doubleValue]];
    switch ([_dataModel.state integerValue]) {
        case 0:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.statusLabel.textColor = self.moneyLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
            self.statusLabel.text = @"提现中";
        }
            break;
        case 1:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.statusLabel.textColor = self.moneyLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
            self.statusLabel.text = @"提现中";
        }
            break;
        case 2:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.statusLabel.textColor = self.moneyLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
            self.statusLabel.text = @"提现中";
        }
            break;
        case 3:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_red"];
            self.statusLabel.textColor = self.moneyLabel.textColor = MacoColor;
            self.statusLabel.text = @"提现成功";
        }
            break;
        case 4:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_green"];
            self.statusLabel.textColor = self.moneyLabel.textColor = [UIColor colorFromHexString:@"#45de8e"];
            self.statusLabel.text = @"提现失败";
        }
            break;
            
        default:
            break;
    }
}
@end
