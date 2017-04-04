//
//  MessageDetailTableViewCell.m
//  TTXForConsumer
//
//  Created by ttx on 16/6/29.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "MessageDetailTableViewCell.h"

@implementation MessageDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.time_label.textColor = MacoIntrodouceColor;
    self.detail_label.textColor = MacoDetailColor;
    self.titel_label.textColor = MacoTitleColor;
    self.contentView.backgroundColor = [UIColor whiteColor];
}


- (void)setDataModel:(MessafeModel *)dataModel
{
    _dataModel = dataModel;
    self.titel_label.text = _dataModel.title;
    self.detail_label.text = _dataModel.content;
    self.time_label.text = [NSString stringWithFormat:@"%@", _dataModel.createTime];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
