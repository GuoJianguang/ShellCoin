//
//  WaitAfterForSalesViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "WaitAfterForSalesViewController.h"
#import "OrderModel.h"

@interface WaitAfterForSalesViewController ()<BasenavigationDelegate>

@end

@implementation WaitAfterForSalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.naviBar.title= @"售后状态";
    self.naviBar.detailTitle = @"我要投诉";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;

    
    self.autResultLabel.adjustsFontSizeToFitWidth = YES;
    self.autResultLabel.numberOfLines = 3;
    self.autResultLabel.textColor = MacoTitleColor;
    if (TWitdh > 320) {
        self.ViewHeight.constant = (TWitdh-100)*(550/520.);
    }else{
        self.ViewHeight.constant = (TWitdh-100)*(650/520.);
        
    }
    self.autResultTitleLabel.text = self.autResultTitleLabel.text = @"申请处理中";
    self.titleimageView.image = [UIImage imageNamed:@"pic7_personal"];
    self.alerResultImageView.image = [UIImage imageNamed:@"pic8_personal"];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"pic9_personal"] forState:UIControlStateNormal];
    [self.backBtn setTitle:@"取消申请" forState:UIControlStateNormal];
    self.autResultLabel.text = @"卖家正在处理您的申请，请耐心等待。若卖家48小时内未处理，您可通过投诉入口申请帮助。";
}


#pragma mark - 我要投诉
- (void)detailBtnClick
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"02865224503"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#pragma mark - 取消申请
- (IBAction)backBtn:(id)sender
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"orderId":self.dataModel.orderId};
    [HttpClient POST:@"shop/refund/cancel" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"取消申请成功" duration:2.];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"cancelapplySueecss" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"取消失败，请重试" duration:2.];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
