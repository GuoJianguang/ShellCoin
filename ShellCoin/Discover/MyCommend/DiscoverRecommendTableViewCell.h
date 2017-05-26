//
//  IntergralRecordTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverRecommendModel : BaseModel

/**
 * 到账时间戳
 */

@property (nonatomic,copy)NSString *accountTimeTamp;
/**
 *时间
 */
@property (nonatomic,copy)NSString *tranTime;
/**
 * 金额
 */
@property (nonatomic,copy)NSString *amount;

/**
 * phone
 */
@property (nonatomic,copy)NSString *phone;
/**
 * number
 */
@property (nonatomic,copy)NSString *number;

/**
 * 0未到账  1已到账
 */

@property (nonatomic,copy)NSString *state;
/**
 *   1返本收益  2推荐收益
 */

@property (nonatomic,copy)NSString *type;

@property (nonatomic, copy)NSString *descript;

@property (nonatomic, copy)NSString *sysTime;

@end

@interface DiscoverRecommendTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;




@property (nonatomic, strong)DiscoverRecommendModel *dataModel;
@end
