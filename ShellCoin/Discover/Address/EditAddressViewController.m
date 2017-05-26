//
//  EditAddressViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "EditAddressViewController.h"
#import "PSCityPickerView.h"

@interface EditAddressViewController ()<BasenavigationDelegate,UITextFieldDelegate,UIAlertViewDelegate,PSCityPickerViewDelegate>
@property (strong, nonatomic) PSCityPickerView *cityPicker;
//省
@property (nonatomic, strong)NSString *proStr;
//市
@property (nonatomic, strong)NSString *shiStr;

//区
@property (nonatomic, strong)NSString *quStr;
@end

@implementation EditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"编辑收获地址";
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_delete_white"];
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;
    self.label1.textColor = self.label2.textColor =  self.label3.textColor=self.label4.textColor=self.label5.textColor=MacoTitleColor;
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];
    [self setLayerWithbor:self.view5];
    if (self.isAddAddress) {
        self.naviBar.hiddenDetailBtn = YES;
        self.naviBar.title = @"增加收货地址";
        self.naviBar.hiddenDetailBtn = YES;
        self.proStr = @"北京市";
        self.shiStr = @"北京市";
        self.quStr = @"东城区";
    }
    self.provincesTF.inputView = self.cityPicker;
    self.detailAddressTF.delegate = self;
    self.shippingPersonTF.delegate = self;
    self.provincesTF.delegate = self;
    self.phoneTF.delegate = self;
    self.ZipCodeTF.delegate = self;
    if (self.addressModel) {
        self.shippingPersonTF.text = self.addressModel.name;
        self.detailAddressTF.text = self.addressModel.address;
        self.provincesTF.text = [NSString stringWithFormat:@"%@ %@ %@",self.addressModel.province,self.addressModel.city,self.addressModel.zone];
        
        self.ZipCodeTF.text = self.addressModel.zipCode;
        self.phoneTF.text = self.addressModel.phone;
        
        self.proStr = self.addressModel.province;
        self.shiStr = self.addressModel.city;
        self.quStr = self.addressModel.zone;
    }
}

- (void)detailBtnClick
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确认要删除收货地址吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                @"id":self.addressModel.addressId};
        [HttpClient POST:@"user/userInfo/address/delete" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"地址删除成功" duration:1.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"网路请求失败，请重试" duration:2.];
        }];
        
    }];
    [alertcontroller addAction:cancelAction];
    [alertcontroller addAction:sureAction];
    
    [self presentViewController:alertcontroller animated:YES completion:NULL];
}

- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}


- (PSCityPickerView *)cityPicker
{
    if (!_cityPicker)
    {
        _cityPicker = [[PSCityPickerView alloc] init];
        _cityPicker.cityPickerDelegate = self;
    }
    return _cityPicker;
}
#pragma mark - PSCityPickerViewDelegate
- (void)cityPickerView:(PSCityPickerView *)picker
    finishPickProvince:(NSString *)province
                  city:(NSString *)city
              district:(NSString *)district
{
    self.proStr = province;
    self.shiStr = city;
    self.quStr = district;
    [self.provincesTF setText:[NSString stringWithFormat:@"%@ %@ %@",province,city,district]];
}

- (IBAction)sure_btn:(id)sender
{
    self.shippingPersonTF.text =  [self.shippingPersonTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.detailAddressTF.text = [self.detailAddressTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if (![self valueValidated]) {
        return;
    }
    
    //添加地址
    if (self.isAddAddress) {
        NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                                @"name":self.shippingPersonTF.text,
                                @"province":NullToSpace(self.proStr),
                                @"city":NullToSpace(self.shiStr),
                                @"zone":NullToSpace(self.quStr),
                                @"address":self.detailAddressTF.text,
                                @"phone":self.phoneTF.text,
                                @"zipCode":self.ZipCodeTF.text,
                                @"defaultFlag":@"",
                                };
        
        [HttpClient POST:@"user/userInfo/address/add" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
            if (IsRequestTrue) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"地址添加成功" duration:1.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            
        }];
        
        return;
    }
    //修改地址
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"name":self.shippingPersonTF.text,
                            @"province":NullToSpace(self.proStr),
                            @"city":NullToSpace(self.shiStr),
                            @"zone":NullToSpace(self.quStr),
                            @"address":self.detailAddressTF.text,
                            @"phone":self.phoneTF.text,
                            @"defaultFlag":self.addressModel.defaultFlag,
                            @"zipCode":self.ZipCodeTF.text,
                            @"id":self.addressModel.addressId};
    [HttpClient POST:@"user/userInfo/address/update" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"地址修改成功" duration:1.5];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}

-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.shippingPersonTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入收件人姓名" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.provincesTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择省市区" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.detailAddressTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入详细地址" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.ZipCodeTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入邮编" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.phoneTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入电话号码" duration:1.];
        return NO;
    }
    
    Verify *ver = [[Verify alloc]init];
    BOOL isture = [ver verifyPhoneNumber:self.phoneTF.text];
    if (!isture) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"您的电话号码格式不正确" duration:1.];
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

#pragma mark - UItextFileDelegate

//字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.shippingPersonTF) {
        if (self.shippingPersonTF.text.length >10 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    
    if (textField == self.detailAddressTF) {
        if (self.detailAddressTF.text.length >100 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    
    if (textField == self.phoneTF) {
        if (self.phoneTF.text.length >10 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    if (textField == self.ZipCodeTF) {
        if (textField.text.length>5 && ![string isEqualToString:@""]) {
            return NO;
        }
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.provincesTF) {
        [self.provincesTF setText:[NSString stringWithFormat:@"%@ %@ %@",self.proStr,self.shiStr,self.quStr]];
    }
}

- (IBAction)selectProBtn:(UIButton *)sender {
    [self.provincesTF becomeFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
