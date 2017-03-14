//
//  RegisterOneViewController.m
//  TTXForConsumer
//
//  Created by ttx on 16/6/28.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "RegisterOneViewController.h"
#import "Verify.h"
#import "RegisterTwoViewController.h"


@interface RegisterOneViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation RegisterOneViewController
{
    int timeLefted;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.naviBar.backgroundColor = [UIColor clearColor];
    self.naviBar.title = @"注册";
    self.naviBar.title_label.textColor = [UIColor whiteColor];
    self.naviBar.lineVIew.hidden = YES;
    self.naviBar.backImage = [UIImage imageNamed:@"icon_back_white"];
    timeLefted = 60;

    self.imageHeight.constant = TWitdh*(66/75.);
    self.bgimage.image = [UIImage imageNamed:@"bg_login.jpg"];
    
    self.loginWidth.constant = TWitdh*(526/750.);
    
    self.userView.layer.cornerRadius = (self.loginWidth.constant*(88/526.))/2.;
    self.userView.layer.masksToBounds = YES;
    self.userView.layer.borderWidth = 1;
    self.userView.layer.borderColor = MacolayerColor.CGColor;
    
    self.graphCodeView.layer.cornerRadius = (self.loginWidth.constant*(88/526.))/2.;
    self.graphCodeView.layer.masksToBounds = YES;
    self.graphCodeView.layer.borderWidth = 1;
    self.graphCodeView.layer.borderColor = MacolayerColor.CGColor;
    
    self.codeView.layer.cornerRadius = (self.loginWidth.constant*(88/526.))/2.;
    self.codeView.layer.masksToBounds = YES;
    self.codeView.layer.borderWidth = 1;
    self.codeView.layer.borderColor = MacolayerColor.CGColor;
//    self.codeBtn.layer.cornerRadius = 3;
//    self.codeBtn.layer.borderWidth = 1;
//    self.codeBtn.layer.borderColor = MacoColor.CGColor;
    
    self.coedBtnHeight.constant = TWitdh*(60/750.);
    self.sureWidth.constant = TWitdh*(400/750.);
    CGFloat  sureBtnWidth = TWitdh*(400/750.);
    self.nextBtn.bounds = CGRectMake(0, 0, sureBtnWidth, sureBtnWidth/5.);
    self.nextBtn.layer.cornerRadius = self.nextBtn.bounds.size.height/2.;
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.backgroundColor = MacoColor;
    
    self.phone_num_tf.delegate = self;
    self.codeTF.delegate = self;
    self.grapTF.delegate = self;
    
    if (THeight < 500) {
        //        self.userTop.constant = 0;
        self.loginTop.constant = 20;
        self.imageHeight.constant = TWitdh*(50/75.);
        self.bgimage.contentMode = UIViewContentModeScaleAspectFill;
        self.bgimage.layer.masksToBounds = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)getGraphBtn:(UIButton *)sender {
    if ([self emptyTextOfTextField:self.phone_num_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入手机号码" duration:1.];
        return;
    }
    sender.enabled = NO;
    Verify *veri = [[Verify alloc]init];
    [veri verifyPhoneNumber:self.phone_num_tf.text callBack:^(BOOL success, NSError *error) {
        if (success) {
            NSDictionary *parms = @{@"phone":self.phone_num_tf.text,
                                    @"key":@"register"};
            AFHTTPSessionManager *manager = [self defaultManager];
            NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parms];
            NSString *url = [NSString stringWithFormat:@"%@%@",HttpClient_BaseUrl,@"verifyCode/getImageVerifyCode"];
            [manager POST:url parameters:mutalbleParameter success:^(NSURLSessionDataTask *operation, id responseObject) {
                [SVProgressHUD dismiss];
                UIImage *image = [[UIImage alloc]initWithData:responseObject];
                [self.getGraphBtn setBackgroundImage:image forState:UIControlStateNormal];
                [self.getGraphBtn setTitle:@"" forState:UIControlStateNormal];
                sender.enabled = YES;
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                [[JAlertViewHelper shareAlterHelper]showTint:@"图形验证码获取失败，请重试" duration:2.];
                sender.enabled = YES;
            }];
            return ;
        }
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入正确的手机号" duration:1.5];
        sender.enabled = YES;
    }];

}
- (IBAction)codeBtn:(UIButton *)sender {
    if ([self emptyTextOfTextField:self.grapTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入图形验证码" duration:1.5];
        return;
    }
    sender.enabled = NO;
    Verify *veri = [[Verify alloc]init];
    [veri verifyPhoneNumber:self.phone_num_tf.text callBack:^(BOOL success, NSError *error) {
        if (success) {
            //获取验证码
            NSDictionary *parms = @{@"phone":self.phone_num_tf.text,
                                    @"imageVerifyCode":self.grapTF.text};
            [HttpClient POST:@"sms/sendCommonCode" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
                sender.enabled = YES;
                if (IsRequestTrue) {
                    [self.codeBtn setTitle:@"重新获取(60)" forState:UIControlStateNormal];
                    self.codeBtn.layer.borderColor = MacoIntrodouceColor.CGColor;
                    [self.codeBtn setTitleColor:MacoIntrodouceColor forState:UIControlStateNormal];
                    self.codeBtn.enabled = NO;
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeLeft:) userInfo:nil repeats:YES];
                    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
                }
                
            } failure:^(NSURLSessionDataTask *operation, NSError *error) {
                sender.enabled = YES;
            }];
            
            return ;
        }
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入正确的手机号" duration:1.5];
    }];
}

