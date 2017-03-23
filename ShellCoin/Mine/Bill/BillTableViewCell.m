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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setDihuanModel:(BillDihuanModel *)dihuanModel
{
    _dihuanModel = dihuanModel;
    NSString *markStr = [NSString string];
    switch ([_dihuanModel.state integerValue]) {
        case 0:
            markStr = @"待审核";
            break;
        case 1:
            markStr = @"抵换中";
            break;
        case 2:
            markStr = @"抵换成功";
            break;
        case 3:
            markStr = @"抵换失败";
            break;
        default:
            break;
    }
    
    self.markLabel.text = markStr;
    self.timeLabel.text = _dihuanModel.successTime;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",_dihuanModel.withdrawAmout];
}


- (void)setTixianModel:(BillDihuanModel *)tixianModel
{
    _tixianModel = tixianModel;
    NSString *markStr = [NSString string];
    switch ([_tixianModel.state integerValue]) {
        case 0:
            markStr = @"待审核";
            break;
        case 1:
            markStr = @"提现中";
            break;
        case 2:
            markStr = @"提现成功";
            break;
        case 3:
            markStr = @"提现失败";
            break;
        default:
            break;
    }
    
    self.markLabel.text = markStr;
    self.timeLabel.text = _tixianModel.successTime;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",_tixianModel.withdrawAmout];
}
@end
