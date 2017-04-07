//
//  AboutUSViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/29.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "AboutUSViewController.h"
#import "AboutsUsTableViewCell.h"
@interface AboutUSViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden = YES;
}

#pragma mark - UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutsUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AboutsUsTableViewCell indentify]];
    if (!cell) {
        cell = [AboutsUsTableViewCell newCell];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return TWitdh * (1400/750.);
    if (THeight < 500) {
        return 575;
    }
    return THeight;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
