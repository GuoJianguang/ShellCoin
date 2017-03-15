//
//  YesTodayEarningsAlerView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "YesTodayEarningsAlerView.h"

@implementation YesTodayEarningsAlerView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"YesTodayEarningsAlerView" owner:nil options:nil][0];
        self.blackBackgoundView.backgroundColor = [UIColor colorFromHexString:@"#ccd8e2"];
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
}

- (void)tap{
    [self removeFromSuperview];
}

- (IBAction)deletBtn:(UIButton *)sender {
    [self removeFromSuperview];
}
@end
