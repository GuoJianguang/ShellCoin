//
//  LoginViewController.h
//  TTXForConsumer
//
//  Created by ttx on 16/6/28.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

+ (UINavigationController *)controller;

@property (weak, nonatomic) IBOutlet UIView *password_view;
@property (weak, nonatomic) IBOutlet UITextField *password_tf;
@property (weak, nonatomic) IBOutlet UIView *user_view;
@property (weak, nonatomic) IBOutlet UITextField *user_tf;

- (IBAction)login_btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *login_btn;

- (IBAction)cancelLogin:(UIButton *)sender;


- (IBAction)forgetBtn:(id)sender;

- (IBAction)registerBtn:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sureWidth;

@property (weak, nonatomic) IBOutlet UIImageView *bgimage;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passworTop;

@property (weak, nonatomic) IBOutlet UIView *imageView;


@end
