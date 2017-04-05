//
//  RealnameViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RealnameViewController.h"
#import "RealNameAutResultView.h"

@interface RealnameViewController ()<BasenavigationDelegate>

@property (nonatomic, strong)RealNameAutResultView *resultView;

@end

@implementation RealnameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"实名认证";
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    self.naviBar.delegate = self;
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_confirm"];
//    self.yetRMarkBtn.enabled = NO;
    
    if (self.isWaitAut) {
        self.yetRMarkBtn.hidden = YES;
        
        self.resultView.isSuccess = Authentication_wait_audit;
        [self authenSuccess];
        return;
    }
    
    self.yetRMarkBtn.hidden = !self.isYetAut;
    if (self.isYetAut) {
        self.nameTF.text = [ShellCoinUserInfo shareUserInfos].idcardName;
        self.idcardTF.text = [ShellCoinUserInfo shareUserInfos].idcard;
        self.nameTF.enabled  = NO;
        self.idcardTF.enabled  = NO;
        self.alerLabel.hidden = YES;
        self.starLabel.hidden = YES;
        self.naviBar.hiddenDetailBtn = YES;
        [self hideIDCardNum];
        return;
    }
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:@"您每天有3次机会可以进行实名认证，请仔细核实您的实名认证信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertcontroller addAction:cancelAction];
    [self presentViewController:alertcontroller animated:YES completion:NULL];
    
}

- (void)hideIDCardNum
{
    if (self.idcardTF.text.length == 18) {
        self.idcardTF.text = [self.idcardTF.text stringByReplacingCharactersInRange:NSMakeRange(1, 16) withString:@"****************"];
    }
}
- (RealNameAutResultView *)resultView
{
    if (!_resultView) {
        _resultView = [[RealNameAutResultView alloc]init];
    }
    return _resultView;
}

- (void)backBtnClick
{
    if (self.resultView.isSuccess == Authentication_type_fail) {
        self.resultView.isSuccess = 1;
        self.naviBar.hiddenDetailBtn = NO;
        [self.resultView removeFromSuperview];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 实名认证提交
- (void)detailBtnClick
{
    [self.idcardTF resignFirstResponder];
    [self.nameTF resignFirstResponder];

    if (![self valueValidated]) {
        return;
    }

    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"cardNo":self.idcardTF.text,
                            @"idcardName":self.nameTF.text};
    AFHTTPSessionManager *manager = [self defaultManager];
    NSMutableDictionary *mutalbleParameter = [NSMutableDictionary dictionaryWithDictionary:parms];
    NSString *url = [NSString stringWithFormat:@"%@%@",HttpClient_BaseUrl,@"user/verifyIdcard"];
    [SVProgressHUD showWithStatus:@"正在请求..." maskType:SVProgressHUDMaskTypeBlack];

    [manager POST:url parameters:mutalbleParameter progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        @try {
            NSError *error = nil;
            //    id jsonObject = [responseObject objectFromJSONData];//
            id jsonObject=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:ResponseSerializerEncoding];
            NSString *err_string = [NSString stringWithFormat:@"json 格式错误.返回字符串：%@",responseString];
            NSAssert(error==nil, err_string);
            //token过期
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"-300"]) {
                    [ShellCoinUserInfo shareUserInfos].currentLogined = NO;
                    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"您的登录信息已过期，请重新登录" delegate:[UIApplication sharedApplication].keyWindow.rootViewController cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                    [aler show];
                    return;
                }
                if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"0"]) {
                    self.resultView.isSuccess = Authentication_type_success;
                    [ShellCoinUserInfo shareUserInfos].idcardName = self.nameTF.text;
                    [ShellCoinUserInfo shareUserInfos].idcard = self.idcardTF.text;
                    [ShellCoinUserInfo shareUserInfos].identityFlag = YES;
                    [self authenSuccess];
                    return;
                }
                //                    2035,"身份证实名认证失败"
                else if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"2035"]) {
                    self.resultView.isSuccess = Authentication_type_fail;
                    [self authenSuccess];
//                    [[JAlertViewHelper shareAlterHelper]showTint:jsonObject[@"message"] duration:1.5];
                    return;
                }
                //                    2036,"实名认证失败,身份证与姓名不匹配"
                else if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"2036"]) {
                    self.resultView.isSuccess = Authentication_type_fail;
                    [self authenSuccess];
//                    [[JAlertViewHelper shareAlterHelper]showTint:jsonObject[@"message"] duration:1.5];
//                    return;
                }
                //                    2037,"未绑卡，现在去绑定银行卡吗？"
                else if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"2037"]) {
                    self.resultView.isSuccess = Authentication_type_success;
                    [ShellCoinUserInfo shareUserInfos].idcardName = self.nameTF.text;
                    [ShellCoinUserInfo shareUserInfos].idcard = self.idcardTF.text;
                    [ShellCoinUserInfo shareUserInfos].identityFlag = YES;
                    [self authenSuccess];
                    return;
                }
                //2039,"实名认证信息与之前绑定银行卡信息不一致，银行卡信息已清空，是否现在去重新绑定？"
                else if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"2039"]) {

                    [ShellCoinUserInfo shareUserInfos].identityFlag = YES;
                    [ShellCoinUserInfo shareUserInfos].idcardName = self.nameTF.text;
                    [ShellCoinUserInfo shareUserInfos].idcard = self.idcardTF.text;
                    self.resultView.isSuccess = Authentication_type_success;
                    [self authenSuccess];
                    return;
                     //2047,"三次机会用完"
                }else if ([NullToNumber(jsonObject[@"code"]) isEqualToString:@"2049"]){
//                    self.resultView.isSuccess = Authentication_type_fail;
//                    [self authenSuccess];
                    [[JAlertViewHelper shareAlterHelper]showTint:jsonObject[@"message"] duration:1.5];
                    return;
                }else{
                    self.resultView.isSuccess = Authentication_type_fail;
                    [self authenSuccess];
                    //                    [[JAlertViewHelper shareAlterHelper]showTint:jsonObject[@"message"] duration:1.5];
                    return;
                }
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"网络请求失败，请重试" duration:2.];
    }];

    

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



- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}


-(BOOL) valueValidated {
    // 判断电话号码是否合格
    if ([self emptyTextOfTextField:self.nameTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入姓名" duration:1.5];
        return NO;
    }else if ([self emptyTextOfTextField:self.idcardTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请输入身份证号码" duration:1.5];
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


#pragma makr - 认证成功
- (void)authenSuccess
{
    if (self.resultView.isSuccess == Authentication_type_success) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"realNameSuccess" object:nil];
    }
    self.naviBar.hiddenDetailBtn = YES;
    [self.view addSubview:self.resultView];
    UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
