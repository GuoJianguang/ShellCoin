//
//  EditbankInfoTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "EditbankInfoTableViewCell.h"
#import "BankPickView.h"
#import "BankCardInfoModel.h"


@interface EditbankInfoTableViewCell()<BankPickViewDelegate,UITextFieldDelegate>

@property (copy,nonatomic)NSString *tempBankName;
@property (copy,nonatomic)NSString *tempProName;
@property (copy,nonatomic)NSString *tempKaihuwangdianName;
@property (copy,nonatomic)NSString *tempkaihuhangName;


@property (strong, nonatomic) BankPickView *cityPicker;
@property (strong, nonatomic)BankPickView *bankPicker;
@property (strong, nonatomic)BankPickView *wangdianPicker;
@property (strong, nonatomic)BankPickView *kaihuhangPicker;


@property (copy,nonatomic)NSString *bank_id;

@end

@implementation EditbankInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.upViewHeight.constant = (TWitdh-30)*(12/65.)*6 + 20 + 6*8;
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];
    [self setLayerWithbor:self.view5];
    [self setLayerWithbor:self.view6];
    [self setLayerWithbor:self.view7];
    [self setLayerWithbor:self.view8];
    
    self.provincesTF.delegate = self;
    self.bankLabel.delegate = self;
    self.kaihuhangTF.delegate = self;
    self.kaihuhangNumdTF.delegate = self;
    self.wangdianTF.delegate = self;
    self.inputKaihuhangTF.delegate = self;
    
    self.cityPicker.isAddressPicker = YES;
    self.provincesTF.inputView = self.cityPicker;
    self.bankPicker.isAddressPicker = NO;
    self.bankLabel.inputView = self.bankPicker;
    self.wangdianTF.inputView = self.wangdianPicker;
    self.kaihuhangTF.inputView = self.kaihuhangPicker;
    
    self.tempProName = self.cityPicker.dataSouceArray[0][@"bankName"];
    self.tempBankName = @"";
    self.tempBankName = @"";
    self.bankCardNu.delegate = self;
    self.bank_id = @"";

    self.view7.hidden = YES;
    self.top8Height.constant = 8;
    
    self.nameTF.text = [ShellCoinUserInfo shareUserInfos].idcardName;
    self.nameTF.enabled = NO;

}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setBankModel:(BankCardInfoModel *)bankModel
{
    _bankModel = bankModel;
    self.bank_id = _bankModel.bankId;
    NSString *shengName = [NullToSpace(_bankModel.bankAccountPro) stringByReplacingOccurrencesOfString:@"省" withString:@""];
    shengName = [shengName stringByReplacingOccurrencesOfString:@"市" withString:@""];
    
    NSString *bankName = NullToSpace(_bankModel.bankName);
    if (![bankName isEqualToString:@"中国银行"]) {
        bankName = [bankName stringByReplacingOccurrencesOfString:@"中国" withString:@""];
    }
    if ([bankName isEqualToString:@"中国邮政储蓄银行"] || [bankName isEqualToString:@"邮政储蓄银行"]||[bankName isEqualToString:@"中国邮政储蓄"]||[bankName isEqualToString:@"邮政储蓄"]) {
        bankName =  @"邮储银行";
    }
    
    self.bankLabel.text = bankName;
    self.bankCardNu.text = [self normalNumToBankNum: _bankModel.bankAccount];
    self.provincesTF.text = _bankModel.bankAccountPro;
    self.nameTF.text = _bankModel.realName;
    self.kaihuhangNumdTF.text = _bankModel.bankBranchNo;
    self.kaihuhangTF.text  =_bankModel.bankPointBranch;
    self.wangdianTF.text = _bankModel.bankPoint;
    if ([self.wangdianTF.text isEqualToString:@""]) {
        self.inputKaihuhangTF.text = _bankModel.bankBranch;
        self.selcetZHNumBtn.selected = YES;
        self.upViewHeight.constant = (TWitdh-30)*(12/65.)*4 + 20 + 5*8;
        self.view6.hidden = self.view5.hidden = YES;
        self.view7.hidden  = NO;
        self.top8Height.constant = 8 + (TWitdh-30)*(12/65.) + 8;
    }else{
        self.upViewHeight.constant = (TWitdh-30)*(12/65.)*6 + 20 + 5*8;
        self.view6.hidden = self.view5.hidden = NO;
        self.selcetZHNumBtn.selected = NO;
        self.view7.hidden = YES;
        self.top8Height.constant = 8;
    }
}

