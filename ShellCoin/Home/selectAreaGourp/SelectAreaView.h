//
//  SelectAreaView.h
//  天添薪
//
//  Created by ttx on 16/1/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectAreaView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (IBAction)delet_btn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *backView;

//省会（一级）
@property (strong, nonatomic)  UITableView *firsttableview;
//市州（二级）
@property (strong, nonatomic)  UITableView *secondtableview;
//三级
@property (strong, nonatomic)  UITableView *thirdtableview;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *witdhConstraint;



@end
