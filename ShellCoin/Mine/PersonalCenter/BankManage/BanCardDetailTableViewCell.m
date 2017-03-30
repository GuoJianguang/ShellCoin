//
//  BanCardDetailTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BanCardDetailTableViewCell.h"
#import "BankCardInfoModel.h"
@implementation BanCardDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(BankCardInfoModel *)dataModel
{
    _dataModel = dataModel;
    self.realNameLabel.text = _dataModel.realName;
    self.cardNumLabel.text = _dataModel.bankAccount;
    self.addresslabel.text = _dataModel.bankAccountPro;
    self.bankLabel.text = _dataModel.bankName;
    self.kaihuhangLabel.text = _dataModel.bankBranch;
    self.hanghaoLabel.text = _dataModel.bankBranchNo;
    self.wangdianLabel.text = _dataModel.bankPoint;
}

#pragma mark - 删除该银行卡
- (IBAction)deletBtn:(UIButton *)sender {
    
}
@end