- (NSString *)normalNumToBankNum:(NSString *)num
{
    if (num.length < 7) {
        return num;
    }
    NSNumber *number = @([num longLongValue]);
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setGroupingSize:4];
    [formatter setGroupingSeparator:@" "];
    return [formatter stringFromNumber:number];
}

#pragma mark - 是否手动输入

- (IBAction)selcetZHNumBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.upViewHeight.constant = (TWitdh-30)*(12/65.)*4 + 20 + 5*8;
        self.view6.hidden = self.view5.hidden = YES;
        self.view7.hidden  = NO;
        self.top8Height.constant = 8 + (TWitdh-30)*(12/65.) + 8;

    }else{
        self.upViewHeight.constant = (TWitdh-30)*(12/65.)*6 + 20 + 5*8;
        self.view6.hidden = self.view5.hidden = NO;
        self.view7.hidden = YES;
        self.top8Height.constant = 8;
    }
}




#pragma mark - 懒加载
- (NSString *)tempBankName
{
    if (!_tempBankName) {
        _tempBankName = [NSString string];
    }
    return _tempBankName;
}


- (NSString *)tempkaihuhangName
{
    if (!_tempkaihuhangName) {
        _tempkaihuhangName = [NSString string];
    }
    return _tempkaihuhangName;
}

- (NSString *)tempKaihuwangdianName
{
    if (!_tempKaihuwangdianName) {
        _tempKaihuwangdianName = [NSString string];
    }
    return _tempKaihuwangdianName;
}

- (NSString *)tempProName
{
    if (!_tempProName) {
        _tempProName   = [NSString string];
    }
    return _tempProName;
}


#pragma mark - BankPickerView

- (BankPickView *)bankPicker
{
    if (!_bankPicker) {
        _bankPicker = [[BankPickView alloc]init];
        _bankPicker.isAddressPicker = NO;
        _bankPicker.bankdelegate = self;
    }
    return _bankPicker;
}

- (BankPickView *)cityPicker
{
    if (!_cityPicker)
    {   _cityPicker.isAddressPicker = YES;
        _cityPicker = [[BankPickView alloc] init];
        _cityPicker.bankdelegate = self;
    }
    return _cityPicker;
}

- (BankPickView *)wangdianPicker
{
    if (!_wangdianPicker) {
        _wangdianPicker = [[BankPickView alloc]init];
        _wangdianPicker.bankdelegate = self;
    }
    return _wangdianPicker;
}

- (BankPickView *)kaihuhangPicker
{
    if (!_kaihuhangPicker) {
        _kaihuhangPicker = [[BankPickView alloc]init];
        _kaihuhangPicker.bankdelegate = self;
    }
    return _kaihuhangPicker;
    
}


- (void)bankPickerView:(BankPickView *)picker finishPickbankName:(NSString *)bankName bankId:(NSString *)bankId
{
    
    if (picker == self.bankPicker) {
        self.kaihuhangTF.text = @"";
        self.wangdianTF.text = @"";
        self.bank_id = bankId;
        self.bankLabel.text = bankName;
        self.tempBankName = bankName;
    }else if(picker == self.cityPicker){
        self.kaihuhangTF.text = @"";
        self.wangdianTF.text = @"";
        self.provincesTF.text = bankName;
        self.tempProName = bankName;
    }else if (picker == self.wangdianPicker){
        self.kaihuhangTF.text = @"";
        self.wangdianTF.text = bankName;
        self.tempKaihuwangdianName = bankName;
    }else if (picker == self.kaihuhangPicker){
        self.kaihuhangTF.text = bankName;
        self.tempkaihuhangName = bankName;
    }
}

#pragma mark - 获取所有银行卡
- (void)getAllBankRequest
{
    [HttpClient POST:@"user/banks/get" parameters:nil success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = jsonObject[@"data"];
            NSMutableArray *datasoucearray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                NSDictionary *iteDic =  @{@"bankId":NullToNumber(dic[@"id"]),@"bankName":NullToSpace(dic[@"bankName"])};
                [datasoucearray addObject:iteDic];
            }
            self.bankPicker.dataSouceArray = datasoucearray;
            self.tempBankName = datasoucearray[0][@"bankName"];
            self.bank_id = datasoucearray[0][@"bankId"];
            self.bankPicker.isAddressPicker = NO;
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时获取不到银行信息" duration:2.0];
        [self.wangdianTF resignFirstResponder];
    }];
}

