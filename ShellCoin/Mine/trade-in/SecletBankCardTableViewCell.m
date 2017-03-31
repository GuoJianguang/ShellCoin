//
//  SecletBankCardTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SecletBankCardTableViewCell.h"
#import "BankCardInfoModel.h"

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

- (void)setDataModel:(BankCardInfoModel *)dataModel
{
    _dataModel = dataModel;
    NSString *count = [_dataModel.bankAccount substringFromIndex:_dataModel.bankAccount.length-4];
    self.bankCardLabel.text = [NSString stringWithFormat:@"%@ (%@)",_dataModel.bankName,count];
    self.selcetmarkIamge.hidden = !_dataModel.isSeclet;
    [self.banklogImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.bankImg] placeholderImage:[UIImage imageNamed:@"icon_yinlian"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
