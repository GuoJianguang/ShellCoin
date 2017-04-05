//
//  SureTradInView.h
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,Password_type){
    Password_type_withdraw = 1,//抵换
    Password_type_MerchantOnlinePay = 2,//商家支付
};


@protocol PayViewDelegate <NSObject>

- (void)paysuccess:(NSString *)payWay;
- (void)payfail;

@end

@interface SureTradInView : UIView

@property (weak, nonatomic) IBOutlet UIView *blackBackgoundView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

- (IBAction)cancelBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;


@property (weak, nonatomic) IBOutlet UIView *itemView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)sureBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
- (IBAction)forgetBtn:(UIButton *)sender;

@property (nonatomic,strong)NSMutableDictionary *mallOrderParms;

@property (nonatomic, assign)Password_type inputType;

@property (nonatomic, assign)id<PayViewDelegate> delegate;


@end
