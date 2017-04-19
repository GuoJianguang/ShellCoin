//
//  MineTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
- (IBAction)messageBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *barCodeBtn;
- (IBAction)barCodeBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *qrCodeBtn;
- (IBAction)qrCodeBtn:(id)sender;

#pragma mark - 一些元素
@property (weak, nonatomic) IBOutlet UILabel *yestodayEarningsLabel;

@property (weak, nonatomic) IBOutlet UILabel *yestodyEarningsMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *yesTodayBuyCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalBuyCardLabel;

@property (weak, nonatomic) IBOutlet UIButton *helpBtn;
- (IBAction)helpBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tradeInBtn;
- (IBAction)tradeInBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@property (weak, nonatomic) IBOutlet UILabel *showIntergralLabel;
@property (weak, nonatomic) IBOutlet UILabel *proportionLabel;
@property (weak, nonatomic) IBOutlet UILabel *showProportionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showProPortionImageView;


- (IBAction)personCenterAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *personCenterLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;

- (IBAction)recommendEarningsAction:(id)sender;

- (IBAction)billAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *billLabel;

- (IBAction)setAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *setLabel;

- (IBAction)theLoanBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *loanLabel;

- (IBAction)showYestodayEBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *showYestodayEBtn;

@property (weak, nonatomic) IBOutlet UIButton *recomendMark;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;

@end
