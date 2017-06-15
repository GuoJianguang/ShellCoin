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

}
- (SureReceivingView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[SureReceivingView alloc]init];
        _passwordView.delegate = self;
    }
    return _passwordView;
}

#pragma mark - 联系客服
- (void)detailBtnClick
{
    
}
#pragma mark - 返回

- (void)backBtnClick
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"orderDetailsureReceiving" object:nil];
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
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token};
    [self.view addSubview:self.passwordView];
    self.passwordView.passwordTF.text = @"";
    self.passwordView.mallOrderParms = [NSMutableDictionary dictionaryWithDictionary:parms];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.passwordView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.passwordView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
    }];
}

#pragma mark - 确认收货成功
- (void)sureReceivingsuccess:(NSString *)payWay
{
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
