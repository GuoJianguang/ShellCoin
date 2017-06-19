//
//  ShoppingCarTableViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCarModel.h"


@interface ShoppingCarTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsSpec;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetail;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
- (IBAction)subBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *deletBtn;
- (IBAction)deletBtn:(UIButton *)sender;
- (IBAction)selectBtn:(UIButton *)sender;


@property (nonatomic, strong)ShoppingCarModel *dataModel;

@end
