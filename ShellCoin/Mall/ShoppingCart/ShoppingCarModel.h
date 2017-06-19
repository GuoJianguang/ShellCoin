//
//  ShoppingCarModel.h
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface ShoppingCarModel : BaseModel

@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *goodsName;
@property (nonatomic, copy)NSString *goodsSpec;
@property (nonatomic, copy)NSString *goodsDetail;
@property (nonatomic, copy)NSString *goodsNum;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL isSelect;
@end
