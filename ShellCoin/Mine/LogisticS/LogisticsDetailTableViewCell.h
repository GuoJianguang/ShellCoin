//
//  LogisticsDetailTableViewCell.h
//  tiantianxin
//
//  Created by ttx on 16/4/18.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogisticsModel : BaseModel
@property (nonatomic, copy)NSString *acceptStation;
@property (nonatomic, copy)NSString *acceptTime;

@end


@interface LogisticsDetailTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *itemView;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *logisticsDeatilLabel;

@property (weak, nonatomic) IBOutlet UIView *upView;

@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UIImageView *stautsImage;

@property (nonatomic, strong)LogisticsModel *dataModel;

@property (nonatomic, assign)BOOL isLastItem;


@property (weak, nonatomic) IBOutlet UIView *firstLineView;


@end