#pragma mark - 验证码计时器
//static int timeLefted = 60;
-(void) timeLeft:(NSTimer*) timer {
    
    timeLefted--;
    if (timeLefted == 0) {
        [self verifyButtonNormal];
        return;
    }

    NSString *title = [NSString stringWithFormat:@"重新获取(%d)",timeLefted];
    self.codeBtn.titleLabel.text = title;
    [self.codeBtn setTitle:title forState:UIControlStateNormal];
    
}

-(void) verifyButtonNormal {
    [self.timer invalidate];
    timeLefted = 60;
    self.codeBtn.layer.borderColor = MacoColor.CGColor;
    [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
    self.codeBtn.enabled = YES;
}


#pragma mark - 下一步
- (IBAction)nextBtn:(UIButton *)sender {
    
    if ([self valueValidated]) {
        Verify *veri = [[Verify alloc]init];
        [veri verifyPhoneNumber:self.phone_num_tf.text callBack:^(BOOL success, NSError *error) {
            if (success) {
                RegisterTwoViewController *registerVC = [[RegisterTwoViewController alloc]init];
                registerVC.userName = self.phone_num_tf.text;
                registerVC.verifyCode = self.codeTF.text;
                [self.navigationController pushViewController:registerVC animated:YES];
                return;
            }
            [[JAlertViewHelper shareAlterHelper]showTint:@"请输入正确的手机号" duration:1.5];
        }];

    }
    
}


-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.phone_num_tf]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入手机号码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.grapTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入图形验证码" duration:1.];
        return NO;
    }else if ([self emptyTextOfTextField:self.codeTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入验证码" duration:1.];
        return NO;
    }
    return YES;
}

-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
}

#pragma mark - UITextFiledDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phone_num_tf) {
        if (textField.text.length > 10 && ![string isEqualToString:@""]) {
            return NO;
        }
        [self.getGraphBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.getGraphBtn setTitle:@"点击获取" forState:UIControlStateNormal];
        
        self.grapTF.text = @"";
    }
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.phone_num_tf) {
        self.userView.layer.borderColor = MacoColor.CGColor;
    }
    if (textField == self.codeTF) {
        self.codeView.layer.borderColor = MacoColor.CGColor;
    }
    if (textField == self.grapTF) {
        self.graphCodeView.layer.borderColor = MacoColor.CGColor;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.phone_num_tf) {
        self.userView.layer.borderColor = MacolayerColor.CGColor;
    }
    if (textField == self.codeTF) {
        self.codeView.layer.borderColor = MacolayerColor.CGColor;
    }
    if (textField == self.grapTF) {
        self.graphCodeView.layer.borderColor = MacolayerColor.CGColor;
    }
}



-(AFHTTPSessionManager*) defaultManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.stringEncoding = RequestSerializerEncoding;
    requestSerializer.timeoutInterval = TimeoutInterval;
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.stringEncoding = ResponseSerializerEncoding;
    
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = responseSerializer;
    
    return manager;
}


@end
