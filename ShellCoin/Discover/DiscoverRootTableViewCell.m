//
//  DiscoverRootTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "DiscoverRootTableViewCell.h"
#import "DiscoverCollectionViewCell.h"
#import "DiscoverWithdrawalViewController.h"
#import "BuyRecodViewController.h"
#import "DiscovergoodsDetailViewController.h"
#import "MyRecommendViewController.h"
#import "CountDown.h"

@interface DiscoverRootTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic)  CountDown *countDown;


@property (nonatomic, assign)NSTimeInterval tempTime;
@end
@implementation DiscoverRootTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.notConsumersView.hidden = YES;
    
    self.checkRecommendView.hidden = self.withDrawlBtn.hidden = self.earnings.hidden = self.earningsLabel.hidden = !self.notConsumersView.hidden;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = YES;
    
    self.alerView.layer.cornerRadius = 19;
    self.alerView.layer.masksToBounds = YES;
    self.alerLabel.adjustsFontSizeToFitWidth = YES;
    self.alerLabel.textColor =MacoTitleColor;
    self.alerLabel.text  =@"99元购物金   28天10小时13分29秒到账";
    self.tempTime = 0;
//    NSTimeInterval interval=[_dataModel.endTime longLongValue] / 1000.0;
    NSTimeInterval interval = 1498629853;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    __weak DiscoverRootTableViewCell *weak_self = self;
//    NSTimeInterval nowInterval= _dataModel.systmTime/1000;
    NSTimeInterval nowInterval= 1495692253;
    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:nowInterval];
    self.tempTime =[date timeIntervalSinceDate:nowDate];
    [self.countDown countDownWithPER_SECBlock:^{
        [weak_self getNowTimeWithStringEndTime];
        weak_self.tempTime --;
    }];
    
}
- (CountDown *)countDown
{
    if (!_countDown) {
        _countDown = [[CountDown alloc]init];
    }
    return _countDown;
}

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
        self.alerLabel.text = @"活动已结束";
        [self.countDown destoryTimer];
        return;
    }
    if (days) {
        self.alerLabel.text = [NSString stringWithFormat:@"%@天%@小时%@分%@秒", dayStr,hoursStr, minutesStr,secondsStr];
        return;
    }
    self.alerLabel.text = [NSString stringWithFormat:@"%@小时%@分%@秒",hoursStr , minutesStr,secondsStr];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buyRecodeBtn:(UIButton *)sender {
    BuyRecodViewController *buyRecodVC = [[BuyRecodViewController alloc]init];
    [self.viewController.navigationController pushViewController:buyRecodVC animated:YES];
}

- (IBAction)helpBtn:(UIButton *)sender {
    
}
- (IBAction)notConsumerBtn:(UIButton *)sender {
    
}
- (IBAction)checkRecommendBtn:(UIButton *)sender {
    MyRecommendViewController *recommendVC = [[MyRecommendViewController alloc]init];
    [self.viewController.navigationController pushViewController:recommendVC animated:YES];
}
- (IBAction)withDrawlBtn:(UIButton *)sender {
    DiscoverWithdrawalViewController *withDrawalVC = [[DiscoverWithdrawalViewController alloc]init];
    [self.viewController.navigationController pushViewController:withDrawalVC animated:YES];
    
}
#pragma mark - collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier =[DiscoverCollectionViewCell indentify];
    static BOOL nibri =NO;
    if(!nibri)
    {
        UINib *nib = [DiscoverCollectionViewCell newCell];
        [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
        nibri =YES;
    }
    DiscoverCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiscovergoodsDetailViewController *detailVC = [[DiscovergoodsDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (self.sortDataSouceArray.count < 5) {
    //        return CGSizeMake(TWitdh/self.sortDataSouceArray.count, 50);
    //    }
    return CGSizeMake(TWitdh, collectionView.bounds.size.height);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}




@end
