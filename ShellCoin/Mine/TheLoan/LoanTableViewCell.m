//
//  LoanTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/4/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "LoanTableViewCell.h"

@implementation LoanModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    LoanModel *model = [[LoanModel alloc]init];
    model.loanId = NullToSpace(dic[@"id"]);
    model.type = NullToNumber(dic[@"type"]);
    model.startDay = NullToSpace(dic[@"startDay"]);
    model.endDay = NullToSpace(dic[@"endDay"]);
    model.repayDay = NullToSpace(dic[@"repayDay"]);
    model.repayAmount = NullToNumber(dic[@"repayAmount"]);
    model.consumeAmount = NullToSpace(dic[@"consumeAmount"]);
    model.enoughFlag = NullToNumber(dic[@"enoughFlag"]);
    return model;
}

@end


@implementation LoanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.progerssView.layer.borderColor = [UIColor colorFromHexString:@"#ffd862"].CGColor;
//    self.progerssView.layer.borderWidth = 1;
    self.progerssView.layer.cornerRadius = 4;
    self.progerssView.layer.masksToBounds = YES;
    self.progerssView.trackTintColor = [UIColor whiteColor];
    self.alerTimeLabel.adjustsFontSizeToFitWidth = self.progressLabel.adjustsFontSizeToFitWidth = self.timeLabel.adjustsFontSizeToFitWidth = YES;
    self.moneLabel.adjustsFontSizeToFitWidth = self.loanSortlabel.adjustsFontSizeToFitWidth=YES;
    self.loanSortlabel.adjustsFontSizeToFitWidth = YES;
    
}

- (void)setDataModel:(LoanModel *)dataModel
{
    _dataModel = dataModel;
    switch ([_dataModel.type integerValue]) {
        case 1:
            self.loanSortlabel.text = @"购房";
            break;
        case 2:
            self.loanSortlabel.text = @"购车";
            break;
        case 3:
            self.loanSortlabel.text = @"其他";
            break;
            
        default:
            break;
    }
    self.loanSortlabel.text = @"消费抵月供";

    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",_dataModel.startDay,_dataModel.endDay];
    self.moneLabel.text = [NSString stringWithFormat:@"%.2f",[_dataModel.repayAmount doubleValue]];
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f/%.2f",[_dataModel.consumeAmount doubleValue],[_dataModel.repayAmount doubleValue]];
    self.alerTimeLabel.text = [NSString stringWithFormat:@"还款日：%@号",_dataModel.repayDay];
    self.progerssView.progress = [_dataModel.consumeAmount doubleValue]/[_dataModel.repayAmount doubleValue];

    if ([_dataModel.enoughFlag isEqualToString:@"0"]) {
        self.isCompletImageView.hidden = YES;
    }else{
        self.isCompletImageView.hidden = NO;
    }

}

- (void)setProessColor:(UIColor *)proessColor
{
    _proessColor = proessColor;
    self.progerssView.progressTintColor =_proessColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
