//
//  MerchantModel.m
//  ShellCoin
//
//  Created by Guo on 2017/3/27.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MerchantModel.h"

@implementation MerchantModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    MerchantModel *model = [[MerchantModel alloc]init];
    model.address = NullToSpace(dic[@"address"]);
    model.code = NullToSpace(dic[@"code"]);
    model.desc = NullToSpace(dic[@"desc"]);
    model.highQuality = NullToSpace(dic[@"highQuality"]);
    model.longitude = NullToSpace(dic[@"longitude"]);
    model.name = NullToSpace(dic[@"name"]);
    model.phone = NullToSpace(dic[@"phone"]);
    model.pic = NullToSpace(dic[@"pic"]);
    model.latitude = NullToSpace(dic[@"latitude"]);
    model.recommend = NullToNumber(dic[@"recommend"]);
    if ([dic[@"slidePic"] isKindOfClass:[NSArray class]]) {
        model.slidePic = dic[@"slidePic"];
    }else{
        model.slidePic = @[@""];
        
    }
    model.trade = NullToSpace(dic[@"trade"]);
    model.keyword = NullToSpace(dic[@"keyword"]);
    model.distance = NullToSpace(dic[@"distance"]);
    return model;
}

- (NSArray *)slidePic
{
    if (!_slidePic) {
        _slidePic = [NSArray array];
    }
    return _slidePic;
}
@end
