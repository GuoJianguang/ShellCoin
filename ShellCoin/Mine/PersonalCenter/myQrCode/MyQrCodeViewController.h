//
//  MyQrCodeViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface MyQrCodeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *tiltlLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

- (IBAction)shareBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *instructionsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *heardImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@end
