//
//  LoanHomeViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "LoanHomeViewController.h"
#import "AddLoanViewController.h"
#import "LoanListViewController.h"
#import "RealnameViewController.h"
#import "LoanOtherViewController.h"
#import "LoanHelpViewController.h"

@interface LoanHomeViewController ()<BasenavigationDelegate>

@end

@implementation LoanHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"车房易购";
    
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_explain"];
    self.naviBar.delegate = self;
}

#pragma mark - 解释
- (void)detailBtnClick
{
    LoanHelpViewController *helpVC = [[LoanHelpViewController alloc]init];
    [self.navigationController pushViewController:helpVC animated:YES];
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

#pragma mark - 点击事件
- (IBAction)addBtn:(UIButton *)sender {
    
    if ([self gotRealNameRu:@"在您申请之前,请先进行实名认证"]){
        return;
    }
    AddLoanViewController *addVC = [[AddLoanViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
}

- (IBAction)successBtn:(UIButton *)sender {
    LoanListViewController *listVC = [[LoanListViewController alloc]init];
    [self.navigationController pushViewController:listVC animated:YES];
    
}

- (IBAction)reviewBtn:(UIButton *)sender {
    LoanOtherViewController *loanOtherVC = [[LoanOtherViewController alloc]init];
    loanOtherVC.loanType = Loan_type_audit;
    [self.navigationController pushViewController:loanOtherVC animated:YES];
    
}

- (IBAction)failBtn:(UIButton *)sender {
    LoanOtherViewController *loanOtherVC = [[LoanOtherViewController alloc]init];
    loanOtherVC.loanType = Loan_type_fail;
    [self.navigationController pushViewController:loanOtherVC animated:YES];
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
