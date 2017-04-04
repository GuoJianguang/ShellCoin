//
//  MerchantSearchViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/4/4.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantSearchViewController : UIViewController


- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFied;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
- (IBAction)searchBtn:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (nonatomic, copy)NSString *cityName;

@end
