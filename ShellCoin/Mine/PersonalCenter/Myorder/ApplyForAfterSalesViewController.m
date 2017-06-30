//
//  ApplyForAfterSalesViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ApplyForAfterSalesViewController.h"
#import "BankPickView.h"
#import "OrderModel.h"
#import "WaitApplyView.h"
@interface ApplyForAfterSalesViewController ()<BasenavigationDelegate,BankPickViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) BankPickView *refundSortPicker;
@property (strong, nonatomic) BankPickView *refundresonPicker;

@property (strong, nonatomic)WaitApplyView *wairVCView;

@property (nonatomic,copy)NSString *tempReson;

@property (nonatomic,copy)NSString *tempcompany;
@property (nonatomic, assign)BOOL ismanualCompany;


@property (nonatomic, assign)BOOL isWaitDeal;

@end

@implementation ApplyForAfterSalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.naviBar.title = @"申请售后服务";
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_confirm"];
    self.isWaitDeal = NO;
    self.ismanualCompany = YES;
    
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];
    self.refundResonTF.inputView = self.refundresonPicker;

    self.label1.textColor = self.label2.textColor = self.label3.textColor = self.label4.textColor = MacoDetailColor;
    self.logCommpanuyTF.textColor = self.logNumberTF.textColor = self.refundResonTF.textColor = self.refundExpainTF.textColor = MacoTitleColor;
    
    self.logNumberTF.delegate = self.logCommpanuyTF.delegate = self.refundResonTF.delegate = self.refundExpainTF.delegate = self;
    
    self.tempReson = @"7天无理由退换货";
    self.tempcompany = @"韵达快递";
    
    
    if (self.orderType == Myorder_type_waitSendGoods) {
        self.view1.hidden = self.view3.hidden = YES;
    }else{
        self.view1.hidden = self.view3.hidden = NO;

    }

}


- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
}

- (WaitApplyView *)wairVCView
{
    if (!_wairVCView) {
        _wairVCView = [[WaitApplyView alloc]init];
        _wairVCView.frame = CGRectMake(0, 64, TWitdh, THeight - 64);

    }
    return _wairVCView;
}


#pragma mark - 懒加载

- (BankPickView *)refundSortPicker
{
    if (!_refundSortPicker) {
        _refundSortPicker = [[BankPickView alloc]init];
        NSDictionary *dic1 = @{@"bankId":@"1",@"bankName":@"顺丰快递"};
        NSDictionary *dic2 = @{@"bankId":@"2",@"bankName":@"韵达快递"};
        NSDictionary *dic3 = @{@"bankId":@"3",@"bankName":@"邮政包裹"};
        NSDictionary *dic4 = @{@"bankId":@"4",@"bankName":@"邮政EMS"};
        NSDictionary *dic5 = @{@"bankId":@"5",@"bankName":@"圆通快递"};
        NSDictionary *dic6 = @{@"bankId":@"6",@"bankName":@"申通快递"};
        NSDictionary *dic7 = @{@"bankId":@"6",@"bankName":@"中通快递"};
        NSDictionary *dic8 = @{@"bankId":@"6",@"bankName":@"百世汇通"};

        NSMutableArray *array = [NSMutableArray arrayWithArray:@[dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8]];
        _refundSortPicker.wangdianArray = array;
        _refundSortPicker.bankdelegate = self;
    }
    return _refundSortPicker;
}


