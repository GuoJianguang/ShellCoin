//
//  HomeViewController.h
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController



@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
- (IBAction)locationBtn:(UIButton *)sender;

- (IBAction)searchBtn:(id)sender;


@end
