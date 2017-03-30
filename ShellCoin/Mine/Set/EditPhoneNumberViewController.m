//
//  EditPhoneNumberViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "EditPhoneNumberViewController.h"

@interface EditPhoneNumberViewController ()

@end

@implementation EditPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"修改手机号";
    self.oldPhoneTF.enabled = NO;
    self.oldPhoneTF.text = [ShellCoinUserInfo shareUserInfos].phone;
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];
    
    [self.sendNewCodeBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    [self.sendOldCodeBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    self.oldPhoneTF.textColor = self.freshCodeTF.textColor = self.oldVerCodeTF.textColor = self.freshPhoneTF.textColor = MacoTitleColor;
    self.oldPhoneLabel.textColor = self.freshCodeLabel.textColor = self.freshPhoneLabel.textColor = self.oldVerCodeLabel.textColor =self.alerLabel.textColor= MacoDetailColor;


    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callCustomerService)];
    [self.alerLabel addGestureRecognizer:tap];
    self.alerLabel.userInteractionEnabled = YES;
    
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:@"如果原手机号已停用或者无法收到验证码，请联系客服"];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:@"联系客服"];
    [hintString addAttribute:NSForegroundColorAttributeName value:MacoColor range:range1];
    self.alerLabel.attributedText=hintString;
    
}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
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

- (IBAction)sendOldCodeBtn:(id)sender {
}
- (IBAction)sendNewCodeBtn:(id)sender {
}



- (void)callCustomerService{

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"1008611"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
@end
