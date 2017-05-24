//
//  BillTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BuyRecodTableViewCell.h"

@implementation BuyRecodeModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    BuyRecodeModel *model = [[BuyRecodeModel alloc]init];
    model.time  = NullToSpace(dic[@"tranTime"]);
    model.amount = NullToNumber(dic[@"balanceAmount"]);
    model.count = NullToNumber(dic[@"count"]);
    model.goodsName = NullToNumber(dic[@"goodsName"]);
    return model;
}

@end

@implementation BuyRecodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.textColor = MacoDetailColor;
    self.moneyLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setDataModel:(BuyRecodeModel *)dataModel
{
    _dataModel = dataModel;
    self.moneyLabel.text = [NSString stringWithFormat:@"+¥%.2f",[_dataModel.amount doubleValue]];
    self.timeLabel.text = _dataModel.time;
    self.markLabel.text = [NSString stringWithFormat:@"%@*%@",_dataModel.goodsName,_dataModel.count];
    
}

@end
