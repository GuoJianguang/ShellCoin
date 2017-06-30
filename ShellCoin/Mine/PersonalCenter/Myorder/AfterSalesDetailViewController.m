//
//  AfterSalesDetailViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "AfterSalesDetailViewController.h"
#import "OrderModel.h"
@interface AfterSalesDetailViewController ()

@end

@implementation AfterSalesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"售后记录";
    
    [self setLayerWithbor:self.view1];
    [self setLayerWithbor:self.view2];
    [self setLayerWithbor:self.view3];
    [self setLayerWithbor:self.view4];
    
    self.label1.textColor = self.label2.textColor = self.label3.textColor = self.label4.textColor = MacoDetailColor;
    
    self.scrollView.bounces = YES;
    
    [self getOrderDetailRequest];

}


- (void)getOrderDetailRequest
{
    NSDictionary *parms = @{@"orderId":self.dataModel.orderId,
                            @"token":[ShellCoinUserInfo shareUserInfos].token};
    [SVProgressHUD showWithStatus:@"数据获取中..."];
    [HttpClient POST:@"shop/refund/get" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        [SVProgressHUD dismiss];
        if (IsRequestTrue) {
            self.storeNameTF.text = NullToSpace(jsonObject[@"data"][@"mchName"]);
            if ([NullToNumber(jsonObject[@"data"][@"type"]) isEqualToString:@"2"]) {
                self.backWayTF.text = @"退款";
            }else if ([NullToNumber(jsonObject[@"data"][@"type"]) isEqualToString:@"1"]){
                self.backWayTF.text = @"退款并退货";
            }
            if ([NullToNumber(jsonObject[@"data"][@"amountType"]) isEqualToString:@"0"]) {
                self.payWayLabel.text = @"余额";
            }else if([NullToNumber(jsonObject[@"data"][@"amountType"]) isEqualToString:@"1"]){
                self.payWayLabel.text = @"微信";

            }else if([NullToNumber(jsonObject[@"data"][@"amountType"]) isEqualToString:@"3"]){
                self.payWayLabel.text = @"支付宝";
                
            }
            self.resonTF.text = NullToSpace(jsonObject[@"data"][@"reason"]);
            self.expainTF.text = NullToSpace(jsonObject[@"data"][@"remark"]);
            self.payWay.text = [NSString stringWithFormat:@"¥%.2f",            [NullToSpace(jsonObject[@"data"][@"amount"]) doubleValue]];
            
            if ([self.expainTF.text isEqualToString:@""]) {
                self.expainTF.text = @"暂无说明";
            }
            self.shellCoin.text = [NSString stringWithFormat:@"%.2f个",            [NullToSpace(jsonObject[@"data"][@"expectAmount"]) doubleValue]];
            self.buyCard.text = [NSString stringWithFormat:@"¥%.2f",            [NullToSpace(jsonObject[@"data"][@"consumeAmount"]) doubleValue]];
            self.backTotal.text = [NSString stringWithFormat:@"¥%.2f",            [NullToSpace(jsonObject[@"data"][@"amount"]) doubleValue] +[NullToSpace(jsonObject[@"data"][@"consumeAmount"]) doubleValue] +[NullToSpace(jsonObject[@"data"][@"expectAmount"]) doubleValue] ];
            
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
}


- (void)setLayerWithbor:(UIView*)view
{
    view.layer.borderWidth = 1;
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6"].CGColor;
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