- (BankPickView *)refundresonPicker
{
    if (!_refundresonPicker) {
        _refundresonPicker = [[BankPickView alloc]init];
        NSDictionary *dic1 = @{@"bankId":@"1",@"bankName":@"7天无理由退换货"};
        NSDictionary *dic2 = @{@"bankId":@"2",@"bankName":@"退运费"};
        NSDictionary *dic3 = @{@"bankId":@"3",@"bankName":@"做工问题"};
        NSDictionary *dic4 = @{@"bankId":@"3",@"bankName":@"缩水／褪色"};
        NSDictionary *dic5 = @{@"bankId":@"3",@"bankName":@"大小／尺寸与商品描述不符"};
        NSDictionary *dic6 = @{@"bankId":@"3",@"bankName":@"颜色／图案／款式与商品描述不符"};
        NSDictionary *dic7 = @{@"bankId":@"3",@"bankName":@"材质面料与商品描述不符"};
        NSDictionary *dic8 = @{@"bankId":@"3",@"bankName":@"少件／漏发"};
        NSDictionary *dic9 = @{@"bankId":@"3",@"bankName":@"卖家发错货"};
        NSDictionary *dic10 = @{@"bankId":@"3",@"bankName":@"包装／商品破损／污渍"};
        NSDictionary *dic11 = @{@"bankId":@"3",@"bankName":@"假冒品牌"};
        NSDictionary *dic12 = @{@"bankId":@"3",@"bankName":@"未按约定时间发货"};
        NSDictionary *dic13 = @{@"bankId":@"3",@"bankName":@"发票问题"};

        NSMutableArray *array = [NSMutableArray arrayWithArray:@[dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12,dic13]];
        _refundresonPicker.wangdianArray = array;
        _refundresonPicker.bankdelegate = self;
    }
    return _refundresonPicker;
}

#pragma mark - 选择相关类别
- (void)bankPickerView:(BankPickView *)picker finishPickbankName:(NSString *)bankName bankId:(NSString *)bankId
{
    if (picker == self.refundresonPicker) {
        self.refundResonTF.text = bankName;
        self.tempReson = bankName;
    }
    if (picker == self.refundSortPicker) {
        self.logCommpanuyTF.text  =bankName;
        self.tempcompany = bankName;

    }
}


#pragma mark - TextfiledDelegate


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.refundResonTF) {
        self.refundResonTF.text = self.tempReson;
    }
    if (textField == self.logCommpanuyTF) {
        if (!self.ismanualCompany) {
            self.logCommpanuyTF.text = self.tempcompany;
        }
        self.logCommpanuyTF.inputView = nil;
        self.ismanualCompany = YES;
        
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - 确认

- (void)detailBtnClick
{
    
    if (self.isWaitDeal) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"02865224503"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        return;
    }
    if ([self emptyTextOfTextField:self.refundResonTF]) {
        [[JAlertViewHelper shareAlterHelper]showTint:@"请选择或者输入售后原因" duration:2.];
        return;
    }
    if (self.orderType == Myorder_type_waitReceiveGoods) {
        if ([self emptyTextOfTextField:self.logCommpanuyTF]) {
            [[JAlertViewHelper shareAlterHelper]showTint:@"请填写物流公司" duration:2.];
            return;
        }else if ([self emptyTextOfTextField:self.logNumberTF]){
        
            [[JAlertViewHelper shareAlterHelper]showTint:@"请输入物流单号" duration:2.];
            return;

        }
    }
    
    NSDictionary *parms = @{@"token":[ShellCoinUserInfo shareUserInfos].token,
                            @"orderId":self.dataModel.orderId,
                            @"reason":NullToSpace(self.refundResonTF.text),
                            @"remark":NullToSpace(self.refundExpainTF.text),
                            @"logisticsCompany":NullToSpace(self.logCommpanuyTF.text),
                            @"logisticsNumber":NullToSpace(self.logNumberTF.text)};
    [SVProgressHUD showWithStatus:@"正在提交申请" maskType:SVProgressHUDMaskTypeBlack];
    [HttpClient POST:@"shop/refund/add" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"applySueecss" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"applySueecss" object:nil];
            self.isWaitDeal = YES;
            self.wairVCView.dataModel = self.dataModel;
            [self.view addSubview:self.wairVCView];
            self.naviBar.detailTitle = @"我要投诉";
            self.naviBar.detailImage = nil;
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
        [[JAlertViewHelper shareAlterHelper]showTint:@"申请失败，请重试" duration:2.];

    }];
    
}
-(BOOL) emptyTextOfTextField:(UITextField*) textField {
    
    if ([textField.text isEqualToString:@""] || !textField.text) {
        return YES;
    }
    return NO;
    
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

- (IBAction)selcetCommpayBtn:(UIButton *)sender {
    self.logCommpanuyTF.inputView = self.refundSortPicker;
    self.ismanualCompany = NO;
    [self.logCommpanuyTF becomeFirstResponder];
}
@end
