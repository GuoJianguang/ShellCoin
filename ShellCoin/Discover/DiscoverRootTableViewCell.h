//
//  DiscoverRootTableViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DiscoverConsumersModel : BaseModel
/**
 * 0不是消费商  1是消费商没有推荐别的用户  2是消费商有推荐别的用户
 */
@property (nonatomic,copy)NSString *userState;
/**
 * 余额
 */
@property (nonatomic,assign)double avilableBalance;
/**
 * 返本到账列表
 */
@property (nonatomic,strong)NSMutableArray *costRebateList;
/**
 * 系统时间
 */
@property (nonatomic,copy)NSString *sysTime;


@end

@interface DiscoverRootTableViewCell : BaseTableViewCell
- (IBAction)buyRecodeBtn:(UIButton *)sender;
- (IBAction)helpBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *earningsLabel;
@property (weak, nonatomic) IBOutlet UILabel *earnings;
@property (weak, nonatomic) IBOutlet UIView *notConsumersView;
- (IBAction)notConsumerBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *checkRecommendView;
- (IBAction)checkRecommendBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *withDrawlBtn;
- (IBAction)withDrawlBtn:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *alerView;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel;

@property (weak, nonatomic) IBOutlet UILabel *checkRecommendLabel;

@property (nonatomic, strong)DiscoverConsumersModel *dataModel;


@end
