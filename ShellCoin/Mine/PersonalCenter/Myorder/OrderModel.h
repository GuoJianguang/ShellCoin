//
//  OrderModel.h
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"




@interface OrderModel : BaseModel

/**
 * 订单号
 */
@property (nonatomic,copy)NSString *orderId;

/**
 * 订单详情id
 */
@property (nonatomic,copy)NSString *detailId;
/**
 * 商品id
 */
@property (nonatomic,copy)NSString *goodsId;


/**
 * 商品名
 */

@property (nonatomic,copy)NSString *goodsName;


/**
 * 商品图片
 */

@property (nonatomic,copy)NSString *goodsImage;
/**
 * 商品规格描述
 */

@property (nonatomic,copy)NSString *goodsSpecDesc;
/**
 * 数量
 */
@property (nonatomic,copy)NSString *quantity;

/**
 *  价格
 */
@property (nonatomic,copy)NSString *goodsPrice;

/**
 *  0待付款 1待发货  2待收货  3已完成 4退款中  5退款完成
 */
@property (nonatomic,copy)NSString *state;
/**
 * 商户店铺名
 */
@property (nonatomic,copy)NSString *mchName;

/**
 *  物流公司
 */
@property (nonatomic,copy)NSString *logisticsCompany;
/**
 *  物流单号
 */
@property (nonatomic,copy)NSString *logisticsNumber;


/**
 *  快递公司编号
 */
@property (nonatomic,copy)NSString *logisticsCompanyCode;

/**
 * 0未评价 1已评价
 */

@property (nonatomic,copy)NSString *commentFlag;

/**
 * 价格id
 */

@property (nonatomic,copy)NSString *priceId;


/**
 * 商户号
 */


@property (nonatomic,copy)NSString *mchCode;

/**
 * 收货地址
 */

@property (nonatomic,copy)NSString *receiptAddress;

/**
 * 收货人
 */

@property (nonatomic,copy)NSString *receiptPeople;

/**
 * 收货人电话
 */

@property (nonatomic,copy)NSString *receiptPhone;

/**
 * 实付现金
 */

@property (nonatomic,copy)NSString *tranAmount;
/**
 * 购物卷
 */

@property (nonatomic,copy)NSString *consumeAmount;
/**
 * 贝壳币
 */

@property (nonatomic,copy)NSString *expectAmount;

/**
 * 运费
 */

@property (nonatomic,copy)NSString *freight;

@end
