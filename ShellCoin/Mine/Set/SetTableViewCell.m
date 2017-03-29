//
//  SetTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SetTableViewCell.h"
#import "EditPhoneNumberViewController.h"
#import "SetPasswordViewController.h"
#import "AboutUSViewController.h"


@implementation SetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.exitBtn.layer.cornerRadius = TWitdh*(36/75.)*(8/36.)/2.;
    self.exitBtn.layer.masksToBounds = YES;
    self.exitBtn.layer.borderWidth = 1;
    self.exitBtn.layer.borderColor= MacoColor.CGColor;
    [self.exitBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    self.aboutUsLabel.textColor  = self.cleanLabel.textColor = self.phoneLabel.textColor = self.passwordLabel.textColor = MacoTitleColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)backBtn:(UIButton *)sender {
    [self.viewController.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)exitBtn:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSArray *titles = @[@"退出"];
    [self addActionTarget:alert titles:titles];
    [self addCancelActionTarget:alert title:@"取消"];
    // 会更改UIAlertController中所有字体的内容（此方法有个缺点，会修改所以字体的样式）
    UILabel *appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    UIFont *font = [UIFont systemFontOfSize:15];
    [appearanceLabel setFont:font];
    [self.viewController presentViewController:alert animated:YES completion:nil];
}

- (IBAction)phoneBtn:(id)sender {
    EditPhoneNumberViewController *phoneVC = [[EditPhoneNumberViewController alloc]init];
    [self.viewController.navigationController pushViewController:phoneVC animated:YES];
    
}
- (IBAction)passwordBtn:(id)sender {
    SetPasswordViewController *setPasswordVC = [[SetPasswordViewController alloc]init];
    [self.viewController.navigationController pushViewController:setPasswordVC animated:YES];
    
}

- (IBAction)cleanBtn:(id)sender {
    [SVProgressHUD showWithStatus:@"正在清除..."];
    [[SDImageCache sharedImageCache]clearDisk];
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
//        NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];
        [SVProgressHUD showSuccessWithStatus:@"清除完毕"];
        
    }];
}

- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

- (IBAction)aboutUsBtn:(id)sender {
    AboutUSViewController *aboutsVC = [[AboutUSViewController alloc]init];
    [self.viewController.navigationController pushViewController:aboutsVC animated:YES];
    
}



#pragma mark - 退出登录的方法

// 添加其他按钮
- (void)addActionTarget:(UIAlertController *)alertController titles:(NSArray *)titles
{
    for (NSString *title in titles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [HttpClient POST:@"user/logout" parameters:@{@"token":[ShellCoinUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            }];
            [ShellCoinUserInfo shareUserInfos].currentLogined = NO;
            [self.viewController.navigationController popToRootViewControllerAnimated:YES];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:LoginUserPassword];
            //统计新增用户
//            [MobClick profileSignOff];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [[NSNotificationCenter defaultCenter]postNotificationName:LogOutNSNotification object:nil userInfo:nil];
        }];
        [action setValue:MacoColor forKey:@"_titleTextColor"];
        [alertController addAction:action];
    }
}

// 取消按钮
- (void)addCancelActionTarget:(UIAlertController *)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [action setValue:MacoTitleColor forKey:@"_titleTextColor"];
    [alertController addAction:action];
}

@end
