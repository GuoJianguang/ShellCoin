//
//  BanCardDetailTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BanCardDetailTableViewCell.h"
#import "BankCardInfoModel.h"
#import "ManagerBankCardViewController.h"

@implementation BanCardDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.alerLabel1.textColor =  self.alerLabel2.textColor =self.alerLabel2.textColor = self.alerLabel3.textColor =self.alerLabel4.textColor =self.alerLabel5.textColor =self.alerLabel6.textColor = MacoDetailColor;;
    self.realNameLabel.textColor = self.cardNumLabel.textColor = self.addresslabel.textColor = self.bankLabel.textColor = self.wangdianLabel.textColor = self.kaihuhangLabel.textColor = self.hanghaoLabel.textColor = MacoTitleColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(BankCardInfoModel *)dataModel
{
    _dataModel = dataModel;
    self.realNameLabel.text = _dataModel.realName;
    self.cardNumLabel.text = [self normalNumToBankNum1:_dataModel.bankAccount];
    self.addresslabel.text = _dataModel.bankAccountPro;
    self.bankLabel.text = _dataModel.bankName;
    self.kaihuhangLabel.text = _dataModel.bankBranch;
    if ([self.kaihuhangLabel.text isEqualToString:@""]) {
        self.kaihuhangLabel.text = @"暂无";
    }
    self.hanghaoLabel.text = _dataModel.bankBranchNo;
    if ([self.hanghaoLabel.text isEqualToString:@""]) {
        self.hanghaoLabel.text = @"暂无";
    }
    self.wangdianLabel.text = _dataModel.bankPoint;
    if ([self.wangdianLabel.text isEqualToString:@""]) {
        self.wangdianLabel.text = @"暂无";
    }
}

#pragma mark - 删除该银行卡
- (IBAction)deletBtn:(UIButton *)sender {
    
    NSDictionary *parms = @{@"id":self.dataModel.bankinfoid,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/withdraw/bindBankcard/delete" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
//            ((ManagerBankCardViewController *)self.viewController).currentPage = 0;
            [((ManagerBankCardViewController *)self.viewController) getmyBankCardRequest];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"删除失败，请稍后重试！" duration:2.0];
    }];
}

- (NSString *)normalNumToBankNum:(NSString *)num
{
    if (num.length < 7) {
        return num;
    }
    NSNumber *number = @([num longLongValue]);
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setGroupingSize:4];
    [formatter setGroupingSeparator:@" "];
    return [formatter stringFromNumber:number];
}

-(NSString *)normalNumToBankNum1:(NSString *)tmpStr
{
    if (tmpStr.length < 7) {
        return tmpStr;
    }
    NSInteger size = (tmpStr.length / 4);
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*4, (tmpStr.length % 4))]];
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tmpStr;
}

//-(NSString *)bankNumToNormalNum
//{
//    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
//}
@end
