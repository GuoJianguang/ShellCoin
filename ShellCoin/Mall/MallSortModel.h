//
//  MallSortModel.h
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseModel.h"

@interface MallSortModel : BaseModel

@property (nonatomic,copy)NSString *sortId;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *icon;

@property (nonatomic,assign)BOOL isSelect;
@end
