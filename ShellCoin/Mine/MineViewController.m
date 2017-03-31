//
//  MineViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "LSPaoMaView.h"


@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSString* text = @"两块钱,你买不了吃亏,两块钱,你买不了上当,真正的物有所值,拿啥啥便宜,买啥啥不贵,都两块,买啥都两块,全场卖两块,随便挑,随便选,都两块！";
    UIView *noticeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, TWitdh, 44)];
    noticeView.backgroundColor = [UIColor cyanColor];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 44, 44)];
    imageView.image = [UIImage imageNamed:@"icon_mine_selected"];
    [noticeView addSubview:imageView];
    LSPaoMaView* paomav = [[LSPaoMaView alloc] initWithFrame:CGRectMake(65, 0, TWitdh - 70, 44) title:text];
    paomav.backgroundColor = [UIColor clearColor];
    [noticeView addSubview:paomav];
//    [self.view addSubview:noticeView];
    
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
    return TWitdh*(1500/750.);
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
