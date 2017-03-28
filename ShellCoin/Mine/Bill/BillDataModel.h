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
 * id
 */

@property (nonatomic,copy)NSString *yuEId;
/**
 * 商户名称
 */
@property (nonatomic,copy)NSString *mchName;
/**
 * 金额
 */

@property (nonatomic,copy)NSString *balanceAmount;
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
@end

#pragma mark - 提现记录的model
@interface TixianModel : BaseModel
/**
 * 提现单号
 */
@property (nonatomic,copy)NSString *tixianId;
/**
 * 提现金额
 */
@property (nonatomic,copy)NSString *withdrawAmout;
/**
 * 提现时间
 */
@property (nonatomic,copy)NSString *successTime;
/**
 * 提现状态 0待审核  1审核通过  2提现中   3提现成功  4提现失败
 */
@property (nonatomic,copy)NSString *state;


@end
