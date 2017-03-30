//
//  RecommendTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "RecommendTableViewCell.h"

@implementation RecommendModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    RecommendModel *model = [[RecommendModel alloc]init];
    model.tranTime = NullToSpace(dic[@"tranTime"]);
    model.phone = NullToSpace(dic[@"phone"]);
    model.tranAmount = NullToSpace(dic[@"tranAmount"]);
    model.totalqueryAmount = NullToNumber(dic[@"totalqueryAmount"]);
    return model;
}

@end

@implementation RecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.moneyLabel.textColor = MacoColor;
    self.timeLabel.textColor = MacoDetailColor;
    self.markLabel.textColor = MacoTitleColor;
    
}

- (void)setDataModel:(RecommendModel *)dataModel
{
    _dataModel = dataModel;
    self.markLabel.text = _dataModel.phone;
    self.timeLabel.text = _dataModel.tranTime;
    self.moneyLabel.text = [NSString stringWithFormat:@"+¥%@",_dataModel.tranAmount];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
