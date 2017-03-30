//
//  BankCardDetailView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/30.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BankCardDetailView.h"
#import "BankCardInfoModel.h"

@implementation BankCardDetailView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"BankCardDetailView" owner:nil options:nil][0];
        self.cardNumLabel.adjustsFontSizeToFitWidth =self.nameLabel.adjustsFontSizeToFitWidth= self.bankMarkLabel.adjustsFontSizeToFitWidth= self.bankNameLabel.adjustsFontSizeToFitWidth= YES;
    }
    return self;
}

- (void)setDataModel:(BankCardInfoModel *)dataModel
{
    _dataModel = dataModel;
    self.cardNumLabel.text = _dataModel.bankAccount;
    self.nameLabel.text = _dataModel.realName;
    self.bankNameLabel.text  = _dataModel.bankName;
}

@end
