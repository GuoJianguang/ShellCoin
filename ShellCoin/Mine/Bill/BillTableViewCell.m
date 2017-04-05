//
//  BillTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillTableViewCell.h"

@implementation BillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.textColor = MacoDetailColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setTixianModel:(TixianModel *)tixianModel
{
    _tixianModel = tixianModel;
    NSString *markStr = [NSString string];
    switch ([_tixianModel.state integerValue]) {
        case 0:
        {
            markStr = @"待审核";
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.moneyLabel.textColor = self.markLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
        }
            break;
        case 1:
        {
            markStr = @"待审核";
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.moneyLabel.textColor = self.markLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
        }
            break;
        case 2:
        {
            markStr = @"待审核";
            self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
            self.moneyLabel.textColor = self.markLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
        }
            break;
        case 3:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_green"];
            self.moneyLabel.textColor = self.markLabel.textColor = MacoColor;
            markStr = @"抵换成功";
        }
            break;
        case 4:
        {
            self.markImageView.image = [UIImage imageNamed:@"pic_state_green"];
            self.moneyLabel.textColor = self.markLabel.textColor =  [UIColor colorFromHexString:@"#45de8e"];
            markStr = @"抵换失败";
        }
            break;
        default:
            break;
    }
    
    self.markLabel.text = markStr;
    self.timeLabel.text = _tixianModel.successTime;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",_tixianModel.withdrawAmout];
}
@end
