//
//  ShoppingCarTableViewCell.m
//  ShellCoin
//
//  Created by mac on 2017/6/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ShoppingCarTableViewCell.h"
#import "ShoppingCarViewController.h"

@implementation ShoppingCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.goodsImage.layer.masksToBounds = YES;
    self.goodsName.adjustsFontSizeToFitWidth = self.goodsSpec.adjustsFontSizeToFitWidth = self.goodsDetail.adjustsFontSizeToFitWidth =self.price.adjustsFontSizeToFitWidth= YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)subBtn:(UIButton *)sender {
    NSInteger count = [self.goodsNum.text integerValue];
    if (count == 1) {
        return;
    }
    
    self.goodsNum.text = [NSString stringWithFormat:@"%ld",--count ];
    
}
- (IBAction)addBtn:(UIButton *)sender {
    NSInteger count = [self.goodsNum.text integerValue];

    self.goodsNum.text = [NSString stringWithFormat:@"%ld",++count];

}
- (IBAction)deletBtn:(UIButton *)sender {
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定删除此商品" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

    }];
    [alertcontroller addAction:cancelAction];
    [alertcontroller addAction:otherAction];
    [self.viewController presentViewController:alertcontroller animated:YES completion:NULL];
}

#pragma mark - 选中
- (IBAction)selectBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.backImageView.image = [UIImage imageNamed:@"bj_shangpinxuanzhong"];
            ((ShoppingCarModel *)((ShoppingCarViewController *)self.viewController).dataSouceArray[_dataModel.index]).isSelect = YES;
    }else{
        self.backImageView.image = [UIImage imageNamed:@"bj_shangpin"];
            ((ShoppingCarModel *)((ShoppingCarViewController *)self.viewController).dataSouceArray[_dataModel.index]).isSelect = NO;
    }

    
}

- (void)setDataModel:(ShoppingCarModel *)dataModel
{
    _dataModel = dataModel;
    if (_dataModel.isSelect) {
        self.backImageView.image = [UIImage imageNamed:@"bj_shangpinxuanzhong"];
    }else{
        self.backImageView.image = [UIImage imageNamed:@"bj_shangpin"];
    }
    self.goodsName.text = _dataModel.goodsName;
    self.goodsNum.text = _dataModel.goodsNum;
    self.goodsSpec.text = _dataModel.goodsSpec;
    self.goodsDetail.text = _dataModel.goodsDetail;
    
}

@end
