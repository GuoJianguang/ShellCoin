//
//  WithdrawalViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "SelectBanCardView.h"
#import "SureTradInView.h"
#import "SetPayPasswordViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface WithdrawalViewController ()<UITextFieldDelegate,PayViewDelegate>
@property (nonatomic, strong)SelectBanCardView *selectBancardView;
@property (nonatomic, strong)SureTradInView *passwordView;

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
    self.alerputInLabel.textColor = self.poundageLabel.textColor = MacoColor;
    self.bankLabel.textColor = MacoTitleColor;
    self.bankCardNumLabel.textColor = [UIColor colorFromHexString:@"#969696"];
    self.inputAmountTF.delegate = self;
    self.canWithDrawLabel.adjustsFontSizeToFitWidth = YES;
    self.canWithDrawLabel.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getmyBankCardRequest];
}

- (SureTradInView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[SureTradInView alloc]init];
        _passwordView.delegate = self;
    }
    return _passwordView;
}


- (SelectBanCardView *)selectBancardView
{
    if (!_selectBancardView) {
        _selectBancardView = [[SelectBanCardView alloc]init];
    }
    return _selectBancardView;
}

- (IBAction)sureBtn:(UIButton *)sender
{
    sender.enabled = NO;
    if ([[ShellCoinUserInfo shareUserInfos].payPassword isEqualToString:@""]) {
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"抵换之前请先设置您的支付密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            SetPayPasswordViewController *setPayPasswordVC = [[SetPayPasswordViewController alloc]init];
            [self.navigationController pushViewController:setPayPasswordVC animated:YES];
            
        }];
        sender.enabled = YES;
        [alertcontroller addAction:cancelAction];
        [alertcontroller addAction:otherAction];
        [self presentViewController:alertcontroller animated:YES completion:NULL];
        return;
    }
    
    [self.inputAmountTF resignFirstResponder];
    
if ([self valueValidated]) {
    if ([ShellCoinUserInfo shareUserInfos].payPwdFlag) {
        LAContext * con = [[LAContext alloc]init];
        NSError * error;
        //判断是否支持密码验证
        /**
         *LAPolicyDeviceOwnerAuthentication 手机密码的验证方式
         *LAPolicyDeviceOwnerAuthenticationWithBiometrics 指纹的验证方式
         */
        [con evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"验证信息" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                        @"withdrawAmount":self.inputAmountTF.text,
                                        @"id":self.bankModel.bankinfoid,
                                        @"password":[ShellCoinUserInfo shareUserInfos].payPassword};
                [SVProgressHUD showWithStatus:@"正在提交申请"];
                [HttpClient POST:@"user/withdraw/add" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                    sender.enabled = YES;
                    [SVProgressHUD dismiss];
                    sender.enabled = YES;
                    if (IsRequestTrue) {
                        [self withDrawalSuccess];
                        //            NSDictionary *dic = @{@"money":self.editMoneyTF.text};
                        //            self.successView.infoDic = dic;
                        //            [self withDrawalSuccess];
                    }
                } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    sender.enabled = YES;
                    [SVProgressHUD dismiss];
                }];
                return;
            }
            UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消指纹验证或者验证失败，请用使用支付密码发起抵换请求" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self goinputPassword];
            }];
            sender.enabled = YES;
            [alertcontroller addAction:cancelAction];
            [alertcontroller addAction:otherAction];
            [self presentViewController:alertcontroller animated:YES completion:NULL];
        }];
        return;
    }
    
    [self goinputPassword];

    }
    sender.enabled = YES;
}


- (void)goinputPassword
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"withdrawAmount":self.inputAmountTF.text,
                            @"id":self.bankModel.bankinfoid};
    [self.view addSubview:self.passwordView];
    self.passwordView.passwordTF.text = @"";
    self.passwordView.mallOrderParms = [NSMutableDictionary dictionaryWithDictionary:parms];
    self.passwordView.inputType = Password_type_withdraw;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.passwordView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.passwordView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
    }];
}

