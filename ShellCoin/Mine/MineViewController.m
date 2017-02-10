//
//  MineViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITabelView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MineTableViewCell indentify]];
    if (!cell) {
        cell = [MineTableViewCell newCell];
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
    return TWitdh*(963/750.) + 385 + 44;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
