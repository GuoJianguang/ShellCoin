//
//  MerchantModel.h
//  ShellCoin
//
//  Created by Guo on 2017/3/27.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface MerchantModel : BaseModel
@property (nonatomic, copy)NSString *address;
@property (nonatomic, copy)NSString *code;
@property (nonatomic, copy)NSString *desc;
//判断是否是优质商家
@property (nonatomic, copy)NSString *highQuality;
@property (nonatomic, copy)NSString *keyword;
@property (nonatomic, copy)NSString *latitude;
@property (nonatomic, copy)NSString *longitude;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *recommend;
@property (nonatomic, copy)NSArray *slidePic;
//行业
@property (nonatomic, copy)NSString *trade;

//判断是否是通过搜索出来的结果
@property (nonatomic, assign)BOOL isSearchResult;

@property (nonatomic, copy)NSString *userCollectionFlag;

@property (nonatomic, copy)NSString *distance;
@end
