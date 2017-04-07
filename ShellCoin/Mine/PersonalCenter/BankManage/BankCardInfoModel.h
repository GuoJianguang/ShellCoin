//
//  BankCardInfoModel.h
//  ShellCoin
//
//  Created by Guo on 2017/3/30.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface BankCardInfoModel : BaseModel
/**
 * 银行卡信息id
 */

@property (nonatomic, copy)NSString *bankinfoid;
/**
 * 银行卡号
 */

@property (nonatomic, copy)NSString *bankAccount;
/**
 * 银行预留手机号
 */

@property (nonatomic, copy)NSString *bankPhone;
/**
 * 银行卡姓名
 */

@property (nonatomic, copy)NSString *realName;
/**
 * 身份证号
 */

@property (nonatomic, copy)NSString *identity;
/**
 * 开户行
 */

@property (nonatomic, copy)NSString *bankBranch;
/**
 * 开户行号
 */

@property (nonatomic, copy)NSString *bankBranchNo;
/**
 * 省
 */

@property (nonatomic, copy)NSString *bankAccountPro;
/**
 * 银行编号
 */

@property (nonatomic, copy)NSString *bankId;
/**
 * 银行名称
 */

@property (nonatomic, copy)NSString *bankName;
/**
 * 网点
 */

@property (nonatomic, copy)NSString *bankPoint;
/**
 * 网点开户行
 */

@property (nonatomic, copy)NSString *bankPointBranch;
/**
 * 状态（0普通 1默认卡）
 */
@property (nonatomic, copy)NSString *state;


@property (nonatomic, copy)NSString *bankImg;
//@property (nonatomic, copy)NSString *bankAccount;
@property (nonatomic, assign)BOOL isSeclet;

@property (nonatomic,assign)NSInteger count;

@property (nonatomic, copy)NSString *withdrawRateDesc;


@end
