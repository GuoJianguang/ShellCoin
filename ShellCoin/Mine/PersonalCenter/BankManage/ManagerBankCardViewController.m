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
#import "BanCardDetailTableViewCell.h"
#import "EditBankInfoViewController.h"
#import "BankCardDetailView.h"
#import "BankCardInfoModel.h"

@interface ManagerBankCardViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,BasenavigationDelegate,UITableViewDelegate,UITableViewDataSource>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *dataSouceArray;

@property (nonatomic, strong) ManageBankView *manageView;

@property (nonatomic, strong)UITableView *talbeView;

@property (nonatomic, assign)NSInteger currentPage;

@property (nonatomic, strong)NewPagedFlowView *pageFlowView;

@end

@implementation ManagerBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviBar.title = @"银行卡";
    self.naviBar.delegate = self;

    self.view.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];
    
    self.naviBar.hiddenDetailBtn = NO;
    self.naviBar.detailTitle = @"添加";
    self.currentPage = 0;
    [self setupUI];
    [self getmyBankCardRequest];

}

#pragma  mark - 添加银行卡
- (void)detailBtnClick
{
    EditBankInfoViewController *editBankInfoVC = [[EditBankInfoViewController alloc]init];
    [self.navigationController pushViewController:editBankInfoVC animated:YES];
}


- (void)setupUI {
    self.pageFlowView.frame =  CGRectMake(0, 70, TWitdh, (TWitdh - 130) * 9 / 16 + 24);
    self.pageFlowView.delegate = self;
    self.pageFlowView.dataSource = self;
    self.pageFlowView.minimumPageAlpha = 0.1;
    self.pageFlowView.minimumPageScale = 0.93;
    self.pageFlowView.isCarousel = NO;
    self.pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    //提前告诉有多少页
    self.pageFlowView.orginPageCount = self.dataSouceArray.count;
    self.manageView.pageContrlVIew.numberPages = self.dataSouceArray.count;
    self.pageFlowView.isOpenAutoScroll = YES;
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [bottomScrollView addSubview:self.pageFlowView];
    
    [self.pageFlowView reloadData];
    
    [self.view addSubview:bottomScrollView];
    
    self.manageView.frame = CGRectMake(0, (TWitdh - 130) * 9 / 16 + 24 + 64, TWitdh, 78);
    self.manageView.layer.masksToBounds = YES;
    [self.view addSubview:self.manageView];
    
    self.talbeView.frame = CGRectMake(0, CGRectGetMaxY(self.manageView.frame), TWitdh, THeight - CGRectGetMaxY(self.manageView.frame));
    [self.view addSubview:self.talbeView];
    self.talbeView.delegate = self;
    self.talbeView.dataSource = self;
    self.talbeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view bringSubviewToFront:self.manageView];

    [self.view bringSubviewToFront:self.naviBar];

}
#pragma mark --懒加载

- (NewPagedFlowView *)pageFlowView
{
    if (!_pageFlowView) {
        _pageFlowView = [[NewPagedFlowView alloc]init];
        self.pageFlowView.backgroundColor = [UIColor colorFromHexString:@"#faf8f6"];

    }
    return _pageFlowView;
}
- (NSMutableArray *)dataSouceArray {
    if (_dataSouceArray == nil) {
        _dataSouceArray = [NSMutableArray array];
    }
    return _dataSouceArray;
}


- (ManageBankView *)manageView
{
    if (!_manageView) {
        _manageView = [[ManageBankView alloc]init];
    }
    return _manageView;
}


- (UITableView *)talbeView
{
    if (!_talbeView) {
        _talbeView = [[UITableView alloc]init];
    }
    return _talbeView;
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
    
    return self.dataSouceArray.count;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, TWitdh - 84, (TWitdh - 84) * 9 / 16)];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    bannerView.frame = bannerView.mainImageView.frame;
    bannerView.banView.dataModel = self.dataSouceArray[index];
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
 
    if (pageNumber < 0) {
        self.currentPage = 0;
        self.manageView.pageContrlVIew.currentPage = 0;
        
        [self.talbeView reloadData];
        self.manageView.bankModel = self.dataSouceArray[self.currentPage];
        return;
    }
    self.currentPage = pageNumber;
    self.manageView.pageContrlVIew.currentPage = pageNumber;
    self.manageView.bankModel = self.dataSouceArray[self.currentPage];
    [self.talbeView reloadData];
}



#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BanCardDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[BanCardDetailTableViewCell indentify]];
    if (!cell) {
        cell = [BanCardDetailTableViewCell newCell];
    }
    if (self.dataSouceArray.count > 0) {
        cell.dataModel = self.dataSouceArray[self.currentPage];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return THeight - 200;
}


#pragma mark - 获取我的银行卡
- (void)getmyBankCardRequest
{
    [HttpClient POST:@"user/withdraw/bindBankcard/get" parameters:@{@"token":[ShellCoinUserInfo shareUserInfos].token} success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.dataSouceArray removeAllObjects];
            NSArray *array = jsonObject[@"data"];
            for (NSDictionary *dic in array) {
                [self.dataSouceArray addObject:[BankCardInfoModel modelWithDic:dic]];
            }
            self.manageView.bankModel = self.dataSouceArray[self.currentPage];
            [self.pageFlowView reloadData];
            [self.talbeView reloadData];
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
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
