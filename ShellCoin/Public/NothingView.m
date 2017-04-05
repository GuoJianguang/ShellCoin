//
//  NothingView.m
//  Tourguide
//
//  Created by 郭建光 on 15/4/11.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import "NothingView.h"

@implementation NothingView

- (void)awakeFromNib {
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"点击重新加载"];
//    NSRange strRange = {0,[str length]};
//    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
//    [self.refresh_btn setAttributedTitle:str forState:UIControlStateNormal];
//    [self.refresh_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.refresh_btn.layer.cornerRadius = 5;
    self.refresh_btn.layer.borderWidth = 1;
    self.refresh_btn.layer.borderColor = MacoColor.CGColor;
    [self.refresh_btn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    self.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];
    
    self.error_image.layer.masksToBounds = YES;
}

- (IBAction)refresh:(UIButton *)sender {
    if (self.refreshCallback) {
        self.refreshCallback();
    }
}
@end
