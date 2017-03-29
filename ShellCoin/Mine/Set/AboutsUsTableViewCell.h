//
//  AboutsUsTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/3/29.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutsUsTableViewCell : BaseTableViewCell
- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *visionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detail_Label;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@end
