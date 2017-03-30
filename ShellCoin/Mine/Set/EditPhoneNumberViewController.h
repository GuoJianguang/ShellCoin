//
//  EditPhoneNumberViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface EditPhoneNumberViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UILabel *oldPhoneLabel;

@property (weak, nonatomic) IBOutlet UITextField *oldPhoneTF;

@property (weak, nonatomic) IBOutlet UITextField *oldVerCodeTF;
@property (weak, nonatomic) IBOutlet UILabel *oldVerCodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *freshPhoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *freshPhoneTF;
@property (weak, nonatomic) IBOutlet UILabel *freshCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *freshCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *sendOldCodeBtn;
- (IBAction)sendOldCodeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendNewCodeBtn;
- (IBAction)sendNewCodeBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *alerLabel;



@end
