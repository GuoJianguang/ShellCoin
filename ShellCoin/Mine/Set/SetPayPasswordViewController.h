//
//  SetPasswordViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface SetPayPasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UILabel *setPasswordLabel;
@property (weak, nonatomic) IBOutlet UITextField *setpasswordTF;
@property (weak, nonatomic) IBOutlet UILabel *surePasswrodLabel;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTF;
@property (weak, nonatomic) IBOutlet UILabel *openFingerprintlabel;
@property (weak, nonatomic) IBOutlet UISwitch *openSwitch;
- (IBAction)openSwitch:(id)sender;

@end
