//
//  VipDetailViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "VipDetailViewController.h"

@interface VipDetailViewController ()<UIWebViewDelegate>

@end

@implementation VipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
    self.ingerView.layer.cornerRadius = 4;
    self.ingerView.layer.masksToBounds = YES;
    self.expalinLabel.textColor = MacoDetailColor;
    self.view.backgroundColor = [UIColor whiteColor];
    self.nowIntegral.adjustsFontSizeToFitWidth = self.totalInegral.adjustsFontSizeToFitWidth =self.alerLabel.adjustsFontSizeToFitWidth= YES;
    NSURL  *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HttpClient_BaseUrl,@"user/page/jf-uCenter"]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    [self SetVipImage];
}


#pragma mark - webview
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //    [SVProgressHUD showWithStatus:@"正在加载..."];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //    [SVProgressHUD dismiss];
}

- (void)SetVipImage
{

    self.nowIntegral.text = [NSString stringWithFormat:@"当前积分%ld",[ShellCoinUserInfo shareUserInfos].currentTotalAmount];
    self.totalInegral.text = [NSString stringWithFormat:@"%ld",[ShellCoinUserInfo shareUserInfos].nextLevelAmount];
    self.alerLabel.text = [NSString stringWithFormat:@"再获取%ld积分升级为VIP%ld(消费金额1元=1积分)",[ShellCoinUserInfo shareUserInfos].nextLevelAmount - [ShellCoinUserInfo shareUserInfos].currentTotalAmount,[[ShellCoinUserInfo shareUserInfos].vipLevel integerValue] +1 ];
    
    CGFloat value= (double)[ShellCoinUserInfo shareUserInfos].currentTotalAmount/(double)[ShellCoinUserInfo shareUserInfos].nextLevelAmount;
    
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, 0, self.ingerView.bounds.size.height);
    view.backgroundColor =  [UIColor colorFromHexString:@"#f5b8b8"];
    for (UIView *vi in self.ingerView.subviews) {
        [vi removeFromSuperview];
    }
    [self.ingerView addSubview:view];
    view.layer.cornerRadius = self.ingerView.bounds.size.height/2;
    view.layer.masksToBounds = YES;
    CGFloat width= 0;
    if (!isnan(value)) {
        width = self.ingerView.bounds.size.width*value;
    }
    [UIView animateWithDuration:1.5 animations:^{
        view.frame = CGRectMake(0, 0, width, self.ingerView.bounds.size.height);
    } completion:^(BOOL finished) {
    }];

    
    switch ([[ShellCoinUserInfo shareUserInfos].vipLevel integerValue]) {
        case 1:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip1"];
            break;
        case 2:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip2"];

            break;
        case 3:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip3"];

            break;
        case 4:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip4"];

            break;
        case 5:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip5"];

            break;
        case 6:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip6"];

            break;
        case 7:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip7"];

            break;
        case 8:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip8"];

            break;
        case 9:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip9"];

            break;
        case 10:
            self.vipImage.image = [UIImage imageNamed:@"icon_vip10"];
            self.alerLabel.text = [NSString stringWithFormat:@"再获取%ld积分升级为银钻用户(消费金额1元=1积分)",[ShellCoinUserInfo shareUserInfos].nextLevelAmount - [ShellCoinUserInfo shareUserInfos].currentTotalAmount];
            break;
        case 11:
            self.vipImage.image = [UIImage imageNamed:@"icon_silver_drill_member"];

            self.alerLabel.text = [NSString stringWithFormat:@"再获取%ld积分升级为金钻用户(消费金额1元=1积分)",[ShellCoinUserInfo shareUserInfos].nextLevelAmount - [ShellCoinUserInfo shareUserInfos].currentTotalAmount];
            break;
        case 12:
            self.vipImage.image = [UIImage imageNamed:@"icon_gold_drill_member"];
          self.alerLabel.text = [NSString stringWithFormat:@"再获取%ld积分升级为皇冠用户(消费金额1元=1积分)",[ShellCoinUserInfo shareUserInfos].nextLevelAmount - [ShellCoinUserInfo shareUserInfos].currentTotalAmount];
            break;
        case 13:
            self.vipImage.image = [UIImage imageNamed:@"icon_crown_member"];
  
            self.alerLabel.text = [NSString stringWithFormat:@"您已经是最高皇冠用户(消费金额1元=1积分)"];
            self.totalInegral.text = [NSString stringWithFormat:@"皇冠用户"];


            break;
        default:
            break;
    }
    
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

- (IBAction)backBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
