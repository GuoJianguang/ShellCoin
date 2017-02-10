//
//  ManageBankView.m
//  ShellCoin
//
//  Created by Guo on 2017/2/10.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import "ManageBankView.h"

@implementation ManageBankView
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.editBtn.layer.cornerRadius = 17;
    self.editBtn.layer.masksToBounds = YES;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"ManageBankView" owner:nil options:nil][0];
    }
    return self;
}

- (IBAction)editBtn:(id)sender {
}
@end
