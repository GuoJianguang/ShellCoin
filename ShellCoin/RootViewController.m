//
//  RootViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RootViewController.h"
#import "MessageListViewController.h"
#import "BillViewController.h"

static NSString *infomation = @"infomation";//消息列表
static NSString *feedback = @"feedback";//账户让利回馈
static NSString *withdraw = @"withdraw";//账户抵换
static NSString *waitPay = @"waitPay";//待付款
static NSString *waitReceive = @"waitReceive";//待收货
@interface RootViewController ()<UIAlertViewDelegate>

@property (nonatomic, copy)NSString *turnType;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoLogin) name:AutoLoginAfterGetDeviceToken object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fanxian:) name:Upush_Notifi object:nil];


}

- (void)notifica:(NSDictionary *)notifiInfo
{
    if ([ShellCoinUserInfo shareUserInfos].currentLogined) {
        self.turnType = NullToSpace(notifiInfo[@"page"]);
        NSString *alerInfo = NullToSpace(notifiInfo[@"aps"][@"alert"]);
        if (![self.turnType isEqualToString:infomation] &&![self.turnType isEqualToString:withdraw]) {
            UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [showView show];
            showView.tag = 20;
            return;
        }
        UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去看看", nil];
        [showView show];
        showView.tag = 10;
    }
}

//接收让利回馈信息的推送
- (void)fanxian:(NSNotification *)faication
{
    if ([ShellCoinUserInfo shareUserInfos].currentLogined) {
        self.turnType = NullToSpace(faication.userInfo[@"page"]);
        NSString *alerInfo = NullToSpace(faication.userInfo[@"aps"][@"alert"]);
        if (![self.turnType isEqualToString:infomation] &&![self.turnType isEqualToString:withdraw]) {
            UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [showView show];
            showView.tag = 20;
            return;
        }
        UIAlertView *showView = [[UIAlertView alloc]initWithTitle:@"提醒" message:alerInfo delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去看看", nil];
        [showView show];
        showView.tag = 10;
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10 && buttonIndex == 1) {
        if ([self.turnType isEqualToString:infomation]) {
            MessageListViewController *listVC = [[MessageListViewController alloc]init];
            [self pushViewController:listVC animated:YES];
            
        }else if([self.turnType isEqualToString:feedback]){
//            WalletDymicViewController *detailVC = [[WalletDymicViewController alloc]init];
//            detailVC.walletType = WalletDymic_type_fanXian;
//            [self pushViewController:detailVC animated:YES];
        }else if([self.turnType isEqualToString:withdraw]){
            BillViewController *orderListVC = [[BillViewController alloc]init];
            orderListVC.isCheckWithDrawal = YES;
            [self pushViewController:orderListVC animated:YES];
        }else if([self.turnType isEqualToString:waitPay]){
            //            WaitPayViewController *waitPayVC = [[WaitPayViewController alloc]init];
            //            [self pushViewController:waitPayVC animated:YES];
        }else if([self.turnType isEqualToString:waitReceive]){
//            BillViewController *orderListVC = [[BillViewController alloc]init];
//            orderListVC.orderType = Order_type_waitShipp;
//            [self pushViewController:orderListVC animated:YES];
        }
        return;
    }else if(alertView.tag == 20){
        return;
    }else if(alertView.tag == 10 && buttonIndex == 0){
        return;
    }else{
        //去登录
        if (buttonIndex == 1) {
            UINavigationController *logvc = [LoginViewController controller];
            [self presentViewController:logvc animated:YES completion:NULL];
        }
        
    }
}


#pragma mark - 自动登录
- (void)autoLogin
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:LoginUserPassword]) {
        NSString *password = [[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserPassword],PasswordKey]md5_32];
        
        NSDictionary *parms = @{@"phone":[[NSUserDefaults standardUserDefaults]objectForKey:LoginUserName],
                                @"deviceToken":[ShellCoinUserInfo shareUserInfos].devicetoken,
                                @"deviceType":@"ios",
                                @"password":password};
        [HttpClient POST:@"user/login" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                //设置用户信息
                [ShellCoinUserInfo shareUserInfos].currentLogined = YES;
                [[ShellCoinUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
                //统计新增用户
//                [MobClick profileSignInWithPUID:[TTXUserInfo shareUserInfos].userid];
                if ([ShellCoinUserInfo shareUserInfos].islaunchFormNotifi) {
                    [self notifica:[ShellCoinUserInfo shareUserInfos].notificationParms];
                    [ShellCoinUserInfo shareUserInfos].islaunchFormNotifi = NO;
                }
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;  //默认的值是黑色的
    
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
