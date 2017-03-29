//
//  SecletBankCardTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SecletBankCardTableViewCell.h"


@implementation BankInfoModel
+ (id)modelWithDic:(NSDictionary *)dic
{
    BankInfoModel *model = [[BankInfoModel alloc]init];
    return model;
}

@end

@implementation SecletBankCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bankCardLabel.textColor = MacoTitleColor;
}

- (void)setDataModel:(BankInfoModel *)dataModel
{
    _dataModel = dataModel;
    self.bankCardLabel.text = [NSString stringWithFormat:@"%@ (%@)",_dataModel.bankName,_dataModel.bankCardNum];
    self.selcetmarkIamge.hidden = !_dataModel.isSeclet;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
