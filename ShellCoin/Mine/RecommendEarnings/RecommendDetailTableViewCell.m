//
//  RecommendDetailTableViewCell.m
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "RecommendDetailTableViewCell.h"

@implementation RecommendMerchantModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    RecommendMerchantModel *model = [[RecommendMerchantModel alloc]init];
    model.mchCode = NullToSpace(dic[@"mchCode"]);
    model.mchName = NullToSpace(dic[@"mchName"]);
    return model;
}

@end


@implementation ConsumersModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    ConsumersModel *model = [[ConsumersModel alloc]init];
    model.userId = NullToSpace(dic[@"userId"]);
    model.phone = NullToSpace(dic[@"phone"]);
    return model;
}

@end
@implementation RecommendDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.recommendLabel.textColor = MacoTitleColor;
    self.recommendLabel.adjustsFontSizeToFitWidth = YES;
    self.itemView.backgroundColor = [UIColor whiteColor];
    self.itemView.layer.masksToBounds = YES;
}


- (void)setMerchantModel:(RecommendMerchantModel *)merchantModel
{
    _merchantModel = merchantModel;
    self.recommendLabel.text = _merchantModel.mchName;
}

- (void)setConsumersModel:(ConsumersModel *)consumersModel
{
    _consumersModel = consumersModel;
    self.recommendLabel.text = [NSString stringWithFormat:@"%@消费者",_consumersModel.phone];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
