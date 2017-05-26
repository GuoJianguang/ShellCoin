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
#import "DiscoverQrCodeViewController.h"
#import "RealnameViewController.h"
#import "EditBankInfoViewController.h"


@interface DiscoverRootTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,SwipeViewDelegate,SwipeViewDataSource>
@property (strong, nonatomic)  CountDown *countDown;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (nonatomic, strong)SwipeView *horizontalMarquee;
@property (nonatomic, strong)DiscoverGoodsModel *goodsModel;

@property (nonatomic, assign)NSInteger temp;
@end
@implementation DiscoverRootTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.notConsumersView.hidden = YES;
    self.earnings.adjustsFontSizeToFitWidth = YES;
    self.alerView.hidden = YES;
    self.checkRecommendView.hidden = self.withDrawlBtn.hidden = self.earnings.hidden = self.earningsLabel.hidden = !self.notConsumersView.hidden;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = YES;
    
    self.alerView.layer.cornerRadius = 19;
    self.alerView.layer.masksToBounds = YES;
    self.alerLabel.adjustsFontSizeToFitWidth = YES;
    self.alerLabel.textColor =MacoTitleColor;

    [self.collectionView noDataSouce];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.page = 1;
    [self getRequestisHeader:YES];
    self.temp = 0;
    
}
- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (SwipeView *)horizontalMarquee
{
    if (!_horizontalMarquee) {
        _horizontalMarquee = [[SwipeView alloc]initWithFrame:CGRectMake(38, 0, TWitdh-80, 38)];
        _horizontalMarquee.delegate = self;
        _horizontalMarquee.dataSource = self;
        _horizontalMarquee.vertical = YES;
    }
    return _horizontalMarquee;
}

#pragma mark - 设置当前商品的消费商信息
- (void)setDataModel:(DiscoverConsumersModel *)dataModel
{
    _dataModel  = dataModel;
            self.alerLabel.text = @"";
    switch ([_dataModel.userState integerValue]) {
        case 0://不是消费商
        {
            [self.horizontalMarquee removeFromSuperview];
            self.horizontalMarquee = nil;
            self.earnings.hidden = self.earningsLabel.hidden = self.withDrawlBtn.hidden = self.checkRecommendView.hidden = self.alerView.hidden = YES;
            self.notConsumersView.hidden = NO;
        }
            break;
        case 1://是消费商没有推荐别的用户
            [self.horizontalMarquee removeFromSuperview];
            self.horizontalMarquee = nil;
            self.earnings.hidden = self.earningsLabel.hidden = self.withDrawlBtn.hidden = self.checkRecommendView.hidden  = NO;
            self.notConsumersView.hidden = self.alerView.hidden=YES;
            self.earnings.text = @"¥0";
            self.checkRecommendLabel.text = @"推荐消费者返还购物金";
            break;
        case 2://是消费商有推荐别的用户
        {
            self.earnings.hidden = self.earningsLabel.hidden = self.withDrawlBtn.hidden = self.checkRecommendView.hidden = self.alerView.hidden = NO;
            self.notConsumersView.hidden = YES;
            self.earnings.text = [NSString stringWithFormat:@"¥%.2f",self.dataModel.avilableBalance];
            self.checkRecommendLabel.text = @"我的推荐";
            [self.horizontalMarquee removeFromSuperview];
            [self.alerView addSubview:self.horizontalMarquee];
            [self.horizontalMarquee reloadData];
            [[AutoScroller shareAutoScroller]autoSwipeView:self.horizontalMarquee WithPageView:[[UIPageControl alloc]init] WithDataSouceArray:self.dataModel.costRebateList];
        }
            break;
        default:
            break;
    }
}


#pragma mark - 获取所有商品
- (void)getRequestisHeader:(BOOL)isHeader
{
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"pageNo":@(self.page),
                            @"pageSize":@"100"};
    [HttpClient POST:@"find/goods/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            if (isHeader) {
                [self.dataSouceArray removeAllObjects];
            }
            NSArray *array =jsonObject[@"data"][@"data"];
            if (array.count > 0) {
                self.page ++;
            }
            for (NSDictionary *dic in array) {
                DiscoverGoodsModel *model = [DiscoverGoodsModel modelWithDic:dic];
                [self.dataSouceArray addObject:model];
            }
            //获取第一个商品的消费商信息
            [self getCoumerRequest:((DiscoverGoodsModel *)self.dataSouceArray[0]).goodsId];
            self.goodsModel = self.dataSouceArray[0];
            [self.collectionView judgeIsHaveDataSouce:self.dataSouceArray];
            [self.collectionView reloadData];
        }

    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [self.collectionView showNoDataSouceNoNetworkConnection];

    }];
}

