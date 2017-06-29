//
//  ChooseGoodsTypeView.h
//  ShellCoin
//
//  Created by mac on 2017/6/20.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MallGoodsModel.h"

typedef enum : NSUInteger {
    ChoosType_car,
    ChoosType_buy,
} ChoosType;

@interface ChooseGoodsTypeView : UIView


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *numberView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberViewTop;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *scrollContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollviewContentHeight;


@property (weak, nonatomic) IBOutlet UILabel *goodsNum;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
- (IBAction)subBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtn:(UIButton *)sender;


@property (nonatomic, copy)NSString *goodsId;

@property (nonatomic, copy)NSString *goodsFreight;

@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@property (weak, nonatomic) IBOutlet UILabel *freight;


@property (nonatomic, assign)ChoosType chooseType;

@property (nonatomic, strong)MallGoodsModel *goodsModel;


@end
