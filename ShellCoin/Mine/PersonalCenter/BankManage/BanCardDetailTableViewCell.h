//
//  BanCardDetailTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BankCardInfoModel;

@interface BanCardDetailTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *alerLabel1;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel2;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel3;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel4;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel5;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel6;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel7;

@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *addresslabel;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *wangdianLabel;
@property (weak, nonatomic) IBOutlet UILabel *kaihuhangLabel;
@property (weak, nonatomic) IBOutlet UILabel *hanghaoLabel;
@property (weak, nonatomic) IBOutlet UIButton *deletBtn;

- (IBAction)deletBtn:(UIButton *)sender;

@property (nonatomic, strong)BankCardInfoModel *dataModel;
@end
