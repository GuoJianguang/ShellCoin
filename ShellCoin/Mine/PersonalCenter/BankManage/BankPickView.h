//
//  BankPickView.h
//  天添薪
//
//  Created by ttx on 16/1/13.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BankPickView;
@protocol BankPickViewDelegate <NSObject>

- (void)bankPickerView:(BankPickView *)picker
    finishPickbankName:(NSString *)bankName
                  bankId:(NSString *)bankId;

@end

@interface BankPickView : UIPickerView

@property (nonatomic, assign)BOOL isAddressPicker;


@property (nonatomic, strong)NSArray *wangdianArray;

@property (nonatomic, strong)NSMutableArray *dataSouceArray;
@property (nonatomic, assign)id<BankPickViewDelegate> bankdelegate;


@end
