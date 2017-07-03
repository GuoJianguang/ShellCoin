//
//  OrderDetailViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"
#import "SureReceivingView.h"
#import "OrderModel.h"
@interface OrderDetailViewController ()<BasenavigationDelegate,UITableViewDelegate,UITableViewDataSource,SureReceivingDelegate>
@property (nonatomic, strong)SureReceivingView *passwordView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title= @"查看订单";
    self.naviBar.detailTitle = @"联系客服";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goinputPassword:) name:@"orderDetailsureReceiving" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applySueecss:) name:@"applySueecss" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cacelapplySueecss:) name:@"cancelapplySueecss" object:nil];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}
- (SureReceivingView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[SureReceivingView alloc]init];
        _passwordView.delegate = self;
    }
    return _passwordView;
}


- (void)setOrderModel:(OrderModel *)orderModel
{
    _orderModel = orderModel;
    [self.tableView reloadData];
}
#pragma mark - 联系客服
- (void)detailBtnClick
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"02865224503"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
#pragma mark - 返回

- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"orderDetailsureReceiving" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"applySueecss" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"cancelapplySueecss" object:nil];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setOrderType:(Myorder_type)orderType
{
    _orderType = orderType;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[OrderDetailTableViewCell indentify]];
    if (!cell) {
        cell = [OrderDetailTableViewCell newCell];
    }
    cell.dataModel = self.orderModel;
    cell.orderType = self.orderType;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh * (600/320.);
}


#pragma mark - 确认收货输入支付密码
- (void)goinputPassword:(NSNotification *)notfication
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"是否确认收货？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDictionary *prams = @{@"orderId":self.orderModel.orderId,
                                @"token":[ShellCoinUserInfo shareUserInfos].token};
        [SVProgressHUD showWithStatus:@"正在发送请求"];
        [HttpClient POST:@"shop/order/confirm" parameters:prams success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"yetsureReceiving" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
            [[JAlertViewHelper shareAlterHelper]showTint:@"确认收货失败，请重试" duration:2.0];
        }];
        
    }];
    [alertcontroller addAction:cancelAction];
    [alertcontroller addAction:otherAction];
    [self presentViewController:alertcontroller animated:YES completion:NULL];
    return;
//    [self.view addSubview:self.passwordView];
//    self.passwordView.passwordTF.text = @"";
//    self.passwordView.orderId = self.orderModel.orderId;
//    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(insets);
//    }];
//    self.passwordView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
//    [UIView animateWithDuration:0.5 animations:^{
//        self.passwordView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
//    }];
}

#pragma mark - 确认收货成功
- (void)sureReceivingsuccess:(NSString *)payWay
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yetsureReceiving" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 申请售后成功
- (void)applySueecss:(NSNotification *)ficatioon
{
   self.orderModel.state = @"4";
    [self.tableView reloadData];
}
- (void)cacelapplySueecss:(NSNotification *)ficatioon
{
    switch (self.orderType) {
        case Myorder_type_waitSendGoods:
            self.orderModel.state = @"1";
            break;
        case Myorder_type_waitReceiveGoods:
            self.orderModel.state = @"2";
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
