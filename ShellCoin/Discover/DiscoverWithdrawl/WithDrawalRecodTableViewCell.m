//
//  BillTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "WithDrawalRecodTableViewCell.h"

@implementation WithDrawalRecodModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    WithDrawalRecodModel *model = [[WithDrawalRecodModel alloc]init];
    model.time  = NullToSpace(dic[@"tranTime"]);
    model.amount = NullToNumber(dic[@"balanceAmount"]);
    return model;
}

@end

@implementation WithDrawalRecodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.textColor = MacoDetailColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setDataModel:(WithDrawalRecodModel *)dataModel
{
    _dataModel = dataModel;
    self.timeLabel.text = _dataModel.time;
    self.moneyLabel.text = [NSString stringWithFormat:@"+¥%.2f",[_dataModel.amount doubleValue]];
}
@end
