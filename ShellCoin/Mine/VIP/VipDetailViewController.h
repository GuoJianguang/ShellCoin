//
//  VipDetailViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface VipDetailViewController : BaseViewController
- (IBAction)backBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *vipImage;
@property (weak, nonatomic) IBOutlet UIView *ingerView;
@property (weak, nonatomic) IBOutlet UILabel *nowIntegral;
@property (weak, nonatomic) IBOutlet UILabel *totalInegral;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *expalinLabel;

@end
