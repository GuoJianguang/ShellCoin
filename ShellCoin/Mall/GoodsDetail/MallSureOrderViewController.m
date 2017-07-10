//
//  MallSureOrderViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallSureOrderViewController.h"
#import "SelectShippingAddressViewController.h"
#import "SureTradInView.h"
#import "MallPayResultView.h"
#import "AliPayObject.h"
#import "SetPayPasswordViewController.h"

@interface MallSureOrderViewController ()<BasenavigationDelegate,PayViewDelegate>

@property (nonatomic, strong)SureTradInView *inputPasswordView;

@property (nonatomic, strong)MallPayResultView *resultView;

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
    self.totalMoneyLabel.adjustsFontSizeToFitWidth = YES;
    self.yuEImage.image = [UIImage imageNamed:@"icon_mallyue_sel"];
    self.yuELabel.textColor = MacoColor;
    self.yuEMark.image = [UIImage imageNamed:@"btn_quanxuanzhong"];
    
    self.wechatImage.image = [UIImage imageNamed:@"icon_mallwechat_payment_nor"];
    self.wechatLabel.textColor = MacoDetailColor;
    self.wechatMark.image = [UIImage imageNamed:@"btn_quanxuan"];
    
    
    self.aliPayImage.image = [UIImage imageNamed:@"icon_mallzhifubao_nor"];
    self.aliPayLabel.textColor = MacoDetailColor;
    self.aliPayMark.image = [UIImage imageNamed:@"btn_quanxuan"];
    self.payType  = MallPay_blance;
    
    [self addressRequest];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeShippingAddress:) name:@"selectAddress" object:nil];
 
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(aliPayResult:) name:AliPayResult object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weixinPayResult:) name:WeixinPayResult object:nil];

    [self getPriceInfo];
}


- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"selectAddress" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WeixinPayResult object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AliPayResult object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 获取实际价格信息
- (void)getPriceInfo
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.orderArry options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *prams = [NSDictionary dictionary];
   
    if (self.isFormWaitPayOrder) {
        prams = @{@"reqData":json,
                  @"token":[ShellCoinUserInfo shareUserInfos].token,
                  @"orderId":NullToSpace(self.waiPayOrderDic[@"data"][@"orderId"])};
    }else{
        prams = @{@"reqData":json,
                  @"token":[ShellCoinUserInfo shareUserInfos].token};
    }
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"shop/order/settleAmount/get" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            self.cash.text = [NSString stringWithFormat:@"%.2f元", [NullToNumber(jsonObject[@"data"][@"totalCashAmount"]) doubleValue]];
            self.card.text = [NSString stringWithFormat:@"%.2f元",[NullToNumber(jsonObject[@"data"][@"totalConsumeAmount"]) doubleValue]];
            self.shellCoin.text = [NSString stringWithFormat:@"%.2f个",[NullToNumber(jsonObject[@"data"][@"totalExpectAmount"]) doubleValue]];
            
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"合计:¥%.2f(含运费)",[NullToNumber(jsonObject[@"data"][@"totalCashAmount"]) doubleValue]+[NullToNumber(jsonObject[@"data"][@"totalExpectAmount"]) doubleValue]];
            return ;

        }
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"获取商品信息失败，请返回重试" duration:2.];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
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
    self.payType = MallPay_blance;

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
    self.payType = MallPay_wechatpay;

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
    self.payType = MallPay_alipay;
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
    if (!self.addressmodel.addressId || !self.addressmodel) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择或者填写收货地址" duration:2.];
        return;
    }
    
    if (self.isFormWaitPayOrder) {
        switch (self.payType) {
            case MallPay_blance:
            {
                [self getBalancePayInfomation:self.waiPayOrderDic];
                self.resultView.payType = Mall_PayTYpe_blance;
            }
                break;
            case MallPay_wechatpay:
            {
                NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                        @"orderId":NullToSpace(self.waiPayOrderDic[@"data"][@"orderId"]),
                                        @"type":NullToSpace(self.waiPayOrderDic[@"data"][@"type"])};
                self.resultView.payType = Mall_PayTYpe_wechat;
                [WeXinPayObject startMallWexinPay:prams];
            }
                break;
            case MallPay_alipay:
            {
                self.resultView.payType = Mall_PayTYpe_alipay;
                NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                        @"orderId":NullToSpace(self.waiPayOrderDic[@"data"][@"orderId"]),
                                        @"type":NullToSpace(self.waiPayOrderDic[@"data"][@"type"])};
                [AliPayObject startAliPayMallPay:prams];
            }
        
                break;
            default:
                break;
        }

        
        return;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.orderArry options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *prams = @{@"reqData":json,
                            @"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"addrId":self.addressmodel.addressId};
    [SVProgressHUD showWithStatus:@"正在获取支付信息.." maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"shop/order/add" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            if (self.isFormShoppingCart) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"afterPayDeletOrder" object:self.yetSelectarray];
                
            }
            switch (self.payType) {
                case MallPay_blance:
                {
                    [self getBalancePayInfomation:jsonObject];
                    self.resultView.payType = Mall_PayTYpe_blance;
                }
                    break;
                case MallPay_wechatpay:
                {
                    NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                            @"orderId":NullToSpace(jsonObject[@"data"][@"orderId"]),
                                            @"type":NullToSpace(jsonObject[@"data"][@"type"])};
                    self.resultView.payType = Mall_PayTYpe_wechat;
                    [WeXinPayObject startMallWexinPay:prams];
                }
                    break;
                case MallPay_alipay:
                {
                    self.resultView.payType = Mall_PayTYpe_alipay;
                    NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                            @"orderId":NullToSpace(jsonObject[@"data"][@"orderId"]),
                                            @"type":NullToSpace(jsonObject[@"data"][@"type"])};
                    [AliPayObject startAliPayMallPay:prams];
                }

                    break;
                default:
                    break;
            }

        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        
    }];

    
    
}


