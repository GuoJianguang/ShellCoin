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


@interface MineTableViewCell()
@property (nonatomic, strong)YesTodayEarningsAlerView *showYestodayView;
@end
@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];
    self.personCenterLabel.textColor = self.recommendLabel.textColor = self.billLabel.textColor = self.setLabel.textColor = self.integralLabel.textColor = self.proportionLabel.textColor= MacoTitleColor;
    self.showIntergralLabel.textColor = self.showProportionLabel.textColor = MacoColor;
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"总贝壳币：%ld",[[ShellCoinUserInfo shareUserInfos].totalRate integerValue]];
    self.totalMoneyLabel.adjustsFontSizeToFitWidth = self.showIntergralLabel.adjustsFontSizeToFitWidth = YES;
    self.showIntergralLabel.text = [ShellCoinUserInfo shareUserInfos].totalAccumulateAmount;
    self.showProportionLabel.text = [NSString stringWithFormat:@"%@%@",[ShellCoinUserInfo shareUserInfos].totalRate,@"%"];
    
    if (TWitdh > 320) {
        self.viewHeight.constant = TWitdh*1.05;
        self.imageViewHeight.constant = TWitdh*(446/750.);
    }else{
        self.viewHeight.constant = TWitdh*1.15;
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
            self.showIntergralLabel.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].totalExpectAmount doubleValue] + [[ShellCoinUserInfo shareUserInfos].wiatJoinAmunt doubleValue]];
            self.showProportionLabel.text = [NSString stringWithFormat:@"%.2f",[[ShellCoinUserInfo shareUserInfos].totalConsumeAmount doubleValue]];
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

- (IBAction)showYestodayEBtn:(id)sender {
    
    [self.viewController.navigationController.view addSubview:self.showYestodayView];
}
@end
