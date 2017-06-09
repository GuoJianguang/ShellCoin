//
//  LogisticsDetailTableViewCell.m
//  tiantianxin
//
//  Created by ttx on 16/4/18.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "LogisticsDetailTableViewCell.h"


@implementation LogisticsModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    LogisticsModel *model = [[LogisticsModel alloc]init];
    model.acceptTime = NullToSpace(dic[@"AcceptTime"]);
    model.acceptStation = NullToSpace(dic[@"AcceptStation"]);
    return model;
}

@end


@implementation LogisticsDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.contentView.backgroundColor = [UIColor whiteColor];
    self.itemView.backgroundColor = [UIColor whiteColor];
//    self.itemView.layer.cornerRadius = 5;
    
    self.timeLabel.textColor = [UIColor colorFromHexString:@"#999999"];
    self.logisticsDeatilLabel.textColor = [UIColor colorFromHexString:@"#999999"];
//    self.lineView.backgroundColor = [UIColor colorFromHexString:@"#cfdbe4"];
   
    self.upView.backgroundColor = [UIColor colorFromHexString:@"#999999"];
    self.downView.backgroundColor = [UIColor colorFromHexString:@"#999999"];
}
- (void)setDataModel:(LogisticsModel *)dataModel
{
    _dataModel = dataModel;
    self.timeLabel.text = _dataModel.acceptTime;
    self.logisticsDeatilLabel.text = _dataModel.acceptStation;
}

- (void)setIsLastItem:(BOOL)isLastItem
{
    _isLastItem = isLastItem;
    if (_isLastItem) {
        self.timeLabel.textColor = MacoColor;
        self.logisticsDeatilLabel.textColor = MacoColor;
        self.stautsImage.image = [UIImage imageNamed:@"icon_dangqian"];
    }else{
        self.stautsImage.image = [UIImage imageNamed:@"icon_huise"];

    }
}

@end
