//
//  LoanListViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/4/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "LoanListViewController.h"
#import "AddLoanTableViewCell.h"
#import "AddLoanViewController.h"
#import "RealnameViewController.h"
#import "LoanTableViewCell.h"

@interface LoanListViewController ()<BasenavigationDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation LoanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"懒鱼贷款";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_explain"];
    self.naviBar.delegate = self;
}

#pragma mark - 帮助
- (void)detailBtnClick
{
    
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        AddLoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddLoanTableViewCell indentify]];
        if (!cell) {
            cell = [AddLoanTableViewCell newCell];
        }
        return cell;
    }else{
        LoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LoanTableViewCell indentify]];
        if (!cell) {
            cell = [LoanTableViewCell newCell];
        }
        if (indexPath.row == 0) {
            cell.bgImageView.image = [UIImage imageNamed:@"bg_loan_green"];
        }
        if (indexPath.row == 1) {
            cell.bgImageView.image = [UIImage imageNamed:@"bg_loan_orange"];
        }
        if (indexPath.row == 2) {
            cell.bgImageView.image = [UIImage imageNamed:@"bg_loan_purple"];
        }
        return cell;
    }
    
  

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return TWitdh*(210/750.);

    }
    return TWitdh*(330/750.);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self gotRealNameRu:@"在您申请之前,请先进行实名认证"]){
        return;
    }
    AddLoanViewController *addVC = [[AddLoanViewController alloc]init];
    [self.navigationController pushViewController:addVC animated:YES];
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
