//
//  IntergralRecordTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "DiscoverRecommendTableViewCell.h"

@implementation DiscoverRecommendModel

+ (id)modelWithDic:(NSDictionary *)dic
{
    DiscoverRecommendModel *model = [[DiscoverRecommendModel alloc]init];
    model.tranTime  = NullToSpace(dic[@"tranTime"]);
    model.amount = NullToNumber(dic[@"amount"]);
    model.phone = NullToSpace(dic[@"phone"]);
    model.number = NullToNumber(dic[@"number"]);
    model.state = NullToNumber(dic[@"state"]);
    model.descript = NullToSpace(dic[@"descript"]);

    return model;
}

@end


@implementation DiscoverRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.textColor = MacoDetailColor;
    self.moneyLabel.textColor = MacoColor;
    self.statusLabel.textColor = MacoColor;
    
    self.timeLabel.adjustsFontSizeToFitWidth = self.statusLabel.adjustsFontSizeToFitWidth = self.moneyLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataModel:(DiscoverRecommendModel *)dataModel
{
    _dataModel = dataModel;
    self.markLabel.text = [NSString stringWithFormat:@"%@*%@",_dataModel.phone,_dataModel.number];
        self.timeLabel.text = _dataModel.tranTime;
//        switch ([_dataModel.state integerValue]) {
//            case 1:
//            {
//                self.statusLabel.text = [NSString stringWithFormat:@"消费¥%@",_shellCoinModel.tranAmount];
//                self.moneyLabel.text = [NSString stringWithFormat:@"+%@积分",_shellCoinModel.shellsAmount];
//            }
//                break;
//            case 2:
//            {
//                self.statusLabel.text = [NSString stringWithFormat:@"抵换¥%@",_shellCoinModel.tranAmount];
//                self.moneyLabel.text = [NSString stringWithFormat:@"-%@积分",_shellCoinModel.shellsAmount];
//    
//            }
//                break;
//            case 3:
//            {
//                self.statusLabel.text = [NSString stringWithFormat:@"积分支付¥%@",_shellCoinModel.tranAmount];
//                self.moneyLabel.text = [NSString stringWithFormat:@"-%@积分",_shellCoinModel.shellsAmount];
//            }
//                break;
//            default:
//                break;
//        }
    

}

//- (void)setShellCoinModel:(DiscoverRecommendModel *)shellCoinModel
//{
//    _shellCoinModel = shellCoinModel;
//    self.markLabel.text = _shellCoinModel.mchName;
//    self.timeLabel.text = _shellCoinModel.time;
//    switch ([_shellCoinModel.tranType integerValue]) {
//        case 1:
//        {
//            self.statusLabel.text = [NSString stringWithFormat:@"消费¥%@",_shellCoinModel.tranAmount];
//            self.moneyLabel.text = [NSString stringWithFormat:@"+%@积分",_shellCoinModel.shellsAmount];
//        }
//            break;
//        case 2:
//        {
//            self.statusLabel.text = [NSString stringWithFormat:@"抵换¥%@",_shellCoinModel.tranAmount];
//            self.moneyLabel.text = [NSString stringWithFormat:@"-%@积分",_shellCoinModel.shellsAmount];
//            
//        }
//            break;
//        case 3:
//        {
//            self.statusLabel.text = [NSString stringWithFormat:@"积分支付¥%@",_shellCoinModel.tranAmount];
//            self.moneyLabel.text = [NSString stringWithFormat:@"-%@积分",_shellCoinModel.shellsAmount];
//        }
//            break;
//        default:
//            break;
//    }
//
//}


@end
