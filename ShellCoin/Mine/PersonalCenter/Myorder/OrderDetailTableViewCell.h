//
//  OrderDetailTableViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewCell : BaseTableViewCell

#pragma mark - 收货信息
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *adress;

#pragma mark - 商品信息
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
- (IBAction)checkStore:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *store;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetail;
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;
@property (weak, nonatomic) IBOutlet UILabel *goodsInfo;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *sureShippBtn;
- (IBAction)sureShippBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkLogBtn;
- (IBAction)checkLogBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *applyAfterSalesBtn;
- (IBAction)applyAfterSalesBtn:(UIButton *)sender;

#pragma mark - 费用信息

@property (weak, nonatomic) IBOutlet UILabel *freightLabel;
@property (weak, nonatomic) IBOutlet UILabel *freight;
@property (weak, nonatomic) IBOutlet UILabel *shellCoinLabel;
@property (weak, nonatomic) IBOutlet UILabel *shellCoin;
@property (weak, nonatomic) IBOutlet UILabel *buyCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCard;
@property (weak, nonatomic) IBOutlet UILabel *actualMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *actualMoney;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;

@end
