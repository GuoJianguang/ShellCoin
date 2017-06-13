//
//  OrderTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.statusBtn.titleLabel.adjustsFontSizeToFitWidth=self.goodsName.adjustsFontSizeToFitWidth = self.goodsNumber.adjustsFontSizeToFitWidth = self.goodsDetail.adjustsFontSizeToFitWidth = YES;
    self.goodsName.textColor = self.goodsNumber.textColor =MacoTitleColor;
    self.goodsDetail.textColor = MacoDetailColor;
    [self.acitonBtn setTitleColor:MacoColor forState:UIControlStateNormal];
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)statusBtn:(UIButton *)sender {
    
}
- (IBAction)acitonBtn:(UIButton *)sender {
    
}


- (void)setOrderType:(Myorder_type)orderType
{
    _orderType = orderType;
    switch (orderType) {
        case Myorder_type_waitPay:
        {
            self.sortImgaeView.image = [UIImage imageNamed:@"pic_state_yellow2"];
            [self.statusBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_yellow"] forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"去支付" forState:UIControlStateNormal];
        }
            break;
        case Myorder_type_waitSendGoods:
        {
            self.sortImgaeView.image = [UIImage imageNamed:@"pic_state_blue2"];
            [self.statusBtn setTitle:@"待发货" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_blue"] forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"提醒发货" forState:UIControlStateNormal];

        }
            break;
        case Myorder_type_waitReceiveGoods:
        {
            self.sortImgaeView.image = [UIImage imageNamed:@"pic_state_blue2"];
            [self.statusBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_blue"] forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"确认收货" forState:UIControlStateNormal];

        }
            break;
        case Myorder_type_compelte:
        {
            self.sortImgaeView.image = [UIImage imageNamed:@"pic_state_red3"];
            [self.statusBtn setTitle:@"已完成" forState:UIControlStateNormal];
            [self.statusBtn setBackgroundImage:[UIImage imageNamed:@"bg_status_label_red"] forState:UIControlStateNormal];
            [self.acitonBtn setTitle:@"查看详情" forState:UIControlStateNormal];

        }
            break;
        default:
            break;
    }
}

- (void)setDataModel:(OrderModel *)dataModel
{
    _dataModel = dataModel;
    
    
}

@end
