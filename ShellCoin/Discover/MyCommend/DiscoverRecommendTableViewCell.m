//
//  IntergralRecordTableViewCell.m
//  ShellCoin
//
//  Created by Guo on 2017/3/23.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "DiscoverRecommendTableViewCell.h"
#import "CountDown.h"


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

@interface DiscoverRecommendTableViewCell()
@property (strong, nonatomic)  CountDown *countDown;


@property (nonatomic, assign)NSTimeInterval tempTime;

@end
@implementation DiscoverRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.textColor = MacoDetailColor;
    self.moneyLabel.textColor = MacoColor;
    self.statusLabel.textColor = MacoColor;
    self.tempTime = 0;

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
//        self.timeLabel.text = _dataModel.tranTime;
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
//    NSTimeInterval interval=[_dataModel.endTime longLongValue] / 1000.0;
//    NSTimeInterval interval = 1498629853;
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
//    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
//    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    __weak DiscoverRecommendTableViewCell *weak_self = self;
////    NSTimeInterval nowInterval= _dataModel.systmTime/1000;
//    NSTimeInterval nowInterval= 1495692253;
//    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:nowInterval];
//    self.tempTime =[date timeIntervalSinceDate:nowDate];
//    [self.countDown countDownWithPER_SECBlock:^{
//        [weak_self getNowTimeWithStringEndTime];
//        weak_self.tempTime --;
//    }];

}

- (CountDown *)countDown
{
    if (!_countDown) {
        _countDown = [[CountDown alloc]init];
    }
    return _countDown;
}

#pragma mark - 倒计时计数
-( void)getNowTimeWithStringEndTime{
    
    
    int days = (int)(self.tempTime/(3600*24));
    int hours = (int)((self.tempTime-days*24*3600)/3600);
    int minutes = (int)(self.tempTime-days*24*3600-hours*3600)/60;
    int seconds = self.tempTime-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0&&days<=0) {
        [self.countDown destoryTimer];
        self.timeLabel.text = @"活动已结束";
        [self.countDown destoryTimer];
        return;
    }
    if (days) {
        self.timeLabel.text = [NSString stringWithFormat:@"%@天%@小时%@分%@秒", dayStr,hoursStr, minutesStr,secondsStr];
        return;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@小时%@分%@秒",hoursStr , minutesStr,secondsStr];
}
@end
