//
//  MyorderViewController.m
//  ShellCoin
//
//  Created by mac on 2017/6/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "MyorderViewController.h"
#import "MyorderView.h"

@interface MyorderViewController ()<SwipeViewDelegate,SwipeViewDataSource,SortButtonSwitchViewDelegate>

@property (nonatomic, strong)MyorderView *waitPayView;
@property (nonatomic, strong)MyorderView *waitSendGoodsView;
@property (nonatomic, strong)MyorderView *waitReceiveGoodsView;
@property (nonatomic, strong)MyorderView *compelteView;


@end

@implementation MyorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"我的订单";
    self.naviBar.lineVIew.hidden = YES;
    self.sortView.titleArray = @[@"待付款",@"待发货",@"待收货",@"已完成"];
    self.sortView.delegate = self;
    self.swipeView.delegate = self;
    self.swipeView.dataSource = self;
}

#pragma mark - 各个分类view的懒加载
- (MyorderView *)waitPayView
{
    if (!_waitPayView) {
        _waitPayView = [[MyorderView alloc]init];
        _waitPayView.orderType = Myorder_type_waitPay;
    }
    return _waitPayView;
}

- (MyorderView *)waitSendGoodsView
{
    if (!_waitSendGoodsView) {
        _waitSendGoodsView = [[MyorderView alloc]init];
        _waitSendGoodsView.orderType = Myorder_type_waitSendGoods;

    }
    return _waitSendGoodsView;
}

- (MyorderView *)waitReceiveGoodsView
{
    if (!_waitReceiveGoodsView) {
        _waitReceiveGoodsView = [[MyorderView alloc]init];
        _waitReceiveGoodsView.orderType = Myorder_type_waitReceiveGoods;

    }
    return _waitReceiveGoodsView;
}

- (MyorderView *)compelteView
{
    if (!_compelteView) {
        _compelteView = [[MyorderView alloc]init];
        _compelteView.orderType = Myorder_type_compelte;

    }
    return _compelteView;
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
            [view addSubview:self.waitPayView];
            [self.waitPayView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 1:{
            [view addSubview:self.waitSendGoodsView];
            [self.waitSendGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];

        }
            break;
        case 2:{
            [view addSubview:self.waitReceiveGoodsView];
            [self.waitReceiveGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 3:{
            [view addSubview:self.compelteView];
            [self.compelteView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    return 4;
}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    switch (swipeView.currentPage) {
        case 0:
            [self.waitPayView reload];
            break;
        case 1:
            [self.waitSendGoodsView reload];
            break;
        case 2:
            [self.waitReceiveGoodsView reload];
            break;
        case 3:
            [self.compelteView reload];
            break;
        default:
            break;
    }
    [self.sortView selectItem:swipeView.currentItemIndex ];
}

#pragma mark - SortViewDelegate
- (void)sortBtnDselect:(SortButtonSwitchView *)sortView withSortId:(NSString *)sortId
{
    [self.swipeView scrollToPage:[sortId integerValue] -1 duration:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
