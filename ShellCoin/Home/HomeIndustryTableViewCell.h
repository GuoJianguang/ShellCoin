//
//  HomeIndustryTableViewCell.h
//  TTXForConsumer
//
//  Created by Guo on 2017/2/14.
//  Copyright © 2017年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  NewHomeActivityModel: BaseModel

@property (nonatomic,copy)NSString *sortId;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *icon;

@end



@interface HomeIndustryTableViewCell : BaseTableViewCell

//不让每次都刷新
@property (nonatomic, assign)BOOL isAlreadyRefrefsh;

@property (nonatomic, strong)NSMutableArray *sortDataSouceArray;

@end
