//
//  SureDiscoverOrderViewController.h
//  ShellCoin
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "SureDiscoverOrderTableViewCell.h"
#import "AddressTableViewCell.h"


@interface SureDiscoverOrderViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(UIButton *)sender;

@property (nonatomic, copy)NSString *goodsId;

@property (nonatomic, assign)NSInteger number;

@property (nonatomic, strong)DiscoverGoodsDetailModel *dataModel;

@property (nonatomic, strong)ShippingAddressModel *addressmodel;

@end
