//
//  LoanTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/4/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoanModel : BaseModel
@property (nonatomic,copy)NSString *loanId;
/**
 * 类型 1购房  2购车  3其他
 */

@property (nonatomic,copy)NSString *type;
/**
 * 贷款开始时间
 */

@property (nonatomic,copy)NSString *startDay;
/**
 * 贷款结束时间
 */

@property (nonatomic,copy)NSString *endDay;
/**
 * 月供金额
 */

@property (nonatomic,copy)NSString *repayAmount;
/**
 * 已经消费的金额
 */

@property (nonatomic,copy)NSString *consumeAmount;
/**
 * 0没达到月供金额 1已经达到月供金额
 */

@property (nonatomic,copy)NSString *enoughFlag;
/**
 * 还款日
 */
@property (nonatomic,copy)NSString *repayDay;

@end

@interface LoanTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *loanSortlabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneLabel;
@property (weak, nonatomic) IBOutlet UILabel *symbollabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progerssView;
@property (weak, nonatomic) IBOutlet UILabel *alerTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIImageView *isCompletImageView;

@property (nonatomic,strong)LoanModel *dataModel;


@property (nonatomic, strong)UIColor *proessColor;


@end