#pragma mark - 限制抵换资格
-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.inputAmountTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入抵换金额" duration:1.];
        return NO;
    }else if ([self.canWithDrawLabel.text doubleValue] < [self.inputAmountTF.text doubleValue]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的可抵换余额不足，请重新输入" duration:1.5];
        return NO;
    }else if ([self.inputAmountTF.text integerValue]%10 !=0){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的抵换金额必须是10的整数倍" duration:1.5];
        return NO;
    }else if ([self.inputAmountTF.text integerValue] <100){
            [[JAlertViewHelper shareAlterHelper]showTint:@"您的抵换金额不能小于100" duration:1.5];
            return NO;
        }
    
    
//    else if (([self.inputAmountTF.text integerValue] <100 || [self.inputAmountTF.text integerValue] >1000) &&![[ShellCoinUserInfo shareUserInfos].grade isEqualToString:@"10"]){
//        [[JAlertViewHelper shareAlterHelper]showTint:@"您的抵换金额不能小于100，并且不能超过1000" duration:1.5];
//        return NO;
//    }
    return YES;
}
-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
}

- (IBAction)backBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)selcetBankCardBtn:(UIButton *)sender
{
    [self.view addSubview:self.selectBancardView];
    self.selectBancardView.bankInfModel = self.bankModel;
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.selectBancardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.selectBancardView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.selectBancardView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
    }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.inputAmountTF) {
        NSScanner      *scanner    = [NSScanner scannerWithString:string];
        NSCharacterSet *numbers;
        NSRange         pointRange = [textField.text rangeOfString:@"."];
        
        if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        else
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        
        if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] )
        {
            return NO;
        }
        
        short remain = 2; //默认保留2位小数
        
        NSString *tempStr = [textField.text stringByAppendingString:string];
        NSUInteger strlen = [tempStr length];
        if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
            if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
                return NO;
            }
            if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
                return NO;
            }
        }
        
        NSRange zeroRange = [textField.text rangeOfString:@"0"];
        if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
            if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
                textField.text = string;
                return NO;
            }else{
                if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                    if([string isEqualToString:@"0"]){
                        return NO;
                    }
                }
            }
        }
        NSString *buffer;
        if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) )
        {
            return NO;
        }
    }
    return YES;
}

- (void)setBankModel:(BankCardInfoModel *)bankModel
{
    _bankModel = bankModel;
    
    self.bankLabel.text = _bankModel.bankName;
    NSString *count = [_bankModel.bankAccount substringFromIndex:_bankModel.bankAccount.length-4];
    self.bankCardNumLabel.text = [NSString stringWithFormat:@"(%@)",count];
    self.poundageLabel.text = _bankModel.withdrawRateDesc;
}


#pragma mark - 获取我的所有银行卡

- (void)getmyBankCardRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"user/withdraw/bindBankcard/get" parameters:@{@"token":[ShellCoinUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            [self.selectBancardView.dataSouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"];
            for (NSDictionary *dic in array) {
                BankCardInfoModel *model = [BankCardInfoModel modelWithDic:dic];
                if ([model.state isEqualToString:@"1"]) {
                    self.bankModel = model;
                    model.isSeclet = YES;
                }
                [self.selectBancardView.dataSouceArray addObject:model];
            }
            if (!self.bankModel) {
                self.bankModel = self.selectBancardView.dataSouceArray[0];
            }
            
            [self.selectBancardView.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (WithDrawalResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[WithDrawalResultView alloc]init];
    }
    return _resultView;
}

- (void)withDrawalSuccess
{
    self.naviBar.hiddenDetailBtn = YES;
    [self.view addSubview:self.resultView];
    self.naviBar.title = @"抵换成功";
    self.resultView.autResultLabel.text =[NSString stringWithFormat:@"¥ %@",self.inputAmountTF.text];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}


- (void)paysuccess:(NSString *)payWay
{
    self.naviBar.hiddenDetailBtn = YES;
    [self.view addSubview:self.resultView];
    self.resultView.autResultLabel.text =[NSString stringWithFormat:@"¥ %@",payWay];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}

@end
