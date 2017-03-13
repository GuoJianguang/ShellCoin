//
//  ManualCertificationViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface ManualCertificationViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet UILabel *alerLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idCardLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idcardTF;
@property (weak, nonatomic) IBOutlet UIButton *idCardBtn;
- (IBAction)idCardBtn:(id)sender;



@end
