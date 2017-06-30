//
//  MallGoodsListViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface MallGoodsListViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;

- (IBAction)priceBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *priceImage;
@property (weak, nonatomic) IBOutlet UIButton *salesBtn;
- (IBAction)salesBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
- (IBAction)timeBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *timeImage;

@property (weak, nonatomic) IBOutlet UIButton *sort1Btn;

- (IBAction)sort1Btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *sort2Btn;
- (IBAction)sort2Btn:(UIButton *)sender;
- (IBAction)sort3Btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *sort3Btn;
@property (weak, nonatomic) IBOutlet UIButton *moreSortBtn;
- (IBAction)moreSortBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)buyCarBtn:(UIButton *)sender;

//类别id
@property (nonatomic, copy)NSString *typeId;
@property (nonatomic, copy)NSString *typeName;

@property (nonatomic, strong)NSMutableArray *typeArray;
//搜索关键字
@property (nonatomic, copy)NSString *keyWords;

@property (nonatomic, assign)BOOL isSearch;

@end
