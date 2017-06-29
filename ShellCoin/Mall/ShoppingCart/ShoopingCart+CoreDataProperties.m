//
//  ShoopingCart+CoreDataProperties.m
//  ShellCoin
//
//  Created by mac on 2017/6/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ShoopingCart+CoreDataProperties.h"

@implementation ShoopingCart (CoreDataProperties)

+ (NSFetchRequest<ShoopingCart *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ShoopingCart"];
}

@dynamic cash;
@dynamic coupons;
@dynamic goodsId;
@dynamic goodsName;
@dynamic goodsNum;
@dynamic goodsPrice;
@dynamic goodsSpec;
@dynamic shellCoin;
@dynamic goodsImage;
@dynamic goodsFreight;
@dynamic priceId;

@end
