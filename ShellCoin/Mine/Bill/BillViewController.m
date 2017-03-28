//
//  BillViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillViewController.h"
#import "BillTableViewCell.h"
#import "BillConsumptionTableViewCell.h"
#import "BillIntegralDisciplineView.h"
#import "BillAmountDisciplineView.h"
#import "Bill1View.h"
#import "Bill12View.h"


@interface BillViewController ()<SwipeViewDelegate,SwipeViewDataSource,UITableViewDataSource,UITableViewDelegate,SortButtonSwitchViewDelegate>

@property (nonatomic, strong)UITableView *talbeView1;
@property (nonatomic, strong)UITableView *talbeView2;
@property (nonatomic, strong)UITableView *talbeView3;


@property (nonatomic, strong)Bill12View *intergralView;
@property (nonatomic, strong)Bill1View *amountDisciplineView;
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"账单";
    self.sortView.titleArray = @[@"金额记录",@"积分记录"];
    self.naviBar.lineVIew.hidden = YES;
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
    self.talbeView1.backgroundColor = self.talbeView2.backgroundColor = self.talbeView3.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - 懒加载
- (UITableView *)talbeView1
{
    if (!_talbeView1) {
        _talbeView1 = [[UITableView alloc]init];
        _talbeView1.separatorStyle = UITableViewCellSeparatorStyleNone;
        _talbeView1.delegate = self;
        _talbeView1.dataSource = self;
    }
    return _talbeView1;
}
- (UITableView *)talbeView2
{
    if (!_talbeView2) {
        _talbeView2 = [[UITableView alloc]init];
        _talbeView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        _talbeView2.delegate = self;
        _talbeView2.dataSource = self;
        
    }
    return _talbeView2;
}
- (UITableView *)talbeView3
{
    if (!_talbeView3) {
        _talbeView3 = [[UITableView alloc]init];
        _talbeView3.separatorStyle = UITableViewCellSeparatorStyleNone;
        _talbeView3.delegate = self;
        _talbeView3.dataSource = self;
    }
    return _talbeView3;
}

- (Bill12View *)intergralView
{
    if (!_intergralView) {
        _intergralView =[[Bill12View alloc]init];
    }
    return _intergralView;
}


- (Bill1View *)amountDisciplineView{
    if (!_amountDisciplineView) {
        _amountDisciplineView = [[Bill1View alloc]init];
    }
    return _amountDisciplineView;
}

#pragma mark - SortViewDelegate
- (void)sortBtnDselect:(SortButtonSwitchView *)sortView withSortId:(NSString *)sortId
{
    [self.swipeView scrollToPage:[sortId integerValue] -1 duration:0.5];

}

#pragma mark - SwipeView
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (view == nil) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, swipeView.frame.size.width, swipeView.frame.size.height)];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    switch (index) {
        case 0:{
            [view addSubview:self.amountDisciplineView];
            [self.amountDisciplineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 1:{
            [view addSubview:self.intergralView];
            [self.intergralView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];

        }
            break;
       
        default:
            break;
    }

    return view;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 2;
}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    [self.sortView selectItem:swipeView.currentItemIndex ];
}


#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.talbeView1 == tableView) {
        return TWitdh*(190/750.);
    }
    return TWitdh*(170/750.);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.talbeView1 == tableView) {
        BillConsumptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BillConsumptionTableViewCell indentify]];
        if (!cell) {
            cell = [BillConsumptionTableViewCell newCell];
        }
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BillTableViewCell indentify]];
    if (!cell) {
        cell = [BillTableViewCell newCell];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
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
