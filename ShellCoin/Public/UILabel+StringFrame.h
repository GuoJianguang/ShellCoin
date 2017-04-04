//
//  UILabel+StringFrame.h
//  Tourguide
//
//  Created by test on 15/4/1.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (StringFrame)
- (CGSize)boundingRectWithSize:(CGSize)size;

@end

@interface NSString(FrameSize)

- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*) font;

@end
