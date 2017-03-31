//
//  ShellCoinUserInfo.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface ShellCoinUserInfo : NSObject

+ (ShellCoinUserInfo *)shareUserInfos;

@property (nonatomic, assign)BOOL currentLogined;
@property (nonatomic, copy)NSString *devicetoken;


- (void)setUserinfoWithdic:(NSDictionary *)dic;

@property (nonatomic, copy)NSString *token;
/**
 * 用户id
 */
@property (nonatomic, copy)NSString *userId;
/**
 * 贝壳币
 */
@property (nonatomic, copy)NSString  *shellsAmount;
/**
 * 昵称
 */
@property (nonatomic, copy)NSString *nickName;
/**
 * vip等级
 */
@property (nonatomic, copy)NSString *vipLevel;
/**
 * 登录密码
 */

@property (nonatomic, copy)NSString *password;
/**
 * 支付密码
 */
@property (nonatomic, copy)NSString *payPassword;
/**
 * 推荐收益余额
 */
@property (nonatomic, copy)NSString *recommendAmount;
/**
 * 是否有待审核的是实名认证请求  0没有  1有
 */
@property (nonatomic, assign)BOOL idVerifyReqFlag ;
/**
 *   0没有  1有绑定银行卡
 */
@property (nonatomic, assign)BOOL bindingFlag;
/**
 *   总积分
 */
@property (nonatomic, copy)NSString *totalAccumulateAmount;
/**
 * 贝壳币收益
 */
@property (nonatomic, copy)NSString *rebateShellsAmount;
/**
 * 昨日收益
 */
@property (nonatomic, copy)NSString *totalRate;
/**
 * 基础收益
 */
@property (nonatomic, copy)NSString *baseRate;
/**
 * 会员等级收益
 */
@property (nonatomic, copy)NSString *plusRate;




#pragma mark - 老数据
//设备token

//当前定位城市
@property (nonatomic, copy)NSString *locationCity;

//头像路径
@property (nonatomic, strong)NSString *avatar;

@property (nonatomic, copy)NSString *userid;
//昵称
//省
@property (nonatomic, copy)NSString *province;
//会话标识，用于获取用户登录信息
//余额
@property (nonatomic, copy)NSString *aviableBalance;
//总消费金额
@property (nonatomic, copy)NSString *totalConsumeAmount;
//消费金
@property (nonatomic, copy)NSString *consumeBalance;
//待让利回馈金额
@property (nonatomic, copy)NSString *totalExpectAmount;
//未参与让利回馈金额
@property (nonatomic, copy)NSString *wiatJoinAmunt;
//区县
@property (nonatomic, copy)NSString *zone;
//市
@property (nonatomic, copy)NSString *city;
//是否绑定银行卡
//等级
@property (nonatomic, copy)NSString *grade;
//积分
@property (nonatomic, copy)NSString *integral;
//银行卡账户
@property (nonatomic, copy)NSString *bankAccount;
//银行卡所属姓名
@property (nonatomic, copy)NSString *bankAccountRealName;
/**
 * 我的消息
 */
@property (nonatomic, copy)NSString *messageCount;
/**
 * 我的提现
 */
@property (nonatomic, copy)NSString *withdrawCount;
/**
 * 我的让利回馈
 */
@property (nonatomic, copy)NSString *feedbackCount;

/**
 * 我的订单
 */
@property (nonatomic, copy)NSString *orderCount;

/**
 * 我的订单待付款
 */
@property (nonatomic, copy)NSString *unPayOrderCount ;

/**
 * 待发货订单数量
 */
@property (nonatomic, copy)NSString *waitDeleverCount;
/*
 * 已完成订单数量
 */
@property (nonatomic, copy)NSString *completeCount;

/**
 * 待发货待确认收货订单数总和
 */
@property (nonatomic, copy)NSString *totalWaitCount;
/**
 * 待确认收货订单数量
 */
@property (nonatomic, copy)NSString *waitConfirmCount;

//（多少天没有消费） 登录里新增返回字段
@property (nonatomic, assign)NSInteger notConsumeDays;

//记录当前位置
@property (nonatomic, assign)CLLocationCoordinate2D locationCoordinate;

//1已经填写身份证号   2没有填写
@property (nonatomic, assign)BOOL identityFlag;
//身份证号码
@property (nonatomic, copy)NSString *idcard;
//真实姓名
@property (nonatomic, copy)NSString *idcardName;
//记录启动的时候有没有通知
@property (nonatomic, strong)NSDictionary *notificationParms;
@property (nonatomic, assign)BOOL islaunchFormNotifi;
/**
 * 实名认证申请标志(0无待审核请求   1有待审核请求  )
 */


/*
 所绑定银行卡的银行名字
 */
@property (nonatomic, strong)NSString *bankname;

//手机号
@property (nonatomic, copy)NSString *phone;

//是否免密
@property (nonatomic, assign)BOOL payPwdFlag;


@end