#pragma mark - 获取每个商品的消费商信息

- (void)getCoumerRequest:(NSString *)goodsId
{
    [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeBlack];
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"goodsId":goodsId};
    [HttpClient POST:@"find/commissionUser/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [ShellCoinUserInfo shareUserInfos].discoverAvilableBalance = [NullToNumber(jsonObject[@"data"][@"avilableBalance"]) doubleValue];
            self.dataModel = [DiscoverConsumersModel modelWithDic:jsonObject[@"data"]];
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"消费商信息获取失败，请稍后重试" duration:2.];
        [SVProgressHUD dismiss];
    }];
}

- (CountDown *)countDown
{
    if (!_countDown) {
        _countDown = [[CountDown alloc]init];
    }
    return _countDown;
}

-( NSString *)getNowTimeWithStringEndTime:(NSInteger)tempTime{
    int days = (int)(tempTime/(3600*24));
    int hours = (int)((tempTime-days*24*3600)/3600);
    int minutes = (int)(tempTime-days*24*3600-hours*3600)/60;
    int seconds = tempTime-days*24*3600-hours*3600-minutes*60;
    
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
        [self.countDown destoryTimer];
        return @"已到账";
    }
    if (days) {
//        self.alerLabel.text = [NSString stringWithFormat:@"%@天%@小时%@分%@秒", dayStr,hoursStr, minutesStr,secondsStr];
        return [NSString stringWithFormat:@"%@天%@小时%@分%@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
//    self.alerLabel.text = [NSString stringWithFormat:@"%@小时%@分%@秒",hoursStr , minutesStr,secondsStr];
    return [NSString stringWithFormat:@"%@小时%@分%@秒",hoursStr , minutesStr,secondsStr];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - 购买记录

- (IBAction)buyRecodeBtn:(UIButton *)sender {
    BuyRecodViewController *buyRecodVC = [[BuyRecodViewController alloc]init];
    [self.viewController.navigationController pushViewController:buyRecodVC animated:YES];
}
#pragma mark - 帮助
- (IBAction)helpBtn:(UIButton *)sender {
    
}
#pragma mark - 没有消费商的时候
- (IBAction)notConsumerBtn:(UIButton *)sender {
    DiscovergoodsDetailViewController *detailVC = [[DiscovergoodsDetailViewController alloc]init];
    detailVC.goodsid = self.goodsModel.goodsId;
    detailVC.htmlUrl = self.goodsModel.htmlUrl;
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - 查看推荐

- (IBAction)checkRecommendBtn:(UIButton *)sender {
    if ([self.dataModel.userState isEqualToString:@"1"]) {
        DiscovergoodsDetailViewController *detailVC = [[DiscovergoodsDetailViewController alloc]init];
        detailVC.goodsid = self.goodsModel.goodsId;
        detailVC.htmlUrl = self.goodsModel.htmlUrl;
        [self.viewController.navigationController pushViewController:detailVC animated:YES];
        return;
    }
    
    MyRecommendViewController *recommendVC = [[MyRecommendViewController alloc]init];
    recommendVC.goodsId = self.goodsModel.goodsId;
    [self.viewController.navigationController pushViewController:recommendVC animated:YES];
}
#pragma mark - 提现

- (IBAction)withDrawlBtn:(UIButton *)sender {
    if ([self gotRealNameRu:@"在您申请提现之前,请先进行实名认证"]){
        return;
    }
    //再判断是否绑定银行卡
    if (![ShellCoinUserInfo shareUserInfos].bindingFlag){
        [self goBingdingBank:@"您还未绑定银行卡，请先绑定银行卡"];
    }
    DiscoverWithdrawalViewController *withDrawalVC = [[DiscoverWithdrawalViewController alloc]init];
    [self.viewController.navigationController pushViewController:withDrawalVC animated:YES];
    
}
#pragma mark - collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
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
    cell.dataModel = self.dataSouceArray[indexPath.item];
    nibri=NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiscovergoodsDetailViewController *detailVC = [[DiscovergoodsDetailViewController alloc]init];
    detailVC.goodsid = self.goodsModel.goodsId;
    detailVC.htmlUrl = self.goodsModel.htmlUrl;
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
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    DiscoverGoodsModel *model = self.dataSouceArray[(int)round(scrollView.contentOffset.x/TWitdh)];
    self.goodsModel = self.dataSouceArray[(int)(scrollView.contentOffset.x/TWitdh)];
    [self getCoumerRequest:model.goodsId];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{

}

#pragma mark - swipeView
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.dataModel.costRebateList.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
   __block UILabel *label = nil;
    if (nil == view) {
        view = [[UIView alloc] initWithFrame:swipeView.bounds];
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.center = swipeView.center;
        label.adjustsFontSizeToFitWidth  = YES;
        label.tag = 10;
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
        label.textColor = MacoTitleColor;
        label.font = [UIFont systemFontOfSize:13];
        view.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth;
        label.frame = CGRectMake(5, 0, swipeView.bounds.size.width-10, swipeView.bounds.size.height);

        NSDictionary *dic = self.dataModel.costRebateList[index];
        
        NSTimeInterval interval = [NullToNumber(dic[@"accountTime"]) longLongValue]/1000;;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        __weak DiscoverRootTableViewCell *weak_self = self;
        NSTimeInterval nowInterval= [self.dataModel.sysTime longLongValue]/1000;
        //                NSTimeInterval nowInterval= 1495692253;
        NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:nowInterval];
         __block NSInteger tempTime = [date timeIntervalSinceDate:nowDate];
        label.text = [NSString stringWithFormat:@"%@元购物金  %@",NullToNumber(dic[@"amount"]),[weak_self getNowTimeWithStringEndTime:tempTime]];
        NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:label.text];
        for (int i = 0; i < label.text.length; i ++) {
            //这里的小技巧，每次只截取一个字符的范围
            NSString *a = [label.text substringWithRange:NSMakeRange(i, 1)];
            //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
            if ([number containsObject:a]) {
                [attributeString setAttributes:@{NSForegroundColorAttributeName:MacoColor,NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(i, 1)];
            }
        }
        label.attributedText = attributeString;
        
        [NSTimer scheduledTimerWithTimeInterval:1. repeats:YES block:^(NSTimer * _Nonnull timer) {
            label.text = [NSString stringWithFormat:@"%@元购物金  %@",NullToNumber(dic[@"amount"]),[weak_self getNowTimeWithStringEndTime:tempTime]];
            NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
            NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:label.text];
            for (int i = 0; i < label.text.length; i ++) {
                //这里的小技巧，每次只截取一个字符的范围
                NSString *a = [label.text substringWithRange:NSMakeRange(i, 1)];
                //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
                if ([number containsObject:a]) {
                    [attributeString setAttributes:@{NSForegroundColorAttributeName:MacoColor,NSFontAttributeName:[UIFont systemFontOfSize:13]} range:NSMakeRange(i, 1)];
                }
            }
            label.attributedText = attributeString;
            tempTime --;
        }];

    }else {
        label = (UILabel*)[view viewWithTag:10];
    }
    return view;
}


