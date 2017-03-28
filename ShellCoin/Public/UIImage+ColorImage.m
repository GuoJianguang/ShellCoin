//
//  UIImage+ColorImage.m
//  TourGuide
//
//  Created by tongbu_jinzhongjun on 14/12/15.
//  Copyright (c) 2014年 Bowen fan. All rights reserved.
//

#import "UIImage+ColorImage.h"

@implementation UIImage (ColorImage)

+(UIImage*)imageWithColor:(UIColor*) color frame:(CGRect) rect{
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

+(UIImage *)imageWithColor:(UIColor *)color {

    return [self imageWithColor:color frame:CGRectZero];
}


@end
