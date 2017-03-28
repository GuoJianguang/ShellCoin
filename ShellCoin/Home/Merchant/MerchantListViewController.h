//
//  MerchantListViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/27.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "SortButtonSwitchView.h"

@interface MerchantListViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)searchBtn:(id)sender;

@property (weak, nonatomic) IBOutlet SortButtonSwitchView *sortView;


//当前城市
@property (nonatomic, strong)NSString *currentCity;
//关键字
@property (nonatomic, strong)NSString *keyWord;
//当前选择行业
@property (nonatomic, strong)NSString *currentIndustry;

//首页活动id
@property (nonatomic, strong)NSString *seqId;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
