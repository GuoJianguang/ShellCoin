//
//  MessageTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessafeModel : BaseModel

/**
 * 消息id
 */
@property (nonatomic, copy)NSString *messageid;
/**
 * 标题
 */
@property (nonatomic, copy)NSString *title;
/**
 * 内容
 */
@property (nonatomic, copy)NSString *content;
/**
 * 创建时间
 */
@property (nonatomic, copy)NSString *createTime;
/**
 * 类型
 */
@property (nonatomic, copy)NSString *type;

/**
 * 消息是否已读
 */
@property (nonatomic, copy)NSString *state;


@end

@interface MessageTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong)MessafeModel *dataModel;


@end
