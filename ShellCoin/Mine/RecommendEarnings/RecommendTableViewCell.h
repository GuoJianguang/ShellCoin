//
//  RecommendTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendModel : BaseModel
/**
 * 时间
 */
@property (nonatomic, copy)NSString *tranTime;
/**
 * 手机号
 */
@property (nonatomic, copy)NSString *phone;
/*
* 金额
*/

@property (nonatomic, copy)NSString *tranAmount;
/**
 * 总收益金额
 */
@property (nonatomic, copy)NSString *totalqueryAmount;
@end

@interface RecommendTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (nonatomic, strong)RecommendModel *dataModel;

@end
