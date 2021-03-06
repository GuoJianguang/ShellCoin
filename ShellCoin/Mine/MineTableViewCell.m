//
//  MineTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MineTableViewCell.h"
#import "ManagerBankCardViewController.h"
#import "PersonCenterViewController.h"
#import "SetViewController.h"
#import "BillViewController.h"
#import "RecommentEarningsViewController.h"
#import "TradInViewController.h"
#import "LBXScanViewStyle.h"
#import "SubLBXScanViewController.h"
#import "YesTodayEarningsAlerView.h"
#import "WithdrawalViewController.h"
#import "RealnameViewController.h"
#import "EditBankInfoViewController.h"
#import "MessageListViewController.h"
#import "LoanHomeViewController.h"
#import "VipDetailViewController.h"


@interface MineTableViewCell()
@property (nonatomic, strong)YesTodayEarningsAlerView *showYestodayView;
@end
@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];
    self.personCenterLabel.textColor = self.recommendLabel.textColor = self.billLabel.textColor = self.setLabel.textColor = self.integralLabel.textColor = self.proportionLabel.textColor= self.loanLabel.textColor = MacoTitleColor;
    self.showIntergralLabel.textColor = self.showProportionLabel.textColor = MacoColor;

    self.totalMoneyLabel.adjustsFontSizeToFitWidth = self.showIntergralLabel.adjustsFontSizeToFitWidth=self.yesTodayBuyCardLabel.adjustsFontSizeToFitWidth=self.yestodyEarningsMoneyLabel.adjustsFontSizeToFitWidth = YES;
    self.showIntergralLabel.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].totalExpectAmount doubleValue] + [[ShellCoinUserInfo shareUserInfos].wiatJoinAmunt doubleValue]];
    self.showProportionLabel.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].totalConsumeAmount doubleValue]];
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"总余额：%.2f",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue]];
    self.totalBuyCardLabel.text = [NSString stringWithFormat:@"总购物券：%.2f",[[ShellCoinUserInfo shareUserInfos].consumeBalance doubleValue]];
    self.yestodyEarningsMoneyLabel.text = [NSString stringWithFormat:@"+%@",[ShellCoinUserInfo shareUserInfos].lastRebateBalance];
    self.yesTodayBuyCardLabel.text = [NSString stringWithFormat:@"+%@购物券",[ShellCoinUserInfo shareUserInfos].lastRebateConsumeBalance];
    self.vipAddLabel.adjustsFontSizeToFitWidth = YES;
    self.showVip.titleLabel.adjustsFontSizeToFitWidth = YES;
    if (TWitdh > 320) {
        self.viewHeight.constant = TWitdh*1.1;
        self.imageViewHeight.constant = TWitdh*(446/750.);
    }else{
        self.viewHeight.constant = TWitdh*1.2;
        self.imageViewHeight.constant = TWitdh*(480/750.);
    }

    self.showProPortionImageView.hidden = YES;
    self.showYestodayEBtn.enabled = NO;
    
    [self searchUserInfor];
}

- (void)searchUserInfor
{
    NSString *token = [ShellCoinUserInfo shareUserInfos].token;
    //获取用户最新消息
    [HttpClient POST:@"user/userBaseInfo/get" parameters:@{@"token":token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            
            [[ShellCoinUserInfo shareUserInfos]setUserinfoWithdic:jsonObject[@"data"]];
            
            if ([[ShellCoinUserInfo shareUserInfos].messageCount isEqualToString:@"0"]) {
                [self.messageBtn setImage:[UIImage imageNamed:@"icon_news"] forState:UIControlStateNormal];

            }else{
                [self.messageBtn setImage:[UIImage imageNamed:@"icon_haveNews"] forState:UIControlStateNormal];
            };
            self.vipAddLabel.text = [NSString stringWithFormat:@"+%@",[ShellCoinUserInfo shareUserInfos].vipRate];
            [self.showVip setTitle:[NSString stringWithFormat:@"VIP%@",[ShellCoinUserInfo shareUserInfos].vipLevel ] forState:UIControlStateNormal];
            switch ([[ShellCoinUserInfo shareUserInfos].vipLevel integerValue]) {
                case 11:
                    [self.showVip setTitle:@"银钻" forState:UIControlStateNormal];

                    break;
                case 12:
                    [self.showVip setTitle:@"金钻" forState:UIControlStateNormal];
                    
                    break;
                case 13:
                    [self.showVip setTitle:@"皇冠" forState:UIControlStateNormal];
                    
                    break;
                default:
                    break;
            }
            self.showIntergralLabel.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].totalExpectAmount doubleValue] + [[ShellCoinUserInfo shareUserInfos].wiatJoinAmunt doubleValue]];
            self.showProportionLabel.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].totalConsumeAmount doubleValue]];
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"总余额：%.2f",[[ShellCoinUserInfo shareUserInfos].aviableBalance doubleValue]];
            self.totalBuyCardLabel.text = [NSString stringWithFormat:@"总购物券：%.2f",[[ShellCoinUserInfo shareUserInfos].consumeBalance doubleValue]];
            self.yestodyEarningsMoneyLabel.text = [NSString stringWithFormat:@"+%@",[ShellCoinUserInfo shareUserInfos].lastRebateBalance];
            self.yesTodayBuyCardLabel.text = [NSString stringWithFormat:@"+%@购物券",[ShellCoinUserInfo shareUserInfos].lastRebateConsumeBalance];
            [ShellCoinUserInfo shareUserInfos].token = token;
            
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
    }];
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - 点击事件
//消息按钮
- (IBAction)messageBtn:(id)sender {
    MessageListViewController *messageListVC = [[MessageListViewController alloc]init];
    [self.viewController.navigationController pushViewController:messageListVC animated:YES];
}
//条形码按钮
- (IBAction)barCodeBtn:(id)sender {
    
}
//二维码按钮
- (IBAction)qrCodeBtn:(id)sender {
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    
    vc.isQQSimulator = YES;
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
}


