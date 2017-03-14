//
//  SureTradInView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SureTradInView.h"
#import "ChangePayPasswordViewController.h"


@interface SureTradInView()

@end
@implementation SureTradInView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SureTradInView" owner:nil options:nil][0];
        self.blackBackgoundView.backgroundColor = [UIColor colorFromHexString:@"#ccd8e2"];
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.blackBackgoundView addGestureRecognizer:tap];
        [self sendSubviewToBack:self.blackBackgoundView];
        self.passwordTF.layer.cornerRadius = (TWitdh-120) *(23/110.)/2.;
        self.passwordTF.layer.borderWidth =1;
        self.passwordTF.layer.borderColor = [UIColor redColor].CGColor;
        self.passwordTF.layer.masksToBounds = YES;
        
    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}
- (IBAction)cancelBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)tap{
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


- (IBAction)sureBtn:(UIButton *)sender {
    
}

- (IBAction)forgetBtn:(UIButton *)sender {
    
    ChangePayPasswordViewController *changPayVC = [[ChangePayPasswordViewController alloc]init];
    [self.viewController.navigationController pushViewController:changPayVC animated:YES];
}
@end
