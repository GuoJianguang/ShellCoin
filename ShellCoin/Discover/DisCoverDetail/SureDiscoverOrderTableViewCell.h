//
//  SureDiscoverOrderTableViewCell.h
//  ShellCoin
//
//  Created by mac on 2017/5/25.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressTableViewCell.h"

typedef NS_ENUM(NSInteger,DiscoverPayway_type){
    DiscoverPayway_type_wechat = 1,//微信支付
    DiscoverPayway_type_alipay = 2//支付宝支付
};

@interface DiscoverGoodsDetailModel : BaseModel

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *slideImages;
@property (nonatomic,copy)NSString *picDescs;
@property (nonatomic,copy)NSString *txtDesc;
@property (nonatomic,copy)NSString *cashAmount;
@property (nonatomic,copy)NSString *expectAmount;
@property (nonatomic,copy)NSString *consumeAmount;
@property (nonatomic,copy)NSString *freeFeight;
@property (nonatomic,copy)NSString *hasInventory;

@property (nonatomic, copy)NSString *coverImage;

@property (nonatomic, copy)NSString *freight;
@end


@interface SureDiscoverOrderTableViewCell : BaseTableViewCell



#pragma mark - 地址信息
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *addAddressBtn;
- (IBAction)addAddressBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *editAddressBtn;
- (IBAction)editAddressBtn:(UIButton *)sender;
#pragma mark - 商品信息

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@property (weak, nonatomic) IBOutlet UILabel *goodsName;

@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumber;
@property (weak, nonatomic) IBOutlet UILabel *goodsInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsAmount;

#pragma markl - 支付方式
@property (weak, nonatomic) IBOutlet UIImageView *wechatImage;
@property (weak, nonatomic) IBOutlet UILabel *wechatLabel;
@property (weak, nonatomic) IBOutlet UIButton *wechatMarkBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
- (IBAction)wechatBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *aliPayImage;
@property (weak, nonatomic) IBOutlet UILabel *aliPayLabel;
@property (weak, nonatomic) IBOutlet UIButton *aliPayMarkBtn;
@property (weak, nonatomic) IBOutlet UIButton *aliPaytBtn;
- (IBAction)aliPay:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *paywayLabel;

@property (nonatomic,copy)NSString *goodsid;

@property (nonatomic,strong)DiscoverGoodsDetailModel *dataModel;

@property (nonatomic, assign)NSInteger number;

@property (nonatomic, assign)DiscoverPayway_type pay_type;

@property (nonatomic, strong)ShippingAddressModel *addressModel;
@end
