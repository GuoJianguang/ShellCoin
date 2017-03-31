//
//  EditPhoneNumberViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "EditPhoneNumberViewController.h"

@interface EditPhoneNumberViewController ()<BasenavigationDelegate>
@property (nonatomic,strong) NSTimer *timer1;
@property (nonatomic,strong) NSTimer *timer2;

@end

@implementation EditPhoneNumberViewController

{
    int timeLefted1;
    int timeLefted2;
    
}

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
    timeLefted1 = 60;
    timeLefted2 = 60;
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
    
    
    self.naviBar.delegate = self;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_confirm"];
    self.naviBar.hiddenDetailBtn = NO;
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



- (IBAction)sendOldCodeBtn:(UIButton *)sender {
    sender.enabled = NO;

    NSDictionary *parms = @{@"oldPhone":self.oldPhoneTF.text};
    [HttpClient POST:@"sms/sendModifyPhoneCode/old" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.sendOldCodeBtn setTitle:@"重新获取(60)" forState:UIControlStateNormal];
            [self.sendOldCodeBtn setTitleColor:MacoIntrodouceColor forState:UIControlStateNormal];
            self.sendOldCodeBtn.enabled = NO;
            self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(oldTimeLeft:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:self.timer1 forMode:NSRunLoopCommonModes];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        sender.enabled = YES;

    }];
}


#pragma mark - 验证码计时器
//static int timeLefted = 60;
-(void) oldTimeLeft:(NSTimer*) timer {
    
    timeLefted1--;
    if (timeLefted1 == 0) {
        [self oldverifyButtonNormal];
        return;
    }
    NSString *title = [NSString stringWithFormat:@"重新获取(%d)",timeLefted1];
    self.sendOldCodeBtn.titleLabel.text = title;
    [self.sendOldCodeBtn setTitle:title forState:UIControlStateNormal];
    
}

-(void) newTimeLeft:(NSTimer*) timer {
    
    timeLefted2--;
    if (timeLefted2 == 0) {
        [self newverifyButtonNormal];
        return;
    }
    NSString *title = [NSString stringWithFormat:@"重新获取(%d)",timeLefted2];
    self.sendNewCodeBtn.titleLabel.text = title;
    [self.sendNewCodeBtn setTitle:title forState:UIControlStateNormal];
}

-(void) oldverifyButtonNormal {
    [self.timer1 invalidate];
    timeLefted1 = 60;
    self.sendOldCodeBtn.layer.borderColor = MacoColor.CGColor;
    [self.sendOldCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.sendOldCodeBtn.enabled = YES;
}

-(void) newverifyButtonNormal {
    [self.timer2 invalidate];
    timeLefted2 = 60;
    self.sendNewCodeBtn.layer.borderColor = MacoColor.CGColor;
    [self.sendNewCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.sendNewCodeBtn.enabled = YES;
}


- (IBAction)sendNewCodeBtn:(UIButton *)sender {
    if ([self emptyTextOfTextField:self.oldPhoneTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入旧的手机号" duration:2.];
        return;
    }else if ([self emptyTextOfTextField:self.oldVerCodeTF]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入旧手机收到的验证码" duration:2.];
        return;
    }else if ([self emptyTextOfTextField:self.freshPhoneTF]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入新手机号码" duration:2.];
        return;
    }
    sender.enabled = NO;
    NSDictionary *parms = @{@"oldPhone":self.oldPhoneTF.text,
                            @"newPhone":self.freshPhoneTF.text,
                            @"oldVerifyCode":self.freshCodeTF.text};
    [HttpClient POST:@"sms/sendModifyPhoneCode/new" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.sendNewCodeBtn setTitle:@"重新获取(60)" forState:UIControlStateNormal];
            [self.sendNewCodeBtn setTitleColor:MacoIntrodouceColor forState:UIControlStateNormal];
            self.sendNewCodeBtn.enabled = NO;
            self.timer2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(newTimeLeft:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:self.timer2 forMode:NSRunLoopCommonModes];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        sender.enabled = YES;
        
    }];
    
}

- (void)callCustomerService{

    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"1008611"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}


-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}

- (void)detailBtnClick
{
    [self.freshPhoneTF resignFirstResponder];
    [self.freshCodeTF resignFirstResponder];
    [self.oldVerCodeTF resignFirstResponder];
    [self.oldPhoneTF resignFirstResponder];
    if ([self emptyTextOfTextField:self.freshPhoneTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入新手机号" duration:2.];
        return;
    }else if ([self emptyTextOfTextField:self.freshCodeTF]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入新手机收到的验证码" duration:2.];
        return;
    }
    
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"newPhone":self.freshPhoneTF.text,
                            @"newVerifyCode":self.freshCodeTF.text};
    [SVProgressHUD showWithStatus:@"正在提交请求..."];

    [HttpClient POST:@"user/phone/update" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"修改成功" duration:1.5];
            [ShellCoinUserInfo shareUserInfos].phone = self.freshPhoneTF.text;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

@end
