//
//  BillIntegralDisciplineView.m
//  ShellCoin
//
//  Created by Guo on 2017/3/22.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "BillIntegralDisciplineView.h"
#import "BillConsumptionTableViewCell.h"

@interface BillIntegralDisciplineView()<UITableViewDelegate,UITableViewDataSource,SwipeViewDelegate,SwipeViewDataSource>
@property (nonatomic, strong)UITableView *talbeView1;
@property (nonatomic, strong)UITableView *talbeView2;

@end
@implementation BillIntegralDisciplineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"BillIntegralDisciplineView" owner:nil options:nil][0];
        self.talbeView1.backgroundColor = self.talbeView2.backgroundColor  = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.swipeView.delegate = self;
        self.swipeView.dataSource = self;
        self.swipeView.backgroundColor = [UIColor clearColor];

    }
    return self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillConsumptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BillConsumptionTableViewCell indentify]];
    if (!cell) {
        cell = [BillConsumptionTableViewCell newCell];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TWitdh*(170/750.);

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
            [view addSubview:self.talbeView1];
            [self.talbeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 1:{
            [view addSubview:self.talbeView2];
            [self.talbeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
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
    self.switchView.selectedSegmentIndex = swipeView.currentItemIndex;
}


- (IBAction)switchView:(id)sender {
    [self.swipeView scrollToPage:self.switchView.selectedSegmentIndex duration:0.5];

}
@end
