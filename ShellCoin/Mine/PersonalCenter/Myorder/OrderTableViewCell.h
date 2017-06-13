//
//  OrderTableViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyorderView.h"


@class OrderModel;

@interface OrderTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *sortImgaeView;

@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
- (IBAction)statusBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@property (weak, nonatomic) IBOutlet UILabel *goodsDetail;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumber;


@property (weak, nonatomic) IBOutlet UIButton *acitonBtn;
- (IBAction)acitonBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *enterImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enterWidth;



@property (nonatomic, strong)OrderModel *dataModel;

@property (nonatomic, assign)Myorder_type orderType;

@end
