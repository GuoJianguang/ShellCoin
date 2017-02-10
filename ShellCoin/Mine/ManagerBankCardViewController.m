//
//  ManagerBankCardViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ManagerBankCardViewController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "ManageBankView.h"

@interface ManagerBankCardViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,BasenavigationDelegate>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) ManageBankView *manageView;


@end

@implementation ManagerBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"银行卡";
    self.naviBar.delegate = self;
    for (int index = 0; index < 3; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",index]];
        [self.imageArray addObject:image];
    }
    
    [self setupUI];
    [self.view bringSubviewToFront:self.naviBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 80, TWitdh, (TWitdh - 130) * 9 / 16 + 24)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.minimumPageScale = 0.93;
    pageFlowView.isCarousel = NO;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    
    //提前告诉有多少页
    //    pageFlowView.orginPageCount = self.imageArray.count;
    
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 24 - 8, TWitdh, 8)];
    pageFlowView.pageControl = pageControl;
    pageFlowView.backgroundColor = [UIColor colorWithRed:241/255. green:247/255. blue:247/255. alpha:1.];
    [pageFlowView addSubview:pageControl];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [bottomScrollView addSubview:pageFlowView];
    
    [pageFlowView reloadData];
    
    [self.view addSubview:bottomScrollView];
    
    self.manageView.frame = CGRectMake(0, (TWitdh - 130) * 9 / 16 + 24 + 80, TWitdh, 80);
    [self.view addSubview:self.manageView];
    [self.view bringSubviewToFront:self.manageView];
}


- (ManageBankView *)manageView
{
    if (!_manageView) {
        _manageView = [[ManageBankView alloc]init];
    }
    return _manageView;
}



#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(TWitdh - 130, (TWitdh - 130) * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, TWitdh - 84, (TWitdh - 84) * 9 / 16)];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
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
