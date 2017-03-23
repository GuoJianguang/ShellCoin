//
//  BillAmountDataModel.h
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface BillAmountDataModel : BaseModel
/**
 * 订单号
 */
@property (nonatomic, copy)NSString *orderId;
/**
 * 订单金额
 */
@property (nonatomic, copy)NSString *totalAmount;
/**
 * 订单时间
 */
@property (nonatomic, copy)NSString *tranTime;
/**
 * 商户号
 */
@property (nonatomic, copy)NSString *mchCode;
/**
 * 商户名称
 */
@property (nonatomic, copy)NSString *mchName;
/*
* 渠道  1线下现金消费 2线下微信消费 3线下余额消费
*/

@property (nonatomic, copy)NSString *channel;
/**
 * 订单状态  订单状态（0 未支付 1 正常 2 已返利 3 冻结 4 取消）
 */

@property (nonatomic, copy)NSString *state;
/**
 * 用户ID
 */

@property (nonatomic, copy)NSString *userId;


@end


@interface BillDihuanModel : BaseModel
/**
 * 提现单号
 */

@property (nonatomic, copy)NSString *orderId;
/**
 * 提现金额
 */

@property (nonatomic, copy)NSString *withdrawAmout;
/**
 * 提现时间
 */

@property (nonatomic, copy)NSString *successTime;
/**
 * 提现状态 '订单状态（0待审核  1提现中   2提现成功  3提现失败 ）'
 */

@property (nonatomic, copy)NSString *state;




@end

