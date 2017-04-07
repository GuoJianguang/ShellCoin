//
//  EnterInputMoneyView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "EnterInputMoneyView.h"
#import "OnlinePayViewController.h"

@interface EnterInputMoneyView()<UITextFieldDelegate>

@end
@implementation EnterInputMoneyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"EnterInputMoneyView" owner:nil options:nil][0];
        self.backgroundColor =[UIColor clearColor];
        [self sendSubviewToBack:self.backView];
        self.itemView.backgroundColor = [UIColor clearColor];
        self.backView.backgroundColor = [UIColor colorFromHexString:@"#ccd8e2"];
        self.canelBtn.layer.cornerRadius = 25.;
        self.canelBtn.layer.masksToBounds = YES;
        self.sureView.layer.masksToBounds = YES;
        self.alerLabel.textColor = MacoDetailColor;
        self.alerLabel.adjustsFontSizeToFitWidth = YES;
        self.moneyTF.textColor = MacoColor;
        self.sureView.layer.cornerRadius = 6;
        
        
        if (TWitdh > 320) {
            self.height.constant = (TWitdh - 100)*(57/65.);
        }else{
            self.height.constant = (TWitdh - 100)*(65/65.);
        }
        
        self.moneyTF.delegate = self;
    }
    return self;
}

#pragma mark - 现在输金额只能为数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSScanner      *scanner    = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers;
    NSRange         pointRange = [textField.text rangeOfString:@"."];
    
    if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
    {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
    else
    {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
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
    return YES;
}


- (IBAction)canelBtn:(UIButton *)sender {
    [self removeFromSuperview];
}
- (IBAction)sureBtn:(UIButton *)sender {
    
    if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
        //判断是否先登录
        UINavigationController *navc = [LoginViewController controller];
        [self.viewController presentViewController:navc animated:YES completion:NULL];
        return;
    }
    if ([self.moneyTF.text isEqualToString:@""] ||[self.moneyTF.text doubleValue] ==0) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入正确的金额" duration:2.];
        return;
    }
    if ([self valueValidated]) {
        OnlinePayViewController *payVC = [[OnlinePayViewController alloc]init];
        payVC.money = self.moneyTF.text;
        payVC.dataModel = self.dataModel;
        self.moneyTF.text = @"";
        [self.viewController.navigationController pushViewController:payVC animated:YES];
        [self removeFromSuperview];
    }
}

-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.moneyTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入支付金额" duration:1.];
        return NO;
    }
    return YES;
}

-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}

@end
