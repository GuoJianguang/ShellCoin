//
//  TradInTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradInTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *tradInTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *canTardinAmountLabel;

@property (weak, nonatomic) IBOutlet UILabel *alerputInLabel;

@property (weak, nonatomic) IBOutlet UITextField *inputAmountTF;

@property (weak, nonatomic) IBOutlet UILabel *calculateInputAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankCardNumLabel;
- (IBAction)selcetBankCardBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *rulesLabel;

@property (weak, nonatomic) IBOutlet UILabel *alerShellCoinLabel;

@property (weak, nonatomic) IBOutlet UILabel *alerIntegralLabel;

@property (weak, nonatomic) IBOutlet UILabel *shellCoinLabel;

@property (weak, nonatomic) IBOutlet UILabel *intergeralLabel;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(UIButton *)sender;


@end
