//
//  ApplyForAfterSalesViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ApplyForAfterSalesViewController.h"
#import "BankPickView.h"

@interface ApplyForAfterSalesViewController ()<BasenavigationDelegate,BankPickViewDelegate>
@property (strong, nonatomic) BankPickView *refundSortPicker;
@property (strong, nonatomic) BankPickView *refundresonPicker;

@end

@implementation ApplyForAfterSalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.naviBar.title = @"申请售后服务";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_confirm"];

    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];
    
    self.refundResonTF.inputView = self.refundresonPicker;
    self.refundSortTF.inputView = self.refundSortPicker;
    self.label1.textColor = self.label2.textColor = self.label3.textColor = self.label4.textColor = MacoDetailColor;
    self.refundSortTF.textColor = self.refundResonTF.textColor = self.refoundMoneyTF.textColor = self.refundExpainTF.textColor = MacoTitleColor;

}


- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}

#pragma mark - 懒加载

- (BankPickView *)refundSortPicker
{
    if (!_refundSortPicker) {
        _refundSortPicker = [[BankPickView alloc]init];
        NSDictionary *dic1 = @{@"bankId":@"1",@"bankName":@"我要退款"};
        NSDictionary *dic3 = @{@"bankId":@"3",@"bankName":@"退款和退货"};
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[dic1,dic3]];
        _refundSortPicker.wangdianArray = array;
        _refundSortPicker.bankdelegate = self;
    }
    return _refundSortPicker;
}


- (BankPickView *)refundresonPicker
{
    if (!_refundresonPicker) {
        _refundresonPicker = [[BankPickView alloc]init];
        NSDictionary *dic1 = @{@"bankId":@"1",@"bankName":@"尺寸不合适"};
        NSDictionary *dic2 = @{@"bankId":@"2",@"bankName":@"不想要了"};
        NSDictionary *dic3 = @{@"bankId":@"3",@"bankName":@"质量有问题"};
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[dic1,dic2,dic3]];
        _refundresonPicker.wangdianArray = array;
        _refundresonPicker.bankdelegate = self;
    }
    return _refundresonPicker;
}

#pragma mark - 选择相关类别
- (void)bankPickerView:(BankPickView *)picker finishPickbankName:(NSString *)bankName bankId:(NSString *)bankId
{
//    self.loanSortTF.text = bankName;
//    self.sortName = bankName;
//    self.sortId = bankId;
}


#pragma mark - 确认

- (void)detailBtnClick
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
