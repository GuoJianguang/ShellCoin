//
//  MyRecommendDetailListViewController.m
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import "MyRecommendDetailListViewController.h"
#import "RecommendMerchantView.h"
#import "RecommendConsumersView.h"
#import "MyQrCodeViewController.h"

@interface MyRecommendDetailListViewController ()<SwipeViewDelegate,SwipeViewDataSource,SortButtonSwitchViewDelegate,BasenavigationDelegate>
@property (nonatomic, strong)RecommendMerchantView *merchantView;
@property (nonatomic, strong)RecommendConsumersView *consumerView;
@end

@implementation MyRecommendDetailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviBar.title = @"推荐人";
    self.naviBar.detailImage = [UIImage imageNamed:@"icon_recommended_qrcode"];
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.delegate = self;
    self.sortView.titleArray = @[@"推荐消费者",@"推荐商家"];
    self.naviBar.lineVIew.hidden = YES;
}

- (void)detailBtnClick
{
    MyQrCodeViewController *myQrVC = [[MyQrCodeViewController alloc]init];
    [self.navigationController pushViewController:myQrVC animated:YES];
}

- (RecommendMerchantView *)merchantView
{
    if (!_merchantView) {
        _merchantView = [[RecommendMerchantView alloc]init];
    }
    return _merchantView;
}

- (RecommendConsumersView *)consumerView
{
    if (!_consumerView) {
        _consumerView = [[RecommendConsumersView alloc]init];
    }
    return _consumerView;
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
            [view addSubview:self.consumerView];
            [self.consumerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(view).insets(insets);
            }];
        }
            break;
        case 1:{
            [view addSubview:self.merchantView];
            [self.merchantView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    return 3;
}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
    switch (swipeView.currentPage) {
        case 0:
            [self.consumerView reload];
            break;
        case 1:
            [self.merchantView reload];
            break;

        default:
            break;
    }
    [self.sortView selectItem:swipeView.currentItemIndex ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
