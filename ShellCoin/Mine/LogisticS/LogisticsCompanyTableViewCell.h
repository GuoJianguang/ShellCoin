//
//  LogisticsCompanyTableViewCell.h
//  tiantianxin
//
//  Created by ttx on 16/4/18.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BuyRecodeModel;



@interface LogisticsCompanyTableViewCell : BaseTableViewCell


@property (weak, nonatomic) IBOutlet UILabel *logisticsCLabel;

@property (nonatomic, strong)BuyRecodeModel *dataModel;

@property (weak, nonatomic) IBOutlet UILabel *alerLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
