//
//  ChangePayPasswordViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangePayPasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UILabel *verCodeLabel;

@property (weak, nonatomic) IBOutlet UITextField *verCodeTF;
@property (weak, nonatomic) IBOutlet UILabel *xinPayLabel;
@property (weak, nonatomic) IBOutlet UITextField *xinPayTF;
@property (weak, nonatomic) IBOutlet UILabel *sureNewPayLabel;
@property (weak, nonatomic) IBOutlet UITextField *sureNewPayTF;
@property (weak, nonatomic) IBOutlet UIButton *verCodeBtn;
- (IBAction)verCodeBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *fingerCodeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *finggerCodeSwitch;
- (IBAction)finggerCodeSwitch:(UISwitch *)sender;

@end
