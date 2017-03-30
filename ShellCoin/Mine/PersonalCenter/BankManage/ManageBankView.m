//
//  ManageBankView.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ManageBankView.h"
#import "EditBankInfoViewController.h"

@implementation ManageBankView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.editBtn.layer.cornerRadius = 17;
    self.editBtn.layer.masksToBounds = YES;
    self.upView.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];
    self.pageContrlVIew.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"ManageBankView" owner:nil options:nil][0];
    }
    return self;
}

- (IBAction)editBtn:(id)sender {
    EditBankInfoViewController *editBankVC = [[EditBankInfoViewController alloc]init];
    editBankVC.bankModel = self.bankModel;
    editBankVC.isYetBingdingCard = YES;
    [self.viewController.navigationController pushViewController:editBankVC animated:YES];
}

- (void)setBankModel:(BankCardInfoModel *)bankModel
{
    _bankModel = bankModel;
}
@end
