//
//  RealNameAutResultView.h
//  ShellCoin
//
//  Created by Guo on 2017/3/13.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,Authentication_type){
    Authentication_type_success = 1,//成功
    Authentication_type_fail = 2,//失败
    Authentication_wait_audit = 3,//等待审核
    Authentication_wait_success = 4//手动提交成功
};

@interface RealNameAutResultView : UIView

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *autResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *autResultTitleLabel;


@property (weak, nonatomic) IBOutlet UIImageView *alerResultImageView;


@property (nonatomic, assign)Authentication_type isSuccess;

@property (weak, nonatomic) IBOutlet UIImageView *titleimageView;



@end
