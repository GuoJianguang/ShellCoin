//
//  ChangePayPasswordViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ChangePayPasswordViewController.h"

@interface ChangePayPasswordViewController ()<BasenavigationDelegate>

@end

@implementation ChangePayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"重置支付密码";
    self.naviBar.delegate = self;
    self.naviBar.detailTitle = @"提交";
    self.naviBar.hiddenDetailBtn = NO;
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];

    [self.verCodeBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    self.phoneTF.textColor = self.xinPayTF.textColor = self.verCodeTF.textColor = self.sureNewPayTF.textColor = self.fingerCodeLabel.textColor =MacoTitleColor;
    self.phoneLabel.textColor = self.xinPayLabel.textColor = self.verCodeLabel.textColor = self.sureNewPayLabel.textColor= MacoDetailColor;
}

- (void)detailBtnClick
{
    
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

- (IBAction)verCodeBtn:(UIButton *)sender {
}
- (IBAction)finggerCodeSwitch:(UISwitch *)sender {
}
@end
