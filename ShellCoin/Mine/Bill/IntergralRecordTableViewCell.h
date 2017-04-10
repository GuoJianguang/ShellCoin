//
//  IntergralRecordTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillIntegaralModel.h"

@interface FanxianModel : BaseModel

/**
 * 让利回馈记录单号
 */
@property (nonatomic,copy)NSString *fanxianId;
/**
 * 让利回馈时间
 */
@property (nonatomic,copy)NSString *tranTime;
/**
 * 让利回馈金额
 */
@property (nonatomic,copy)NSString *amount;

/*
购物券金额
 */
@property (nonatomic,copy)NSString *consumeBalance;

@property (nonatomic, copy)NSString *descript;

@end

@interface IntergralRecordTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, strong)BillIntegaralModel *integaralModel;

@property (nonatomic, strong)IntegralShellCoinModel *shellCoinModel;


@property (nonatomic, strong)FanxianModel *dataModel;
@end
