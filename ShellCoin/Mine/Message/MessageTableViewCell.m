//
//  MessageTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MessageTableViewCell.h"


@implementation MessafeModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    MessafeModel *model = [[MessafeModel alloc]init];
    model.messageid = NullToSpace(dic[@"id"]);
    model.title = NullToSpace(dic[@"title"]);
    model.content = NullToSpace(dic[@"content"]);
    model.createTime = NullToSpace(dic[@"createTime"]);
    model.type = NullToSpace(dic[@"type"]);
    model.state = NullToNumber(dic[@"state"]);
    
    return model;
}

@end
@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.markImageView.layer.cornerRadius = 3;
    self.markImageView.layer.masksToBounds = YES;
    self.markImageView.backgroundColor = MacoColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(MessafeModel *)dataModel
{
    _dataModel = dataModel;
    self.nameLabel.text = _dataModel.title;
    self.timeLabel.text = [NSString stringWithFormat:@"%@", _dataModel.createTime];
    switch ([_dataModel.state integerValue]) {
        case 0:
            self.markImageView.hidden = NO;
            self.timeLabel.textColor = MacoDetailColor;
            self.nameLabel.textColor = MacoTitleColor;
            break;
        case 1:
            self.timeLabel.textColor = MacoDetailColor;
            self.nameLabel.textColor = MacoDetailColor;
            self.markImageView.hidden = YES;
            break;
            
        default:
            break;
    }
    
}



@end
