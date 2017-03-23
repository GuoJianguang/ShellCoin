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

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:241/255. green:247/255. blue:247/255. alpha:1.];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tabBarController.delegate = self;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
