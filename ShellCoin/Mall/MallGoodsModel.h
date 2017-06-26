//
//  MallGoodsModel.h
//  ShellCoin
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface MallGoodsModel : BaseModel

@property (nonatomic, copy)NSString *coverImage;
@property (nonatomic, copy)NSString *detailUrl;
@property (nonatomic, copy)NSString *goodsId;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *saleCount;

@property (nonatomic, copy)NSString *recommend;

@end
