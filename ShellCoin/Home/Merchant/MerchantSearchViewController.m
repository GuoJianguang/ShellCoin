//
//  MerchantSearchViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MerchantSearchViewController.h"
#import "MerchantSearchRsultViewController.h"

@interface MerchantSearchViewController ()<UITextFieldDelegate>

@end

@implementation MerchantSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.searchView.layer.cornerRadius = 36/2.;
    self.searchView.layer.masksToBounds = YES;
    self.textFied.delegate = self;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    MerchantSearchRsultViewController *resultVC = [[MerchantSearchRsultViewController alloc]init];
    resultVC.currentIndustry = @"";
    resultVC.keyWord = textField.text;
    resultVC.currentCity = self.cityName;
    [self.navigationController pushViewController:resultVC animated:YES];
    return YES;
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

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)searchBtn:(UIButton *)sender {
    
    if ([self valueValidated]) {
        [self.textFied resignFirstResponder];
        MerchantSearchRsultViewController *resultVC = [[MerchantSearchRsultViewController alloc]init];
        resultVC.currentIndustry = @"";
        resultVC.keyWord = self.textFied.text;
        resultVC.currentCity = self.cityName;
        [self.navigationController pushViewController:resultVC animated:YES];
    }

}


-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.textFied]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入搜索关键字" duration:2.];
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
