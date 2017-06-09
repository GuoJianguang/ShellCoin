//
//  RecommendMerchantView.h
//  HuiDian
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 Huidian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendMerchantView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (void)reload;
@end
