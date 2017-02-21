//
//  BaseViewController.m
//  天添薪
//
//  Created by ttx on 16/1/4.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //解决隐藏navigaitioinbar返回手势失效的问题
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;

    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.naviBar = [BaseNavigationBar navigationBar];
    self.naviBar.back_btn.backgroundColor = [UIColor clearColor];
//    self.naviBar.backgroundColor = [UIColor colorFromHexString:@"007aff"];
    self.naviBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.naviBar];
    [self.naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    self.view.backgroundColor = [UIColor colorWithRed:241/255. green:247/255. blue:247/255. alpha:1.];
}

+(id)controller {
    return [[self class] controllerWithIdentifier:NSStringFromClass([self class])];
}

+(id)controllerWithIdentifier:(NSString *)identifier {
    
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
