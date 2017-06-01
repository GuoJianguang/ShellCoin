//
//  SureDiscoverOrderViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SureDiscoverOrderViewController.h"
#import "AliPayObject.h"
#import "DiscoverOnlinePayResultView.h"
#import "RealnameViewController.h"


@interface SureDiscoverOrderViewController ()<UITableViewDelegate,UITableViewDataSource,BasenavigationDelegate>
@property (nonatomic, strong)DiscoverOnlinePayResultView *resultView;

@end

@implementation SureDiscoverOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"确认订单";
    self.naviBar.delegate = self;
    [self getGoodsDetailRequest];
    [self addressRequest];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeShippingAddress:) name:@"selectAddress" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(aliPayResult:) name:AliPayResult object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(weixinPayResult:) name:WeixinPayResult object:nil];

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
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}

- (ShippingAddressModel *)addressmodel
{
    if (!_addressmodel) {
        _addressmodel = [[ShippingAddressModel alloc]init];
    }
    return _addressmodel;
}

- (void)changeShippingAddress:(NSNotification *)notification
{
    if (!notification.userInfo) {
        SureDiscoverOrderTableViewCell *cell = self.tableView.visibleCells[0];
        self.addressmodel.addressId = nil;
        cell.addressModel = self.addressmodel;
        return;
    }
    self.addressmodel = notification.userInfo[@"model"];
    SureDiscoverOrderTableViewCell *cell = self.tableView.visibleCells[0];
    cell.addressModel = self.addressmodel;
    //    [self.tableView reloadData];
}
#pragma mark - 获取商品详情
- (void)getGoodsDetailRequest
{
    NSDictionary *parms = @{@"id":NullToSpace(self.goodsId)};
    [HttpClient POST:@"find/goods/detail/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            self.dataModel = [DiscoverGoodsDetailModel modelWithDic:jsonObject[@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
}


- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"selectAddress" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WeixinPayResult object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AliPayResult object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SureDiscoverOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SureDiscoverOrderTableViewCell indentify]];
    if (!cell) {
        cell = [SureDiscoverOrderTableViewCell newCell];
    }
    cell.number = self.number;
    cell.dataModel = self.dataModel;
    cell.addressModel = self.addressmodel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (TWitdh-24)*(950/730.) + 60;
}


- (IBAction)sureBtn:(UIButton *)sender {
    if (!self.addressmodel.addressId) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择或者填写收货地址" duration:2.];
        return;
    }
//    if ([self gotRealNameRu:@"在您付款之前,请先进行实名认证"]){
//        return;
//    }
    SureDiscoverOrderTableViewCell *cell = self.tableView.visibleCells[0];
    NSString *amount = [NSString stringWithFormat:@"%.2f",[NullToNumber(self.dataModel.cashAmount) doubleValue] + [NullToNumber(self.dataModel.expectAmount) doubleValue]];
    NSString *tranAmount = [NSString stringWithFormat:@"%.2f",([NullToNumber(self.dataModel.cashAmount) doubleValue] + [NullToNumber(self.dataModel.expectAmount) doubleValue])*self.number + [self.dataModel.freight doubleValue]];
    
    
    //    分别将商品ID、数量、交易金额、加密盐值(T2t0X16)等参数值拼接做md5加密，公式：md5(goodsId+price+ quantity+tranAmount+T2t0X16)
    NSString *md5Str = [NSString stringWithFormat:@"%@%@%@%@",self.goodsId,@(self.number),tranAmount,OrderWithMd5Key];
    NSString *sign = [md5Str md5_32];
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"addrId":NullToSpace(self.addressmodel.addressId),
                            @"goodsId":NullToSpace(self.goodsId),
                            @"price":amount,
                            @"quantity":@(self.number),
                            @"freight":self.dataModel.freight,
                            @"tranAmount":tranAmount,
                            @"message":@"",
                            @"sign":sign};
    switch (cell.pay_type) {
        case DiscoverPayway_type_alipay:
        {
            [AliPayObject startAliPayDiscoverPay:parms];
        }
            break;
        case DiscoverPayway_type_wechat:
        {
            [WeXinPayObject startDiscoverGoodsPay:parms];
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - 支付结果
- (DiscoverOnlinePayResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[DiscoverOnlinePayResultView alloc]init];
    }
    return _resultView;
}

- (void)paySuccess
{
    self.naviBar.hiddenDetailBtn = YES;
    [self.view addSubview:self.resultView];
    self.resultView.successLabel.text = [NSString stringWithFormat:@"%@*%ld",self.dataModel.name,self.number];
    NSString *tranAmount = [NSString stringWithFormat:@"%.2f",([NullToNumber(self.dataModel.cashAmount) doubleValue] + [NullToNumber(self.dataModel.expectAmount) doubleValue])*self.number + [self.dataModel.freight doubleValue]];
    self.resultView.autResultLabel.text =[NSString stringWithFormat:@"¥ %@",tranAmount];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}

#pragma mark - 支付宝结算结果
- (void)aliPayResult:(NSNotification *)notification{
    
    switch ([notification.userInfo[@"resultStatus"] integerValue]) {
        case 9000:
        {
            self.resultView.payType = Discover_PayTYpe_alipay;
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
            self.resultView.payType = Discover_PayTYpe_wechat;
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

#pragma mark - 去进行实名认证
- (BOOL)gotRealNameRu:(NSString *)alerTitle
{
    if (![ShellCoinUserInfo shareUserInfos].identityFlag) {
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:alerTitle preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //去进行实名认证
            
            if ([ShellCoinUserInfo shareUserInfos].idVerifyReqFlag) {
                RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
                realnameVC.isWaitAut = YES;
                [self.navigationController pushViewController:realnameVC animated:YES];
                
                return;
            }
            RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
            realnameVC.isYetAut = NO;
            [self.navigationController pushViewController:realnameVC animated:YES];
            
        }];
        [alertcontroller addAction:cancelAction];
        [alertcontroller addAction:otherAction];
        [self presentViewController:alertcontroller animated:YES completion:NULL];
        return YES;
    }
    return NO;
}

@end
