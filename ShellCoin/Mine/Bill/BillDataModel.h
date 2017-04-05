//
//  BillDataModel.h
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface BillDataModel : BaseModel

/**
 * 商户名称
 */
@property (nonatomic,copy)NSString *mchName;
/**
 * 余额支付金额
 */

@property (nonatomic,copy)NSString *balanceAmount;

/**
 *  现金支付金额
 */

@property (nonatomic,copy)NSString *cashAmount;

/**
 * 时间
 */
@property (nonatomic,copy)NSString *tranTime;
/**
 *  渠道
 */
@property (nonatomic,copy)NSString *channel;
/**
 * 商品名称
 */
@property (nonatomic,copy)NSString *goodsName;
/**
 * 商品规格
 */
@property (nonatomic,copy)NSString *spec;
//channel=3    `pay_type`     '0余额支付 1微信支付
//channel=1 线下现金支付
@property (nonatomic,copy)NSString *payType;
/**
 * 订单金额
 */

@property (nonatomic,copy)NSString *totalAmount;

/**
 * 订单号
 */

@property (nonatomic,copy)NSString *orderId;

/**
 * 商户头像
 */
@property (nonatomic,copy)NSString *pic;

/**
 * 商户号
 */

@property (nonatomic,copy)NSString *mchCode;


//消费金

@property (nonatomic,copy)NSString *consumeAmount;

@property (nonatomic,copy)NSString *state;

@end

#pragma mark - 抵换记录的model
@interface TixianModel : BaseModel
/**
 * 抵换单号
 */
@property (nonatomic,copy)NSString *tixianId;
/**
 * 抵换金额
 */
@property (nonatomic,copy)NSString *withdrawAmout;
/**
 * 抵换时间
 */
@property (nonatomic,copy)NSString *successTime;
/**
 * 抵换状态 0待审核  1审核通过  2抵换中   3抵换成功  4抵换失败
 */
@property (nonatomic,copy)NSString *state;


@end
