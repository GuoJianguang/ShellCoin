//
//  StoreDetailViewController.h
//  ShellCoin
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface StoreDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *storeImage;

@property (weak, nonatomic) IBOutlet UILabel *storeName;

- (IBAction)storeRootBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *storeIcon;
@property (weak, nonatomic) IBOutlet UILabel *storeRootLabel;
@property (weak, nonatomic) IBOutlet UIView *storeRootLineView;
- (IBAction)allGoodsBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;
@property (weak, nonatomic) IBOutlet UILabel *allGoodsLabel;
@property (weak, nonatomic) IBOutlet UIView *allGoodsLine;
@property (weak, nonatomic) IBOutlet UIView *itmeView;
@property (weak, nonatomic) IBOutlet UIView *line;

#pragma mark - 商户号
@property (nonatomic, copy)NSString *mchCode;

@end
