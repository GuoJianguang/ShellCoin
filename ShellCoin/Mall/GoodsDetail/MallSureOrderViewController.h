//
//  MallSureOrderViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressTableViewCell.h"

typedef enum : NSUInteger {
    MallPay_blance,
    MallPay_alipay,
    MallPay_wechatpay,
} MallPayType;

@interface MallSureOrderViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *addAddressBtn;
- (IBAction)addAddressBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *cashLabel;
@property (weak, nonatomic) IBOutlet UILabel *cash;

@property (weak, nonatomic) IBOutlet UILabel *shellCoinLabel;
@property (weak, nonatomic) IBOutlet UILabel *shellCoin;
@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property (weak, nonatomic) IBOutlet UILabel *card;


#pragma mark - 选择支付方式
@property (weak, nonatomic) IBOutlet UIImageView *yuEMark;
- (IBAction)yuEBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *yuEbtn;
@property (weak, nonatomic) IBOutlet UIImageView *yuEImage;
@property (weak, nonatomic) IBOutlet UILabel *yuELabel;

@property (weak, nonatomic) IBOutlet UIImageView *wechatImage;
@property (weak, nonatomic) IBOutlet UILabel *wechatLabel;
@property (weak, nonatomic) IBOutlet UIImageView *wechatMark;
- (IBAction)wechatBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;



@property (weak, nonatomic) IBOutlet UIImageView *aliPayImage;
@property (weak, nonatomic) IBOutlet UILabel *aliPayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *aliPayMark;
@property (weak, nonatomic) IBOutlet UIButton *aliPaytBtn;
- (IBAction)aliPay:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;


#pragma mark - 确认订单
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@property (nonatomic, strong)ShippingAddressModel *addressmodel;


@property (nonatomic, copy)NSMutableArray *orderArry;


@property (nonatomic, assign)MallPayType payType;

#pragma mark - 支付已经生成的未支付订单
@property (nonatomic, assign)BOOL isFormWaitPayOrder;
@property (nonatomic, strong)NSDictionary *waiPayOrderDic;

#pragma mark - 判断是否是从购物车进来的
@property (nonatomic, assign)BOOL isFormShoppingCart;

@property (nonatomic, strong)NSMutableArray *yetSelectarray;

@end
