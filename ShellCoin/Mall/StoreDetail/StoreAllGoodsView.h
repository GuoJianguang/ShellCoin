//
//  StoreAllGoodsView.h
//  ShellCoin
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreAllGoodsView : UIView


@property (weak, nonatomic) IBOutlet UIButton *priceBtn;

- (IBAction)priceBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *priceImage;
@property (weak, nonatomic) IBOutlet UIButton *salesBtn;
- (IBAction)salesBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
- (IBAction)timeBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *timeImage;



@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end
