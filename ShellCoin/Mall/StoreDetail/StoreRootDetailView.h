//
//  StoreRootDetailView.h
//  ShellCoin
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreRootDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UILabel *commendLabel;
@property (weak, nonatomic) IBOutlet UIView *commendLine;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)phoneBtn:(UIButton *)sender;

@end
