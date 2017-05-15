//
//  LoanOtherTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/5/11.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "LoanOtherTableViewCell.h"

@implementation LoanAuditOrFailModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    LoanAuditOrFailModel *model = [[LoanAuditOrFailModel alloc]init];
    model.loanId = NullToSpace(dic[@"id"]);
    model.createTime = NullToSpace(dic[@"createTime"]);
    model.type = NullToNumber(dic[@"type"]);

    return model;
}

@end

@implementation LoanOtherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(LoanAuditOrFailModel *)dataModel
{
    _dataModel = dataModel;
    switch ([_dataModel.type integerValue]) {
        case 1:
            self.sortLabel.text = @"购房";
            break;
        case 2:
            self.sortLabel.text = @"购车";
            break;
        case 3:
            self.sortLabel.text = @"其他";
            break;
            
        default:
            break;
    }

    self.timeLabel.text = [NSString stringWithFormat:@"申请时间：%@",_dataModel.createTime];
}


@end
