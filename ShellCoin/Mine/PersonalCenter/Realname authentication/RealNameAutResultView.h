//
//  RealNameAutResultView.h
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RealNameAutResultView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *autResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *autResultTitleLabel;


@property (nonatomic, assign)BOOL isSuccess;

@end
