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

@end

@interface BuyRecodTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;



@property (nonatomic, strong)BuyRecodeModel *dataModel;

@end
