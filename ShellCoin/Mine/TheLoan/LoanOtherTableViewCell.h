//
//  LoanOtherTableViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanAuditOrFailModel : BaseModel
/**
 * 类型 1购房  2购车  3其他
 */

@property (nonatomic,copy)NSString *type;
/**
 * 贷款id
 */

@property (nonatomic,copy)NSString *loanId;
/**
 * 申请时间
 */

@property (nonatomic,copy)NSString *createTime;


@end

@interface LoanOtherTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *sortLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (nonatomic, strong)LoanAuditOrFailModel *dataModel;

@end
