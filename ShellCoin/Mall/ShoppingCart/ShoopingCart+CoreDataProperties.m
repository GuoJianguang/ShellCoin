//
//  ShoopingCart+CoreDataProperties.m
//  ShellCoin
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ShoopingCart+CoreDataProperties.h"

@implementation ShoopingCart (CoreDataProperties)

+ (NSFetchRequest<ShoopingCart *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ShoopingCart"];
}

@dynamic cash;
@dynamic coupons;
@dynamic goodsFreight;
@dynamic goodsId;
@dynamic goodsImage;
@dynamic goodsName;
@dynamic goodsNum;
@dynamic goodsPrice;
@dynamic goodsSpec;
@dynamic priceId;
@dynamic shellCoin;
@dynamic account;

@end
