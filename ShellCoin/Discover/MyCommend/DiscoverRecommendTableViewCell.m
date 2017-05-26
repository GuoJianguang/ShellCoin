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
    model.tranTime  = NullToSpace(dic[@"accountTime"]);
    model.amount = NullToNumber(dic[@"amount"]);
    model.phone = NullToSpace(dic[@"phone"]);
    model.number = NullToNumber(dic[@"buyNum"]);
    model.state = NullToNumber(dic[@"state"]);
    model.descript = NullToSpace(dic[@"descript"]);
    model.type = NullToNumber(dic[@"type"]);
    model.accountTimeTamp = NullToNumber(dic[@"accountTimeTamp"]);
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
    self.moneyLabel.text =[NSString stringWithFormat:@"¥%.2f",[_dataModel.amount doubleValue]];
    switch ([_dataModel.type integerValue]) {
        case 1://返本收益
        {
            switch ([_dataModel.state integerValue]) {
                case 0://未到账
                {
                    self.statusLabel.text = @"激活返本";
                    self.statusLabel.textColor = self.moneyLabel.textColor = [UIColor colorFromHexString:@"#2586d5"];
                    self.markImageView.image = [UIImage imageNamed:@"pic_state_blue"];
                    NSTimeInterval interval=[_dataModel.accountTimeTamp longLongValue] / 1000.0;
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
                    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
                    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    __weak DiscoverRecommendTableViewCell *weak_self = self;
                    NSTimeInterval nowInterval= [_dataModel.sysTime longLongValue]/1000;
                    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:nowInterval];
                    self.tempTime =[date timeIntervalSinceDate:nowDate];
                    [self.countDown countDownWithPER_SECBlock:^{
                        [weak_self getNowTimeWithStringEndTime];
                        
                        NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
                        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:self.timeLabel.text];
                        for (int i = 0; i < self.timeLabel.text.length; i ++) {
                            //这里的小技巧，每次只截取一个字符的范围
                            NSString *a = [self.timeLabel.text substringWithRange:NSMakeRange(i, 1)];
                            //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
                            if ([number containsObject:a]) {
                                [attributeString setAttributes:@{NSForegroundColorAttributeName:MacoColor,NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(i, 1)];
                            }
                        }
                        self.timeLabel.attributedText = attributeString;
                        weak_self.tempTime --;
                    }];
                    


                    
            }
                    break;
                case 1://已到账
                    self.statusLabel.text = @"激活返本";
                    
                    self.markImageView.image = [UIImage imageNamed:@"pic_state_yellow"];
                    self.statusLabel.textColor = self.moneyLabel.textColor = [UIColor colorFromHexString:@"#ff8335"];
                    break;
                default:
                    break;
            }
        }
            break;
        case 2://推荐收益
            self.statusLabel.text = @"推荐收益";
            self.statusLabel.textColor = self.moneyLabel.textColor = MacoColor;
            self.markImageView.image = [UIImage imageNamed:@"pic_state_red"];
            break;
            
        default:
            break;
    }



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
        self.timeLabel.text = @"已到账";
        [self.countDown destoryTimer];
        return;
    }
    if (days) {
        self.timeLabel.text = [NSString stringWithFormat:@"%@天%@小时%@分%@秒后到账", dayStr,hoursStr, minutesStr,secondsStr];
        return;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@小时%@分%@秒后到账",hoursStr , minutesStr,secondsStr];
}
@end
