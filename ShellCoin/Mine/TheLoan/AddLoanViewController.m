//
//  AddLoanViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/4/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "AddLoanViewController.h"
#import "BankPickView.h"

@interface AddLoanViewController ()<BankPickViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) BankPickView *sortPicker;
@property (nonatomic, copy)NSString *sortId;
@property (nonatomic, copy)NSString *sortName;
@end

@implementation AddLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];

    self.label1.textColor = self.label2.textColor = self.label3.textColor = self.label4.textColor = MacoDetailColor;
    self.nameTF.textColor = self.phoneTF.textColor = self.addressTF.textColor = self.loanSortTF.textColor = MacoTitleColor;
    self.nameTF.text = [ShellCoinUserInfo shareUserInfos].idcardName;
    self.nameTF.enabled = NO;
    
    self.loanSortTF.inputView = self.sortPicker;

    self.loanSortTF.delegate = self;
    self.phoneTF.delegate = self;
    
    self.sortId = @"1";
    self.sortName = @"购房贷款";
    

    
}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}


- (BankPickView *)sortPicker
{
    if (!_sortPicker) {
        _sortPicker = [[BankPickView alloc]init];
        NSDictionary *dic1 = @{@"bankId":@"1",@"bankName":@"购房贷款"};
        NSDictionary *dic2 = @{@"bankId":@"2",@"bankName":@"购车贷款"};
        NSDictionary *dic3 = @{@"bankId":@"3",@"bankName":@"其他贷款"};
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[dic1,dic2,dic3]];
        _sortPicker.wangdianArray = array;
        _sortPicker.bankdelegate = self;
    }
    return _sortPicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)bankPickerView:(BankPickView *)picker finishPickbankName:(NSString *)bankName bankId:(NSString *)bankId
{
    self.loanSortTF.text = bankName;
    self.sortName = bankName;
    self.sortId = bankId;
}

- (IBAction)sureBtn:(UIButton *)sender {
    if ([self valueValidated]) {
        NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                @"name":self.nameTF.text,
                                @"address":self.addressTF.text,
                                @"phone":self.phoneTF.text,
                                @"type":self.sortId};
        [HttpClient POST:@"user/userLoan/add" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"提交申请成功" duration:2.];
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
        
    }
}

-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.phoneTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入电话号码" duration:2.];
        return NO;
    }else if ([self emptyTextOfTextField:self.loanSortTF]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择贷款类别" duration:1.5];
        return NO;
    }else if ([self emptyTextOfTextField:self.addressTF]){
        [[JAlertViewHelper shareAlterHelper]showTint:@"请填写地址" duration:1.5];
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
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.loanSortTF) {
        [self.loanSortTF setText:[NSString stringWithFormat:@"%@",self.sortName]];
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTF) {
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
    if (self.phoneTF == textField && textField.text.length > 10 && ![string isEqualToString:@""]) {
        return NO;
    }
    
       
    return YES;
}


@end
