//
//  WithdrawalViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "BankCardInfoModel.h"
#import "WithDrawalResultView.h"


@interface WithdrawalViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *tradInTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *canTardinAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *alerputInLabel;

@property (weak, nonatomic) IBOutlet UITextField *inputAmountTF;


@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankCardNumLabel;
- (IBAction)selcetBankCardBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *canWithDrawLabel;

@property (weak, nonatomic) IBOutlet UILabel *poundageLabel;


@property (nonatomic, strong)BankCardInfoModel *bankModel;


@property (nonatomic,strong)WithDrawalResultView *resultView;


- (void)withDrawalSuccess;

@end
