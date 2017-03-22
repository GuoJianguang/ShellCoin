//
//  BillAmountDisciplineView.h
//  ShellCoin
//
//  Created by Guo on 2017/3/22.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillAmountDisciplineView : UIView

@property (weak, nonatomic) IBOutlet UISegmentedControl *switchView;

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

- (IBAction)switchView:(id)sender;




@end
