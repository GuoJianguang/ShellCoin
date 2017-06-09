//
//  RecommendDetailTableViewCell.h
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecommendMerchantModel : BaseModel
@property (nonatomic, copy)NSString *mchCode;
@property (nonatomic, copy)NSString *mchName;

@end

@interface ConsumersModel : BaseModel
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *phone;
@end

@interface RecommendDetailTableViewCell : BaseTableViewCell


@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
@property (weak, nonatomic) IBOutlet UIView *itemView;

@property (nonatomic, strong)RecommendMerchantModel *merchantModel;
@property (nonatomic, strong)ConsumersModel *consumersModel;

@end
