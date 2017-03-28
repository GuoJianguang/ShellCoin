//
//  PersonCenterTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/2/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCenterTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *realNameBtn;
- (IBAction)realNameBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *bankLabel;

- (IBAction)bankBtn:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *vipLabel;

- (IBAction)vipBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
- (IBAction)realNameManageBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *realNameMarkImageView;


@property (weak, nonatomic) IBOutlet UILabel *qrCodeLabel;

- (IBAction)qrCodeBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *myCollectionlabel;

- (IBAction)mycollectionBtn:(id)sender;

@end
