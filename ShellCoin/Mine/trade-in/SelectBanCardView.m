//
//  SelectBanCardView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SelectBanCardView.h"
#import "SecletBankCardTableViewCell.h"
#import "WithdrawalViewController.h"
#import "BankCardInfoModel.h"

@interface SelectBanCardView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)BankCardInfoModel *bankInfModel;
@end

@implementation SelectBanCardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SelectBanCardView" owner:nil options:nil][0];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.blackBackgoundView.backgroundColor = [UIColor colorFromHexString:@"#ccd8e2"];
        [self.sureBtn setTitleColor:MacoColor forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:MacoColor forState:UIControlStateNormal];
        self.titelLabel.textColor = MacoTitleColor;
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.blackBackgoundView addGestureRecognizer:tap];
        [self sendSubviewToBack:self.blackBackgoundView];
        
        
//        BankInfoModel *model1 = [[BankInfoModel alloc]init];
//        model1.bankName = @"工商银行";
//        model1.bankCardNum = @"8762";
//        model1.isSeclet = YES;
//        
//        BankInfoModel *model2= [[BankInfoModel alloc]init];
//        model2.bankName = @"建设银行";
//        model2.bankCardNum = @"9865";
//        model2.isSeclet = NO;
//        
//        BankInfoModel *model3 = [[BankInfoModel alloc]init];
//        model3.bankName = @"中国银行";
//        model3.bankCardNum = @"4376";
//        model3.isSeclet = NO;
//        
//        BankInfoModel *model4 = [[BankInfoModel alloc]init];
//        model4.bankName = @"浦发银行";
//        model4.bankCardNum = @"7658";
//        model4.isSeclet = NO;
//        
//        [self.dataSouceArray addObject:model1];
//        [self.dataSouceArray addObject:model2];
//        [self.dataSouceArray addObject:model3];
//        [self.dataSouceArray addObject:model4];
        [self.tableView reloadData];

    }
    return  self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}

- (NSMutableArray *)dataSouceArray
{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}

- (IBAction)cancelBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)tap{
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}
#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecletBankCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[SecletBankCardTableViewCell indentify]];
    if (!cell) {
        cell = [SecletBankCardTableViewCell newCell];
    }
    cell.dataModel = self.dataSouceArray[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return TWitdh*(120/750.);
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (BankInfoModel *model in self.dataSouceArray) {
        model.isSeclet = NO;
    }
    ((BankCardInfoModel *)self.dataSouceArray[indexPath.row]).isSeclet = YES;
    [tableView reloadData];
    self.bankInfModel =  (BankCardInfoModel *)self.dataSouceArray[indexPath.row];

}



- (IBAction)sureBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.itemView.frame = CGRectMake(0, THeight, TWitdh, TWitdh*(260/375.));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    ((WithdrawalViewController*)self.viewController).bankModel = self.bankInfModel;
}

- (void)setBankInfModel:(BankCardInfoModel *)bankInfModel
{
    _bankInfModel = bankInfModel;
}
@end
