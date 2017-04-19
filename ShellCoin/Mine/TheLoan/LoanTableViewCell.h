//
//  LoanTableViewCell.h
//  ShellCoin
//
//  Created by Guo on 2017/4/19.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *loanSortlabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneLabel;
@property (weak, nonatomic) IBOutlet UILabel *symbollabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progerssView;
@property (weak, nonatomic) IBOutlet UILabel *alerTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end
