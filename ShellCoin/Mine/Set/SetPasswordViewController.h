//
//  SetPasswordViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface SetPasswordViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *payPasswordLabel;

@property (weak, nonatomic) IBOutlet UILabel *payloginPasswordLabel;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginBtn:(id)sender;
- (IBAction)paypasswordBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *finggerCodeSwitch;
- (IBAction)finggerCodeSwitch:(UISwitch *)sender;
@property (weak, nonatomic) IBOutlet UILabel *fingerprintLabel;
- (IBAction)switch:(id)sender;
- (IBAction)changeSwitchOn:(UIButton *)sender;

@end
