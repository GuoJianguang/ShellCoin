//
//  NoBankCardViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "NoBankCardViewController.h"
#import "EditBankInfoViewController.h"

@interface NoBankCardViewController ()

@end

@implementation NoBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"银行卡";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加银行卡
- (IBAction)addBtn:(id)sender {
    EditBankInfoViewController *editBankInfoVC = [[EditBankInfoViewController alloc]init];
    [self.navigationController pushViewController:editBankInfoVC animated:YES];
    
}
@end
