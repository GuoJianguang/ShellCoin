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
    model.consumeAmunt = NullToSpace(dic[@"consumeAmunt"]);
    model.enoughFlag = NullToNumber(dic[@"enoughFlag"]);
    return model;
}

@end


@implementation LoanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.progerssView.layer.borderColor = [UIColor colorFromHexString:@"#ffd862"].CGColor;
    self.progerssView.layer.borderWidth = 1;
    self.progerssView.layer.cornerRadius = 5;
    self.progerssView.progressTintColor =MacoColor;
    self.progerssView.layer.masksToBounds = YES;
    self.progerssView.trackTintColor = [UIColor whiteColor];
    
    self.progerssView.progress = 1;
}

- (void)setDataModel:(LoanModel *)dataModel
{
    _dataModel = dataModel;
    switch ([_dataModel.type integerValue]) {
        case 1:
            self.loanSortlabel.text = @"购房贷款";
            break;
        case 2:
            self.loanSortlabel.text = @"购车贷款";
            break;
        case 3:
            self.loanSortlabel.text = @"其他贷款";
            break;
            
        default:
            break;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",_dataModel.startDay,_dataModel.endDay];
    self.moneLabel.text = [NSString stringWithFormat:@"%.2f",[_dataModel.repayAmount doubleValue]];
    self.progressLabel.text = [NSString stringWithFormat:@"%.2f/%.2f",[_dataModel.consumeAmunt doubleValue],[_dataModel.repayAmount doubleValue]];
    self.alerTimeLabel.text = [NSString stringWithFormat:@"每月还款日：%@号",_dataModel.repayDay];
    self.progerssView.progress = [_dataModel.consumeAmunt doubleValue]/[_dataModel.repayAmount doubleValue];
    
    if ([_dataModel.enoughFlag isEqualToString:@"0"]) {
        self.isCompletImageView.hidden = NO;
    }else{
        self.isCompletImageView.hidden = YES;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
