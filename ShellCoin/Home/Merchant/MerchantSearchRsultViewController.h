//
//  MerchantSearchRsultViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface MerchantSearchRsultViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//当前城市
@property (nonatomic, strong)NSString *currentCity;
//关键字
@property (nonatomic, strong)NSString *keyWord;
//当前选择行业
@property (nonatomic, strong)NSString *currentIndustry;

//首页活动id
@property (nonatomic, strong)NSString *seqId;

@end
