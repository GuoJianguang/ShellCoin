//
//  BillTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BuyRecodeModel : BaseModel
@property (nonatomic,copy)NSString *goodsName;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *amount;
@property (nonatomic,copy)NSString *count;
@property (nonatomic,copy)NSString *buyId;
/**
 * 0未发货  1已发货
 */

@property (nonatomic,copy)NSString *deliverFlag;
/**
 * 快递公司
 */

@property (nonatomic,copy)NSString *logisticsCompany;
/**
 * 快递单号
 */

@property (nonatomic,copy)NSString *logisticsNumber;
/**
 * 快递公司编号
 */

@property (nonatomic,copy)NSString *logisticsCompanyCode;

@end

@interface BuyRecodTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@property (weak, nonatomic) IBOutlet UIButton *checkLogisticBtn;
- (IBAction)checkLogisticBtn:(UIButton *)sender;

@property (nonatomic, strong)BuyRecodeModel *dataModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enterWidth;
@property (weak, nonatomic) IBOutlet UIImageView *iconEnter;

@end
