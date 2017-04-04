//
//  RecommentModel.h
//  ShellCoin
//
//  Created by Guo on 2017/3/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface RecommentModel : BaseModel

/**
 * 活动id
 */

@property (nonatomic, copy)NSString *seqId;
/**
 * 活动名称
 */

@property (nonatomic, copy)NSString *name;
/**
 * 图片
 */

@property (nonatomic, copy)NSString *coverImg;
/**
 * 跳转方式 3：网页
 */

@property (nonatomic, copy)NSString *jumpWay;

/**
 * 跳转参数值，url
 */
@property (nonatomic, copy)NSString *jumpValue;
/**
 * 为空则没有店铺，否则为商家mchCode
 */

@property (nonatomic, copy)NSString *remark;

@property (nonatomic, assign) NSInteger  type;

@end
