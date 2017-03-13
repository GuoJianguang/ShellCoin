//
//  NoBankCardViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BaseViewController.h"

@interface NoBankCardViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *alerImageView;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)addBtn:(id)sender;

@end
