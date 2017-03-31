//
//  RealNameAutResultView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RealNameAutResultView.h"
#import "ManualCertificationViewController.h"


@implementation RealNameAutResultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"RealNameAutResultView" owner:nil options:nil][0];
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autResultLabel.adjustsFontSizeToFitWidth = YES;
    self.autResultLabel.numberOfLines = 2;
    
}

- (IBAction)backBtn:(id)sender {
    
    switch (_isSuccess) {
        case Authentication_type_fail:
        {
            ManualCertificationViewController *manualVC = [[ManualCertificationViewController alloc]init];
            [self.viewController.navigationController pushViewController:manualVC animated:YES];
        }
            break;
        case Authentication_wait_audit:{
            [self.viewController.navigationController popToViewController:self.viewController.navigationController.viewControllers[1] animated:YES];
        }
            
            break;
        case Authentication_type_success:
        {
            [self.viewController.navigationController popViewControllerAnimated:YES];

        }
            break;
            
        default:
            break;
    }


}


- (void)setIsSuccess:(Authentication_type)isSuccess
{
    _isSuccess = isSuccess;
    switch (_isSuccess) {
        case Authentication_type_fail:
        {
            self.autResultTitleLabel.text = self.autResultTitleLabel.text = @"实名认证失败";
            self.titleimageView.image = [UIImage imageNamed:@"pic4_personal"];
            self.alerResultImageView.image = [UIImage imageNamed:@"pic5_personal"];
            [self.backBtn setBackgroundImage:[UIImage imageNamed:@"pic6_personal"] forState:UIControlStateNormal];
            [self.backBtn setTitle:@"手动认证" forState:UIControlStateNormal];
            self.autResultLabel.text = @"填写身份证信息错误，请选择手动实名认证";
        }
            break;
        case Authentication_wait_audit:{
            self.autResultTitleLabel.text = self.autResultTitleLabel.text = @"实名认证审核中";
            self.titleimageView.image = [UIImage imageNamed:@"pic7_personal"];
            self.alerResultImageView.image = [UIImage imageNamed:@"pic8_personal"];
            [self.backBtn setBackgroundImage:[UIImage imageNamed:@"pic9_personal"] forState:UIControlStateNormal];
            [self.backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
            self.autResultLabel.text = @"实名认证审核中，请耐心等候";
        }
            
            break;
        case Authentication_type_success:
        {
            self.autResultLabel.text = self.autResultTitleLabel.text = @"实名认证成功";
            self.autResultTitleLabel.text = self.autResultTitleLabel.text = @"实名认证成功";
            self.titleimageView.image = [UIImage imageNamed:@"pic1_personal"];
            self.alerResultImageView.image = [UIImage imageNamed:@"pic2_personal"];
            [self.backBtn setBackgroundImage:[UIImage imageNamed:@"pic3_personal"] forState:UIControlStateNormal];
            [self.backBtn setTitle:@"返回首页" forState:UIControlStateNormal];
            self.autResultLabel.text = @"实名认证成功";
        }
            break;
            
        default:
            break;
    }

        
}

@end
