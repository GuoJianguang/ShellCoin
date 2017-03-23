//
//  BillIntegaralModel.h
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface BillIntegaralModel : BaseModel
/**
 * id
 */

@property (nonatomic, copy)NSString *integaralId;
/**
 * 商户名
 */

@property (nonatomic, copy)NSString *mchName;
/**
 * 时间
 */

@property (nonatomic, copy)NSString *time;
/**
 * 积分变动数
 */

@property (nonatomic, copy)NSString *accumulateAmount;
/**
 * 交易数
 */

@property (nonatomic, copy)NSString *tranAmount;
/**
 * 交易类型 1消费   2抵换  3积分支付
 */

@property (nonatomic, copy)NSString *tranType;

@end


@interface IntegralShellCoinModel : BaseModel

/**
 * id
 */

@property (nonatomic, copy)NSString *integaralId;
/**
 * 商户名
 */

@property (nonatomic, copy)NSString *mchName;
/**
 * 时间
 */

@property (nonatomic, copy)NSString *time;
/**
 * 贝壳币变动数
 */


@property (nonatomic, copy)NSString *shellsAmount;
/**
 * 交易数
 */

@property (nonatomic, copy)NSString *tranAmount;
/**
 * 交易类型 1平台收益   2抵换  3贝壳币支付
 */

@property (nonatomic, copy)NSString *tranType;

@end

