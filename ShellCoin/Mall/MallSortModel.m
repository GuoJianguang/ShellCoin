//
//  MallSortModel.m
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MallSortModel.h"

@implementation MallSortModel


+ (id)modelWithDic:(NSDictionary *)dic
{
    MallSortModel *model = [[MallSortModel alloc]init];
    model.sortId = NullToSpace(dic[@"id"]);
    model.name = NullToSpace(dic[@"name"]);
    model.icon = NullToSpace(dic[@"icon"]);
    
    model.icon = [model.icon stringByReplacingOccurrencesOfString:@"," withString:@" "];
    /*处理空格*/
    
    NSCharacterSet *characterSet2 = [NSCharacterSet whitespaceCharacterSet];
    
    // 将string1按characterSet1中的元素分割成数组
    NSArray *array2 = [model.icon componentsSeparatedByCharactersInSet:characterSet2];
    
    model.icon = array2[0];
    return model;
}


@end
