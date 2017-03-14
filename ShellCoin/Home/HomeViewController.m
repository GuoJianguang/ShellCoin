//
//  HomeViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "HomeViewController.h"
#import "MineViewController.h"

@interface HomeViewController ()<UITabBarControllerDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviBar.title = @"首页";
    self.naviBar.hiddenBackBtn = YES;
    
    self.tabBarController.delegate = self;
}


#pragma mark - UITabBarDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    if([viewController isMemberOfClass:[MineViewController class]]){
//        if (![ShellCoinUserInfo shareUserInfos].currentLogined) {
//            //判断是否先登录
//            UINavigationController *navc = [LoginViewController controller];
//            [self presentViewController:navc animated:YES completion:NULL];
//            return NO;
//        }
//    }
    return YES;
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
