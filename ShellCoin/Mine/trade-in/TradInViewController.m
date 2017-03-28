//
//  TradInViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "TradInViewController.h"
#import "TradInTableViewCell.h"
#import "SelectBanCardView.h"
#import "SureTradInView.h"


@interface TradInViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)SelectBanCardView *selectBancardView;
@property (nonatomic, strong)SureTradInView *sureTradInView;
@end

@implementation TradInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.hidden= YES;
}

- (SelectBanCardView *)selectBancardView
{
    if (!_selectBancardView) {
        _selectBancardView = [[SelectBanCardView alloc]init];
    }
    return _selectBancardView;
}

- (SureTradInView *)sureTradInView
{
    if (!_sureTradInView) {
        _sureTradInView = [[SureTradInView alloc]init];
    }
    return _sureTradInView;
}

#pragma mark - 选择银行
- (void)addBankcardView
{
    [self.view addSubview:self.selectBancardView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.selectBancardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.selectBancardView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.selectBancardView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
    }];
}

#pragma mark - 确认抵换

- (void)sureTardIn
{
    [self.view addSubview:self.sureTradInView];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.sureTradInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(insets);
    }];
    self.sureTradInView.itemView.frame = CGRectMake(0, THeight , TWitdh, TWitdh*(260/375.));
    [UIView animateWithDuration:0.5 animations:^{
        self.sureTradInView.itemView.frame = CGRectMake(0, THeight - (TWitdh*(260/375.)), TWitdh, TWitdh*(260/375.));
    }];
}

#pragma mark - UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TradInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TradInTableViewCell indentify]];
    if (!cell) {
        cell = [TradInTableViewCell newCell];
    }
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
