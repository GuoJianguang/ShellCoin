//
//  DiscoverRootTableViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

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


@end
