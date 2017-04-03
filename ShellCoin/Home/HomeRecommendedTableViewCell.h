//
//  HomeRecommendedTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PopularMerModel : BaseModel

@property (nonatomic, copy)NSString *aviableBalance;
//商户号
@property (nonatomic, copy)NSString *mchCode;
//商户名
@property (nonatomic, copy)NSString *mchName;
//封面图
@property (nonatomic, copy)NSString *pic;


@end

@interface HomeRecommendedTableViewCell : BaseTableViewCell

@property (nonatomic, strong)NSMutableArray *jingpinArray;

@property (weak, nonatomic) IBOutlet UICollectionView *highqualityCollectionVIew;

@property (weak, nonatomic) IBOutlet UICollectionView *foryouCollectionView;
- (IBAction)talentReBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel4;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel5;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel6;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;

- (IBAction)changeBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *moreLabel;




@end
