//
//  RegisterOneViewController.h
//  TTXForConsumer
//
//  Created by ttx on 16/6/28.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterOneViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *userView;

@property (weak, nonatomic) IBOutlet UITextField *phone_num_tf;


@property (weak, nonatomic) IBOutlet UIView *graphCodeView;

@property (weak, nonatomic) IBOutlet UIButton *getGraphBtn;

- (IBAction)getGraphBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *grapTF;

@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
- (IBAction)codeBtn:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

- (IBAction)nextBtn:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sureWidth;

@property (weak, nonatomic) IBOutlet UIImageView *bgimage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coedBtnHeight;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeight;

@end