- (void)getBalancePayInfomation:(NSDictionary *)jsonObject
{
    if ([[ShellCoinUserInfo shareUserInfos].payPassword isEqualToString:@""]) {
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"抵换之前请先设置您的支付密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            SetPayPasswordViewController *setPayPasswordVC = [[SetPayPasswordViewController alloc]init];
            [self.navigationController pushViewController:setPayPasswordVC animated:YES];
            
        }];
        [alertcontroller addAction:cancelAction];
        [alertcontroller addAction:otherAction];
        [self presentViewController:alertcontroller animated:YES completion:NULL];
        return;
    }
    
    [self.view addSubview:self.inputPasswordView];
    //            NSString *totalMoney = [NSString stringWithFormat:@"%.2f",[self.money doubleValue]];
    self.inputPasswordView.passwordTF.text = @"";
    NSDictionary *prams = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"orderId":NullToSpace(jsonObject[@"data"][@"orderId"]),
                            @"type":NullToSpace(jsonObject[@"data"][@"type"])};
    self.inputPasswordView.mallOrderParms = [NSMutableDictionary dictionaryWithDictionary:prams];
    self.inputPasswordView.delegate = self;
    self.inputPasswordView.inputType = Password_type_MallBalancePay;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.inputPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.inputPasswordView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.inputPasswordView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
    }];
    

}
- (SureTradInView *)inputPasswordView
{
    if (!_inputPasswordView) {
        _inputPasswordView = [[SureTradInView alloc]init];
    }
    return _inputPasswordView;
}

- (void)paysuccess:(NSString *)payWay
{
    [ShellCoinUserInfo shareUserInfos].aviableBalance = payWay;
    self.balanceLabel.text = [NSString stringWithFormat:@"可用金额%.2f元",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"orderPayComplete" object:nil];
    [self paySuccess];
}

#pragma mark - 支付结果
- (MallPayResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[MallPayResultView alloc]init];
    }
    return _resultView;
}


#pragma mark - 支付宝结算结果
- (void)aliPayResult:(NSNotification *)notification{
    
    switch ([notification.userInfo[@"resultStatus"] integerValue]) {
        case 9000:
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"orderPayComplete" object:nil];
            self.resultView.payType = Mall_PayTYpe_alipay;
            [self paySuccess];
        }
            break;
        case 8000:
            [[JAlertViewHelper shareAlterHelper]showTint:@"正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态" duration:2.];
            
            break;
        case 4000:
            [[JAlertViewHelper shareAlterHelper]showTint:@"订单支付失败" duration:2.];
            
            break;
        case 5000:
            [[JAlertViewHelper shareAlterHelper]showTint:@"重复请求" duration:2.];
            
            break;
        case 6001:
            [[JAlertViewHelper shareAlterHelper]showTint:@"用户中途取消" duration:2.];
            
            break;
        case 6002:
            [[JAlertViewHelper shareAlterHelper]showTint:@"网络连接出错" duration:2.];
            
            break;
        case 6004:
            [[JAlertViewHelper shareAlterHelper]showTint:@"支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态" duration:2.];
            
            break;
            
        default:
            break;
    }
    
}
#pragma mark - 微信支付结果回调
- (void)weixinPayResult:(NSNotification *)notification
{
    //    WXSuccess           = 0,    /**< 成功    */
    //    WXErrCodeCommon     = -1,   /**< 普通错误类型    */
    //    WXErrCodeUserCancel = -2,   /**< 用户点击取消并返回    */
    //    WXErrCodeSentFail   = -3,   /**< 发送失败    */
    //    WXErrCodeAuthDeny   = -4,   /**< 授权失败    */
    //    WXErrCodeUnsupport  = -5,   /**< 微信不支持    */
    NSString *code = notification.userInfo[@"resultcode"];
    switch ([code intValue]) {
        case WXSuccess:
        {
            self.resultView.payType = MallPay_wechatpay;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"orderPayComplete" object:nil];
            [self paySuccess];
        }
            
            break;
        case WXErrCodeCommon:
            [[JAlertViewHelper shareAlterHelper]showTint:@"支付失败" duration:2.];
            
            break;
        case WXErrCodeUserCancel:
            [[JAlertViewHelper shareAlterHelper]showTint:@"您已取消支付" duration:2.];
            
            break;
        case WXErrCodeSentFail:
            [[JAlertViewHelper shareAlterHelper]showTint:@"发起支付请求失败" duration:2.];
            
            break;
        case WXErrCodeAuthDeny:
            [[JAlertViewHelper shareAlterHelper]showTint:@"微信支付授权失败" duration:2.];
            break;
        case WXErrCodeUnsupport:
            [[JAlertViewHelper shareAlterHelper]showTint:@"您未安装微信客户端,请先安装" duration:2.];
            break;
        default:
            break;
    }
}

- (void)paySuccess
{

    self.naviBar.hiddenDetailBtn = YES;
    self.naviBar.title = @"交易详情";
    [self.view addSubview:self.resultView];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
//    if (self.isFormShoppingCart) {
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"afterPayDeletOrder" object:self.yetSelectarray];
//        
//    }
}
@end
