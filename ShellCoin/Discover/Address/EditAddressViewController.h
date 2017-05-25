//
//  EditAddressViewController.h
//  ShellCoin
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressTableViewCell.h"

@interface EditAddressViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;


@property (weak, nonatomic) IBOutlet UITextField *shippingPersonTF;

@property (weak, nonatomic) IBOutlet UITextField *provincesTF;

@property (weak, nonatomic) IBOutlet UITextField *detailAddressTF;

@property (weak, nonatomic) IBOutlet UITextField *ZipCodeTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;


//@property (nonatomic, strong)ShippingAddressModel *addressModel;


@property (nonatomic, assign)BOOL isAddAddress;

- (IBAction)sure_btn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

- (IBAction)selectProBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;

@property (nonatomic, strong)ShippingAddressModel *addressModel;

@end
