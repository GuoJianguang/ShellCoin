//
//  MallSureOrderViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallSureOrderViewController.h"
#import "SelectShippingAddressViewController.h"

@interface MallSureOrderViewController ()<BasenavigationDelegate>

@end

@implementation MallSureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"确认订单";
    self.naviBar.delegate = self;
    self.name.textColor = self.phone.textColor = self.address.textColor =[UIColor colorFromHexString:@"#3c3c3c"];

    
    self.balanceLabel.adjustsFontSizeToFitWidth = YES;
    self.balanceLabel.textColor = MacoDetailColor;
    self.balanceLabel.text = [NSString stringWithFormat:@"可用金额%.2f元",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue]];
    [self.addAddressBtn.superview bringSubviewToFront:self.addAddressBtn];
    self.addAddressBtn.titleLabel.adjustsFontSizeToFitWidth=self.name.adjustsFontSizeToFitWidth = self.phone.adjustsFontSizeToFitWidth = self.address.adjustsFontSizeToFitWidth = YES;
    [self.addAddressBtn setTitleColor:MacoTitleColor forState:UIControlStateNormal];
    self.cashLabel.textColor = self.shellCoinLabel.textColor = self.cardLabel.textColor = self.cash.textColor = self.shellCoin.textColor = self.card.textColor = MacoTitleColor;
    
    self.yuEImage.image = [UIImage imageNamed:@"icon_mallyue_nor"];
    self.yuELabel.textColor = MacoDetailColor;
    self.yuEMark.image = [UIImage imageNamed:@"btn_quanxuan"];
    
    self.wechatImage.image = [UIImage imageNamed:@"icon_mallwechat_payment_sel"];
    self.wechatLabel.textColor = MacoColor;
    self.wechatMark.image = [UIImage imageNamed:@"btn_quanxuanzhong"];
    
    
    self.aliPayImage.image = [UIImage imageNamed:@"icon_mallzhifubao_nor"];
    self.aliPayLabel.textColor = MacoDetailColor;
    self.aliPayMark.image = [UIImage imageNamed:@"btn_quanxuan"];
    
    [self addressRequest];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeShippingAddress:) name:@"selectAddress" object:nil];
    
}


- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"selectAddress" object:nil];

    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark- 修改收货地址
- (void)changeShippingAddress:(NSNotification *)notification
{
    if (!notification.userInfo) {
        self.addAddressBtn.backgroundColor = [UIColor whiteColor];
        [self.addAddressBtn setTitle:@"请点击选择收货地址" forState:UIControlStateNormal];
        return;
    }
    self.addressmodel = notification.userInfo[@"model"];
    
}

#pragma mark - 请求收货地址列表
- (void)addressRequest
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token};
    [HttpClient POST:@"user/userInfo/address/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = jsonObject[@"data"];
            for (int i =0; i < array.count; i ++) {
                ShippingAddressModel *model=  [ShippingAddressModel modelWithDic:array[i]];
                if (i ==0) {
                    self.addressmodel = model;
                }
            }
            if (!self.addressmodel.addressId) {
                self.addAddressBtn.backgroundColor = [UIColor whiteColor];
                [self.addAddressBtn setTitle:@"请点击选择收货地址" forState:UIControlStateNormal];
            }
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


- (void)setAddressmodel:(ShippingAddressModel *)addressmodel
{
    _addressmodel = addressmodel;
    if (!self.addressmodel.addressId) {
        self.addAddressBtn.backgroundColor = [UIColor whiteColor];
        [self.addAddressBtn setTitle:@"请点击选择收货地址" forState:UIControlStateNormal];
    }else{
        self.addAddressBtn.backgroundColor = [UIColor clearColor];
        [self.addAddressBtn setTitle:@"" forState:UIControlStateNormal];
        self.name.text = [NSString stringWithFormat:@"收货人:%@",NullToSpace(self.addressmodel.name)];
        self.phone.text = [NSString stringWithFormat:@"联系电话:%@",NullToSpace(self.addressmodel.phone)];
        
        self.address.text = [NSString stringWithFormat:@"收货地址:%@",NullToSpace(self.addressmodel.addressDetail)];
        
    }

}

#pragma mark -  选择收货地址
- (IBAction)addAddressBtn:(UIButton *)sender
{
    SelectShippingAddressViewController *addressVC = [[SelectShippingAddressViewController alloc]init];
    [self.navigationController pushViewController:addressVC animated:YES];
}

#pragma mark - 选择支付方式

//余额
- (IBAction)yuEBtn:(UIButton *)sender
{
    self.yuEImage.image = [UIImage imageNamed:@"icon_mallyue_sel"];
    self.yuELabel.textColor = MacoColor;
    self.yuEMark.image = [UIImage imageNamed:@"btn_quanxuanzhong"];
    
    self.wechatImage.image = [UIImage imageNamed:@"icon_mallwechat_payment_nor"];
    self.wechatLabel.textColor = MacoDetailColor;
    self.wechatMark.image = [UIImage imageNamed:@"btn_quanxuan"];
    
    
    self.aliPayImage.image = [UIImage imageNamed:@"icon_mallzhifubao_nor"];
    self.aliPayLabel.textColor = MacoDetailColor;
    self.aliPayMark.image = [UIImage imageNamed:@"btn_quanxuan"];
}

//微信
- (IBAction)wechatBtn:(UIButton *)sender
{
    self.yuEImage.image = [UIImage imageNamed:@"icon_mallyue_nor"];
    self.yuELabel.textColor = MacoDetailColor;
    self.yuEMark.image = [UIImage imageNamed:@"btn_quanxuan"];
    
    self.wechatImage.image = [UIImage imageNamed:@"icon_mallwechat_payment_sel"];
    self.wechatLabel.textColor = MacoColor;
    self.wechatMark.image = [UIImage imageNamed:@"btn_quanxuanzhong"];
    
    
    self.aliPayImage.image = [UIImage imageNamed:@"icon_mallzhifubao_nor"];
    self.aliPayLabel.textColor = MacoDetailColor;
    self.aliPayMark.image = [UIImage imageNamed:@"btn_quanxuan"];
    
}
//支付宝
- (IBAction)aliPay:(UIButton *)sender
{

    self.yuEImage.image = [UIImage imageNamed:@"icon_mallyue_nor"];
    self.yuELabel.textColor = MacoDetailColor;
    self.yuEMark.image = [UIImage imageNamed:@"btn_quanxuan"];
    
    self.wechatImage.image = [UIImage imageNamed:@"icon_mallwechat_payment_nor"];
    self.wechatLabel.textColor = MacoDetailColor;
    self.wechatMark.image = [UIImage imageNamed:@"btn_quanxuan"];
    
    
    self.aliPayImage.image = [UIImage imageNamed:@"icon_mallzhifubao_sel"];
    self.aliPayLabel.textColor = MacoColor;
    self.aliPayMark.image = [UIImage imageNamed:@"btn_quanxuanzhong"];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sureBtn:(UIButton *)sender {
}
@end
