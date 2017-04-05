//
//  NothingView.h
//  Tourguide
//
//  Created by 郭建光 on 15/4/11.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NothingView : UIView

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

- (IBAction)refresh:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *refresh_btn;

@property (nonatomic, copy) void (^refreshCallback)();


@property (weak, nonatomic) IBOutlet UIImageView *error_image;



@end
