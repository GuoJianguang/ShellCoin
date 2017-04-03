//
//  SelectAreaView.m
//  天添薪
//
//  Created by ttx on 16/1/7.
//  Copyright © 2016年 ttx. All rights reserved.
//

#import "SelectAreaView.h"
#import "AreaTableViewCell.h"

@interface SelectAreaView()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SelectAreaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"SelectAreaView" owner:nil options:nil][0];
        self.frame = frame;
        [self sendSubviewToBack:self.backView];
        
        CGFloat tableWitdh = (frame.size.width - 1)/2;
        self.firsttableview.frame = CGRectMake(0, 70, tableWitdh , frame.size.height-70);
        self.secondtableview.frame = CGRectMake(CGRectGetMaxX(self.firsttableview.frame) +1, 70, tableWitdh, frame.size.height-70);
        
        self.thirdtableview.frame = CGRectMake(CGRectGetMaxX(self.secondtableview.frame ) + 1, 70, tableWitdh, frame.size.height-70);
        [self addSubview:self.firsttableview];
        [self addSubview:self.thirdtableview];
        [self addSubview:self.secondtableview];
    }

    return self;
}


//懒加载
- (UITableView *)firsttableview
{
    if (!_firsttableview) {
        _firsttableview = [[UITableView alloc]init];
        _firsttableview.backgroundColor = [UIColor clearColor];
        _firsttableview.delegate = self;
        _firsttableview.dataSource = self;
    }
    return _firsttableview;
}

- (UITableView *)secondtableview
{
    if (!_secondtableview) {
        _secondtableview = [[UITableView alloc]init];
        _secondtableview.backgroundColor = [UIColor clearColor];
        _secondtableview.delegate = self;
        _secondtableview.dataSource = self;
    }
    return _secondtableview;
}

- (UITableView *)thirdtableview
{
    if (!_thirdtableview) {
        _thirdtableview = [[UITableView alloc]init];
        _thirdtableview.backgroundColor = [UIColor clearColor];
        _thirdtableview.dataSource = self;
        _thirdtableview.delegate = self;
    }
    return _thirdtableview;
}




- (IBAction)delet_btn:(id)sender {
//    [UIView animateWithDuration:1.5 animations:^{
//        self.frame = CGRectMake(-TWitdh, 0, TWitdh, THeight);
//
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//
//    }];
    [self removeFromSuperview];

}


#pragma mark - UITableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AreaTableViewCell indentify]];
    if (!cell) {
        cell = [AreaTableViewCell newCell];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = self.frame;
    CGFloat tableWitdh = (frame.size.width - 2)/3;
    self.firsttableview.frame = CGRectMake(0, 70, tableWitdh, frame.size.height-70);
    self.secondtableview.frame = CGRectMake(CGRectGetMaxX(self.firsttableview.frame) +1, 70, tableWitdh, frame.size.height-70);
    self.thirdtableview.frame = CGRectMake(CGRectGetMaxX(self.secondtableview.frame ) + 1, 70, tableWitdh, frame.size.height-70);
}


@end