//帮助
- (IBAction)helpBtn:(id)sender {
}
//抵换
- (IBAction)tradeInBtn:(id)sender {
//    TradInViewController *tradInVC = [[TradInViewController alloc]init];
//    [self.viewController.navigationController pushViewController:tradInVC animated:YES];
    //首先判断用户时候已经实名认证
    if ([self gotRealNameRu:@"在您申请抵换之前,请先进行实名认证"]){
        return;
    }
    //再判断是否绑定银行卡
    if (![ShellCoinUserInfo shareUserInfos].bindingFlag){
        [self goBingdingBank:@"您还未绑定银行卡，请先绑定银行卡"];
    }
    WithdrawalViewController *tradInVC = [[WithdrawalViewController alloc]init];
    [self.viewController.navigationController pushViewController:tradInVC animated:YES];
}

//个人中心
- (IBAction)personCenterAction:(id)sender {
    PersonCenterViewController *personVC = [[PersonCenterViewController alloc]init];
    [self.viewController.navigationController pushViewController:personVC animated:YES];
}

//推荐收益
- (IBAction)recommendEarningsAction:(id)sender {
    RecommentEarningsViewController *recommentVC = [[RecommentEarningsViewController alloc]init];
    [self.viewController.navigationController pushViewController:recommentVC animated:YES];
}
//账单
- (IBAction)billAction:(id)sender {
    BillViewController *billVC = [[BillViewController alloc]init];
    [self.viewController.navigationController pushViewController:billVC animated:YES];
    
}
//设置
- (IBAction)setAction:(id)sender {
    SetViewController *setVC = [[SetViewController alloc]init];
    [self.viewController.navigationController pushViewController:setVC animated:YES];
}

- (YesTodayEarningsAlerView *)showYestodayView
{
    if (!_showYestodayView) {
        _showYestodayView = [[YesTodayEarningsAlerView alloc]init];
    }
    return _showYestodayView;
}

#pragma mark - 贷款
- (IBAction)theLoanBtn:(UIButton *)sender {
    LoanHomeViewController *loanListVC = [[LoanHomeViewController alloc]init];
    [self.viewController.navigationController pushViewController:loanListVC animated:YES];
}

- (IBAction)showYestodayEBtn:(id)sender {
    
    [self.viewController.navigationController.view addSubview:self.showYestodayView];
}


#pragma mark - 去进行实名认证
- (BOOL)gotRealNameRu:(NSString *)alerTitle
{
    if (![ShellCoinUserInfo shareUserInfos].identityFlag) {
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:alerTitle preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //去进行实名认证
            
            if ([ShellCoinUserInfo shareUserInfos].idVerifyReqFlag) {
                RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
                realnameVC.isWaitAut = YES;
                [self.viewController.navigationController pushViewController:realnameVC animated:YES];
                
                return;
            }
            RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
            realnameVC.isYetAut = NO;
            [self.viewController.navigationController pushViewController:realnameVC animated:YES];
            
        }];
        [alertcontroller addAction:cancelAction];
        [alertcontroller addAction:otherAction];
        [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
        return YES;
    }
    return NO;
}

#pragma mark - 去绑定银行卡
- (void)goBingdingBank:(NSString *)alerTitle
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:alerTitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //去绑定银行卡
        EditBankInfoViewController *bankcardVC = [[EditBankInfoViewController alloc]init];
        bankcardVC.isFromRoomPage = YES;
        [self.viewController.navigationController pushViewController:bankcardVC animated:YES];
    }];
    [alertcontroller addAction:cancelAction];
    [alertcontroller addAction:otherAction];
    [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
}

- (IBAction)vipDetailBtn:(UIButton *)sender {
    VipDetailViewController *vipVC = [[VipDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:vipVC animated:YES];
}
@end
