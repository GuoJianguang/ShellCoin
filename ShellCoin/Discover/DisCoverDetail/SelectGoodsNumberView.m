//
//  SelectBanCardView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SelectGoodsNumberView.h"
#import "SureDiscoverOrderViewController.h"


@interface SelectGoodsNumberView()
@end

@implementation SelectGoodsNumberView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SelectGoodsNumberView" owner:nil options:nil][0];
        self.blackBackgoundView.backgroundColor = [UIColor colorFromHexString:@"#ccd8e2"];
        [self.sureBtn setTitleColor:MacoColor forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:MacoColor forState:UIControlStateNormal];
        self.titelLabel.textColor = MacoTitleColor;
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.blackBackgoundView addGestureRecognizer:tap];
        [self sendSubviewToBack:self.blackBackgoundView];
        

    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.numberTF.layer.borderWidth = 1;
    self.numberTF.layer.borderColor =MacoColor.CGColor;
    self.addBtn.layer.borderWidth = 1;
    [self.addBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    self.addBtn.layer.borderColor = MacoColor.CGColor;
    self.minusBtn.layer.borderWidth = 1;
    self.minusBtn.layer.borderColor = [UIColor colorFromHexString:@"c8c8c8"].CGColor;
    [self.minusBtn setTitleColor:[UIColor colorFromHexString:@"c8c8c8"] forState:UIControlStateNormal];
    self.numberTF.textColor = MacoDetailColor;
    self.numberTF.text = @"1";

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
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            SureDiscoverOrderViewController *sureVC = [[SureDiscoverOrderViewController alloc]init];
            sureVC.goodsId = self.goodsId;
            sureVC.number = [self.numberTF.text integerValue];
            [self.viewController.navigationController pushViewController:sureVC animated:YES];
            [self removeFromSuperview];
        }
    }];
}
- (IBAction)addBtn:(UIButton *)sender
{
    self.minusBtn.layer.borderColor = MacoColor.CGColor;
    [self.minusBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    self.numberTF.text =[NSString stringWithFormat:@"%ld",[self.numberTF.text integerValue]+1];
}
- (IBAction)minusBtn:(UIButton *)sender
{
    if ([self.numberTF.text integerValue]== 2) {
        self.minusBtn.layer.borderColor = [UIColor colorFromHexString:@"c8c8c8"].CGColor;
        [self.minusBtn setTitleColor:[UIColor colorFromHexString:@"c8c8c8"] forState:UIControlStateNormal];
    }
    if ([self.numberTF.text integerValue] < 2 ) {
        return;
    }
    self.numberTF.text =[NSString stringWithFormat:@"%ld",[self.numberTF.text integerValue]-1];
}

@end
