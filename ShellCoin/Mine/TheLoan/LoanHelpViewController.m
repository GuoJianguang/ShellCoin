//
//  HelpViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "LoanHelpViewController.h"

@interface LoanHelpViewController ()

@end

@implementation LoanHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"购买帮助说明";
    self.detailLabel.textColor = MacoTitleColor;
    self.detailLabel.text = @"1、购物券消费不会累积到每月消费抵月供金额内\n2、每月还款日前2天生成每月结算单，生成结算单日及之后的订单将自动累积到次月结算单内，请自行合理安排消费时间";
    self.detailLabel.numberOfLines = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
