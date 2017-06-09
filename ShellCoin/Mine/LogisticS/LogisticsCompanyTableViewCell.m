//
//  LogisticsCompanyTableViewCell.m
//  tiantianxin
//
//  Created by ttx on 16/4/18.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "LogisticsCompanyTableViewCell.h"
#import "BuyRecodTableViewCell.h"

@implementation LogisticsCompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    
    self.logisticsCLabel.textColor =  [UIColor colorFromHexString:@"#333333"];
    self.logisticsCLabel.adjustsFontSizeToFitWidth = YES;
    self.alerLabel.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5"];
    self.alerLabel.textColor = [UIColor colorFromHexString:@"#087db9"];
    self.alerLabel.layer.masksToBounds = YES;
    self.alerLabel.layer.cornerRadius = 3;
    self.lineView.backgroundColor =[UIColor colorFromHexString:@"#bfbfbf"];

}

- (void)setDataModel:(BuyRecodeModel *)dataModel
{
    _dataModel = dataModel;
    self.logisticsCLabel.text = [NSString stringWithFormat:@"快递公司： %@    快递号： %@",_dataModel.logisticsCompany,_dataModel.logisticsNumber];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
