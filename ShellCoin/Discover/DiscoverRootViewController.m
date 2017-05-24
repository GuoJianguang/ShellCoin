//
//  DiscoverRootViewController.m
//  ShellCoin
//
//  Created by mac on 2017/5/24.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "DiscoverRootViewController.h"
#import "DiscoverRootTableViewCell.h"

@interface DiscoverRootViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DiscoverRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviBar.hidden = YES;
}


#pragma mark - UITabelView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverRootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[DiscoverRootTableViewCell indentify]];
    if (!cell) {
        cell = [DiscoverRootTableViewCell newCell];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.masksToBounds = YES;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return THeight - 49;
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
