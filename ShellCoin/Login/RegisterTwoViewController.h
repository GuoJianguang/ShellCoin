//
//  RegisterTwoViewController.h
//  TTXForConsumer
//
//  Created by ttx on 16/6/29.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterTwoViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *password_view;

@property (weak, nonatomic) IBOutlet UITextField *password_tf;

@property (weak, nonatomic) IBOutlet UIView *surePassword_view;

@property (weak, nonatomic) IBOutlet UITextField *surePassword_tf;

- (IBAction)login_btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *login_btn;

@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;



@property (nonatomic, strong)NSString *userName;

@property (nonatomic, strong)NSString *verifyCode;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sureWidth;

@property (weak, nonatomic) IBOutlet UIImageView *bgimage;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;


@end
