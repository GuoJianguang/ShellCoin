//
//  OnlinePayViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "MerchantModel.h"


typedef NS_ENUM(NSInteger,Payway_type){
    Payway_type_banlance = 1,//余额支付
    Payway_type_wechat = 2,//微信支付
    Payway_type_cash = 3,//现金支付
};


@interface OnlinePayViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *merchantName;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *yuEMarkBtn;

- (IBAction)yuEBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *yuEbtn;
@property (weak, nonatomic) IBOutlet UIImageView *yuEImage;
@property (weak, nonatomic) IBOutlet UILabel *yuELabel;
@property (weak, nonatomic) IBOutlet UIImageView *wechatImage;
@property (weak, nonatomic) IBOutlet UILabel *wechatLabel;
@property (weak, nonatomic) IBOutlet UIButton *wechatMarkBtn;
@property (weak, nonatomic) IBOutlet UILabel *cashLabel;
@property (weak, nonatomic) IBOutlet UIButton *cashMarkBtn;
@property (weak, nonatomic) IBOutlet UIImageView *cashImage;

@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
- (IBAction)wechatBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;
- (IBAction)cashBtn:(UIButton *)sender;

@property (nonatomic, strong)MerchantModel *dataModel;


@property (nonatomic, copy)NSString *money;


//支付方式
@property (nonatomic, assign)Payway_type payWay_type;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)sureBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *moneyTF;



@end
