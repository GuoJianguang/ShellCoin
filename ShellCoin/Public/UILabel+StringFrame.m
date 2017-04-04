//
//  UILabel+StringFrame.m
//  Tourguide
//
//  Created by test on 15/4/1.
//  Copyright (c) 2015年 inphase. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation NSString(FrameSize)

-(CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font {
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [self boundingRectWithSize:size
                                        options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
    
}

@end

@implementation UILabel (StringFrame)


- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}


@end
