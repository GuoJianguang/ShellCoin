//
//  ChangeLoginPasswordViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangeLoginPasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIView *view3;

@property (weak, nonatomic) IBOutlet UILabel *oldPasswordLabel;

@property (weak, nonatomic) IBOutlet UITextField *oldPassowrodTF;
@property (weak, nonatomic) IBOutlet UILabel *xinPassowrdLabel;
@property (weak, nonatomic) IBOutlet UITextField *xinPasswordTF;
@property (weak, nonatomic) IBOutlet UILabel *surePasswrodLabel;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTF;

@end
