//
//  ShoopingCart+CoreDataProperties.h
//  ShellCoin
//
//  Created by mac on 2017/6/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ShoopingCart+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ShoopingCart (CoreDataProperties)

+ (NSFetchRequest<ShoopingCart *> *)fetchRequest;

@property (nonatomic) double cash;
@property (nonatomic) double coupons;
@property (nullable, nonatomic, copy) NSString *goodsId;
@property (nullable, nonatomic, copy) NSString *goodsName;
@property (nonatomic) int32_t goodsNum;
@property (nonatomic) double goodsPrice;
@property (nullable, nonatomic, copy) NSString *goodsSpec;
@property (nonatomic) double shellCoin;
@property (nullable, nonatomic, copy) NSString *goodsImage;
@property (nonatomic) double goodsFreight;
@property (nullable, nonatomic, copy) NSString *priceId;

@end

NS_ASSUME_NONNULL_END
