//
//  SetPasswordViewController.m
//  ShellCoin
//
//  Created by Guo on 2017/3/14.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "SetPayPasswordViewController.h"
#import "ChangeLoginPasswordViewController.h"
#import "ChangePayPasswordViewController.h"



@interface SetPasswordViewController ()

@property (nonatomic, assign)BOOL isHavePayPassowrd;

@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)loginBtn:(id)sender {
    ChangeLoginPasswordViewController *changeLoginVC = [[ChangeLoginPasswordViewController alloc]init];
    [self.navigationController pushViewController:changeLoginVC animated:YES];
}

- (IBAction)paypasswordBtn:(id)sender {
    self.isHavePayPassowrd = YES;
    if (self.isHavePayPassowrd) {
        ChangePayPasswordViewController *changePasswordVC = [[ChangePayPasswordViewController alloc]init];
        [self.navigationController pushViewController:changePasswordVC animated:YES];
        return;
    }
    SetPayPasswordViewController *setPayPasswordVC = [[SetPayPasswordViewController alloc]init];
    [self.navigationController pushViewController:setPayPasswordVC animated:YES];
}
@end