#pragma mark - 获取银行网点支行的网络请求
- (void)getBankPointRequest
{
    NSDictionary *parms = @{@"bank":NullToSpace(self.bankLabel.text),
                            @"province":NullToSpace(self.provincesTF.text)};
    [HttpClient POST:@"user/withdraw/bindBankcard/getBankPoint" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = jsonObject[@"data"][@"points"];
            NSMutableArray *datasoucearray = [NSMutableArray array];
            for (NSString *str in array) {
                NSDictionary *iteDic =  @{@"bankId":@"0",@"bankName":str};
                [datasoucearray addObject:iteDic];
            }
            self.tempkaihuhangName = @"";
            if (datasoucearray.count >0) {
                self.tempKaihuwangdianName = NullToSpace(datasoucearray[0][@"bankName"]);
            }
            
            self.wangdianPicker.wangdianArray = datasoucearray;
            //            if (datasoucearray.count == 0) {
            //                [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时没有找到相关开户网点" duration:2.0];
            ////                [self.wangdianTF resignFirstResponder];
            //                return ;
            //            }
            
            //            [self.wangdianTF becomeFirstResponder];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时没有找到相关开户网点" duration:2.0];
        [self.wangdianTF resignFirstResponder];
    }];
}

#pragma mark - 获取支行的网络请求
- (void)getBankRequest
{
    NSDictionary *parms = @{@"bank":NullToSpace(self.bankLabel.text),
                            @"province":NullToSpace(self.provincesTF.text),
                            @"point":NullToSpace(self.wangdianTF.text)};
    
    [HttpClient POST:@"user/withdraw/bindBankcard/getBankPoint" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            NSArray *array = jsonObject[@"data"][@"childs"];
            NSMutableArray *datasoucearray = [NSMutableArray array];
            for (NSString *str in array) {
                NSDictionary *iteDic =  @{@"bankId":@"0",@"bankName":str};
                [datasoucearray addObject:iteDic];
            }
            self.tempkaihuhangName = @"";
            
            if (datasoucearray.count >0) {
                self.tempkaihuhangName = NullToSpace(datasoucearray[0][@"bankName"]);
            }
            self.kaihuhangPicker.wangdianArray = datasoucearray;
            if (datasoucearray.count == 0) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时没有找到相关开户行" duration:2.0];
                //                [self.kaihuhangTF resignFirstResponder];
                return ;
            }
            //                        [self.kaihuhangTF becomeFirstResponder];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"抱歉,暂时没有找到相关开户行" duration:2.0];
        [self.kaihuhangTF resignFirstResponder];
    }];
}


#pragma mark - UItextFileDelegate

