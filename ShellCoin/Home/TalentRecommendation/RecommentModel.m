//
//  RecommentModel.m
//  ShellCoin
//
//  Created by Guo on 2017/3/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RecommentModel.h"

@implementation RecommentModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    RecommentModel *model = [[RecommentModel alloc]init];
    model.seqId = NullToSpace(dic[@"seqId"]);
    model.name = NullToSpace(dic[@"name"]);
    model.coverImg = NullToSpace(dic[@"coverImg"]);
    model.jumpWay = NullToSpace(dic[@"jumpWay"]);
    model.jumpValue = NullToSpace(dic[@"jumpValue"]);
    model.remark = NullToSpace(dic[@"remark"]);
    return model;
}

@end
