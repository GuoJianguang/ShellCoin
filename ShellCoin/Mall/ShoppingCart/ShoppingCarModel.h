//
//  ShoppingCarModel.h
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"
#import "ShoopingCart+CoreDataProperties.h"

@interface ShoppingCarModel : BaseModel

@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *goodsName;
@property (nonatomic, copy)NSString *goodsSpec;
@property (nonatomic, copy)NSString *goodsId;
@property (nonatomic, assign)NSInteger goodsNum;
@property (nonatomic, copy)NSString *priceId;
@property (nonatomic,assign) double cash;
@property (nonatomic,assign) double coupons;
@property (nonatomic,assign) double shellCoin;
@property (nonatomic,assign) double goodsPrice;
@property (nonatomic,assign) double goodsFreight;
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL isSelect;

+ modelWithCoreData:(ShoopingCart *)cartDic;

@end