//字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.bankCardNu == textField || self.kaihuhangNumdTF == textField) {
        //格式化银行卡号
        NSString *text = [textField text];
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound)
        {
            return NO;
        }
        text = [text stringByReplacingCharactersInRange:range withString:string];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0)
        {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4)
            {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        
        if (textField == self.kaihuhangNumdTF && newString.length >=16) {
            [textField resignFirstResponder];
            return NO;
        }
        
        if (newString.length >= 24)
        {
            [textField resignFirstResponder];
            return NO;
        }
        [textField setText:newString];
        return NO;
    }

    if (textField == self.kaihuhangTF ) {
        if (self.kaihuhangTF.text.length >49 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    if (textField == self.kaihuhangNumdTF ) {
        if (self.kaihuhangNumdTF.text.length >49 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    if (textField == self.inputKaihuhangTF ) {
        if (self.inputKaihuhangTF.text.length >49 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.bankLabel) {
        self.tempkaihuhangName = @"";
        self.tempKaihuwangdianName = @"";
        self.kaihuhangTF.text = @"";
        self.wangdianTF.text = @"";
        [self getAllBankRequest];
    }
    if (textField == self.wangdianTF) {
        self.kaihuhangTF.text = @"";
        self.tempkaihuhangName = @"";
        if ([self emptyTextOfTextField:self.provincesTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
            [self.wangdianTF resignFirstResponder];
            return;
        }else if ([self emptyTextOfTextField:self.bankLabel]){
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
            [self.wangdianTF resignFirstResponder];
            return;
        }
        [self getBankPointRequest];
    }
    
    if (textField == self.kaihuhangTF) {
        self.tempKaihuwangdianName = @"";
        if ([self emptyTextOfTextField:self.provincesTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
            [self.kaihuhangTF resignFirstResponder];
            return;
        }else if ([self emptyTextOfTextField:self.bankLabel]){
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户地" duration:1.5];
            [self.kaihuhangTF resignFirstResponder];
            return;
        }else if ([self emptyTextOfTextField:self.wangdianTF]){
            [[JAlertViewHelper shareAlterHelper]showTint:@"请先选择开户网点" duration:1.5];
            [self.kaihuhangTF resignFirstResponder];
            return;
        }
        [self getBankRequest];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.provincesTF) {
        [self.provincesTF setText:[NSString stringWithFormat:@"%@",self.tempProName]];
    }
    if (textField == self.bankLabel) {
        [self.bankLabel setText:[NSString stringWithFormat:@"%@",self.tempBankName]];
    }
    if (textField == self.kaihuhangTF) {
        [self.kaihuhangTF setText:[NSString stringWithFormat:@"%@",self.tempkaihuhangName]];
    }
    if (textField == self.wangdianTF) {
        [self.wangdianTF setText:[NSString stringWithFormat:@"%@",self.tempKaihuwangdianName]];
    }
}


-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}


#pragma mark - 确认提交
- (void)sureEdit
{
    
    if ([self valueValidated]) {
        NSString *bankNum = [self.bankCardNu.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *kaihuhNum = [self.kaihuhangNumdTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (self.selcetZHNumBtn.selected) {
            self.wangdianTF.text = @"";
            self.kaihuhangTF.text = @"";
        }else{
            self.inputKaihuhangTF.text = @"";
        }
        NSDictionary *parms = @{@"bankId":self.bank_id,
                                @"bankAccount":bankNum,
                                @"identity":@"",
                                @"bankPhone":@"",
                                @"realName":self.nameTF.text,
                                @"bankAccountPro":self.provincesTF.text,
                                @"token":[ShellCoinUserInfo shareUserInfos].token,
                                @"bankPoint":NullToSpace(self.wangdianTF.text),
                                @"bankPointBranch":NullToSpace(self.kaihuhangTF.text),
                                @"bankBranch":NullToSpace(self.inputKaihuhangTF.text),
                                @"bankBranchNo":NullToSpace(kaihuhNum)};
        [SVProgressHUD showWithStatus:@"正在提交..." maskType:SVProgressHUDMaskTypeBlack];
        
        [HttpClient POST:@"user/withdraw/bindBankcard/add" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            [SVProgressHUD dismiss];
            if (IsRequestTrue) {
//                [ShellCoinUserInfo shareUserInfos].bankname= self.bank_id;
                
                [[JAlertViewHelper shareAlterHelper]showTint:@"绑定成功" duration:1.5];
                [ShellCoinUserInfo shareUserInfos].bindingFlag = YES;
                [ShellCoinUserInfo shareUserInfos].bankAccount = bankNum;
                [ShellCoinUserInfo shareUserInfos].bankAccountRealName = self.nameTF.text;
                [ShellCoinUserInfo shareUserInfos].bindingFlag = @"1";
//                [self.viewController.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [SVProgressHUD dismiss];
            
        }];
    }
    
}

-(BOOL) valueValidated {
    
    NSString *kaihuhNum = [self.kaihuhangNumdTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.bankCardNu]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入银行卡号" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.provincesTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择开户地址" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.bankLabel]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择发卡银行" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.nameTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入持卡人姓名" duration:1.];
        return NO;
    }else if (kaihuhNum.length !=0 && kaihuhNum.length !=12){
        [[JAlertViewHelper shareAlterHelper]showTint:@"您输入的开户行号只能是12位的数字" duration:1.];
        return NO;
    }
    //    if (![self.bank_id isEqualToString:@"2"]) {
    //        [[JAlertViewHelper shareAlterHelper]showTint:@"您只能绑定农业银行的银行卡" duration:1.5];
    //        return NO;
    //    }
    if (!self.selcetZHNumBtn.selected) {
        if ([self emptyTextOfTextField:self.wangdianTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请选择开户网点" duration:1.];
            return NO;
        }else if ([self emptyTextOfTextField:self.kaihuhangTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请输入开户银行" duration:1.];
            return NO;
        }
        else if ([self emptyTextOfTextField:self.wangdianTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请选择开户网点" duration:1.];
            return NO;
        }
    }else{
        if ([self emptyTextOfTextField:self.inputKaihuhangTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请手动输入对应支行" duration:1.];
            return NO;
        }
    }
    
    return YES;
}

@end
