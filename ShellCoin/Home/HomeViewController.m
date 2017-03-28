//
//  HomeViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HomeViewController.h"
#import "MineViewController.h"
#import "HomeBannerTableViewCell.h"
#import "HomeIndustryTableViewCell.h"
#import "HomeRecommendedTableViewCell.h"
#import "HomeMerchantTableViewCell.h"


@interface HomeViewController ()<UITabBarControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *privteDataSouceArray;
@property (nonatomic, strong)NSMutableArray *popularDataSouceArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255. green:247/255. blue:247/255. alpha:1.];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tabBarController.delegate = self;
    
    UIColor *itemSelectTintColor = [UIColor redColor];
//    [[UITabBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      itemSelectTintColor,
//      NSForegroundColorAttributeName,
//      [UIFont boldSystemFontOfSize:15],
//      NSFontAttributeName
//      ,nil] forState:UIControlStateSelected];
    self.tabBarController.tabBar.tintColor = itemSelectTintColor;
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:itemSelectTintColor frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)]];
    [ShellCoinUserInfo shareUserInfos].locationCity = @"成都";

    [self getPopularMRequest];
}


#pragma mark - 懒加载
- (NSMutableArray *)privteDataSouceArray
{
    if (!_privteDataSouceArray) {
        _privteDataSouceArray = [NSMutableArray array];
    }
    return _privteDataSouceArray;
}

- (NSMutableArray *)popularDataSouceArray
{
    if (!_popularDataSouceArray) {
        _popularDataSouceArray = [NSMutableArray array];
    }
    return _popularDataSouceArray;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        HomeBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeBannerTableViewCell indentify]];
        if (!cell) {
            cell = [HomeBannerTableViewCell newCell];
        }
        return cell;
    }else if(indexPath.row == 1){
        HomeIndustryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeIndustryTableViewCell indentify]];
        if (!cell) {
            cell = [HomeIndustryTableViewCell newCell];
        }
        cell.isAlreadyRefrefsh = YES;
        return cell;
    }else if(indexPath.row == 2){
        HomeRecommendedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeRecommendedTableViewCell indentify]];
        if (!cell) {
            cell = [HomeRecommendedTableViewCell newCell];
        }
        cell.jingpinArray = self.popularDataSouceArray;
        return cell;
        
    }else{
        HomeMerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeMerchantTableViewCell indentify]];
        if (!cell) {
            cell = [HomeMerchantTableViewCell newCell];
        }
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return TWitdh*(140/320.);

    }else if(indexPath.row == 1){
        CGFloat intervalX = 50.0;/**<横向间隔*/
        CGFloat intervalY = 15.0;/**<纵向间隔*/
        NSInteger columnNum = 4;/**<九宫格列数*/
        CGFloat widthAndHeightRatio = 2.0/3.0;/**<宽高比*/
        CGFloat buttonWidth = (TWitdh - 40 - intervalX * (columnNum - 1))/(CGFloat)columnNum;/**<button的宽度*/
        CGFloat buttonHeight = buttonWidth/widthAndHeightRatio;/**<button的高度*/
        return buttonHeight * 2 + intervalY*2 + 18;

    }else if(indexPath.row == 2){
        return TWitdh*(70/64.) + TWitdh*(10/120.);

    }else{
        return TWitdh*(95/320.);
 
    }
}
#pragma mark - UITabBarDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if([viewController isMemberOfClass:[MineViewController class]]){
        if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
            //判断是否先登录
            UINavigationController *navc = [LoginViewController controller];
            [self presentViewController:navc animated:YES completion:NULL];
            return NO;
        }
    }
    return YES;
}




#pragma mark - 数据请求
#pragma mark - 请求人气商家，私人定制接口

//- (void)getPersonalRequest{
//    
//    NSDictionary *parms = @{@"longitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.longitude)),
//                            @"latitude":NullToNumber(@([ShellCoinUserInfo shareUserInfos].locationCoordinate.latitude))};
//    [HttpClient POST:@"user/personal" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
//        if (IsRequestTrue) {
//            [self.privteDataSouceArray removeAllObjects];
//            NSArray *array = jsonObject[@"data"];
//            for (NSDictionary *dic in array) {
//                [self.privteDataSouceArray addObject:[SecondACtivityModel modelWithDic:dic]];
//            }
//            [self.tableView reloadData];
//        }
//        
//    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
//        
//    }];
//}



- (void)getPopularMRequest{
    NSDictionary *parms = @{@"city":[ShellCoinUserInfo shareUserInfos].locationCity};
    [HttpClient POST:@"mch/hotMchs" parameters:parms success:^(NSURLSessionDataTask *operation, id jsonObject) {
        if (IsRequestTrue) {
            [self.popularDataSouceArray removeAllObjects];
            for (NSDictionary *dic in jsonObject[@"data"]) {
                PopularMerModel *model = [PopularMerModel modelWithDic:dic];
                [self.popularDataSouceArray addObject:model];
            }
            [self.tableView reloadData];
//            [self getPersonalRequest];
        }
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