#pragma mark - 去进行实名认证
- (BOOL)gotRealNameRu:(NSString *)alerTitle
{
    if (![ShellCoinUserInfo shareUserInfos].identityFlag) {
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:alerTitle preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去认证" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //去进行实名认证
            
            if ([ShellCoinUserInfo shareUserInfos].idVerifyReqFlag) {
                RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
                realnameVC.isWaitAut = YES;
                [self.viewController.navigationController pushViewController:realnameVC animated:YES];
                
                return;
            }
            RealnameViewController *realnameVC = [[RealnameViewController alloc]init];
            realnameVC.isYetAut = NO;
            [self.viewController.navigationController pushViewController:realnameVC animated:YES];
            
        }];
        [alertcontroller addAction:cancelAction];
        [alertcontroller addAction:otherAction];
        [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
        return YES;
    }
    return NO;
}

#pragma mark - 去绑定银行卡
- (void)goBingdingBank:(NSString *)alerTitle
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"重要提示" message:alerTitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"去绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //去绑定银行卡
        EditBankInfoViewController *bankcardVC = [[EditBankInfoViewController alloc]init];
        bankcardVC.isFromRoomPage = YES;
        [self.viewController.navigationController pushViewController:bankcardVC animated:YES];
    }];
    [alertcontroller addAction:cancelAction];
    [alertcontroller addAction:otherAction];
    [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
}



@end


@implementation DiscoverConsumersModel

+(id)modelWithDic:(NSDictionary *)dic
{
    DiscoverConsumersModel *model = [[DiscoverConsumersModel alloc]init];
    model.userState = NullToNumber(dic[@"userState"]);
    model.avilableBalance = [NullToNumber(dic[@"avilableBalance"]) doubleValue];
    if ([dic[@"costRebateList"] isKindOfClass:[NSArray class]]) {
        model.costRebateList = [NSMutableArray arrayWithArray:dic[@"costRebateList"]];
    }
    model.sysTime = NullToNumber(dic[@"sysTime"]);
    return model;
}

- (NSMutableArray *)costRebateList
{
    if (!_costRebateList) {
        _costRebateList   = [NSMutableArray array];
    }
    return _costRebateList;
}

@end


