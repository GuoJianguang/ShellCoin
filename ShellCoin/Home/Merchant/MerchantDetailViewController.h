//
//  MerchantDetailViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/28.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"
#import "MerchantModel.h"

@interface MerchantDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
- (IBAction)phoneBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *merchantImageView;
@property (weak, nonatomic) IBOutlet UIView *itemView;
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locationImage;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
- (IBAction)collectionBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
- (IBAction)payBtn:(UIButton *)sender;
- (IBAction)addressBtn:(id)sender;

@property (nonatomic, copy)NSString *mchCode;


@end
