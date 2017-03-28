//
//  UIImage+ColorImage.h
//  TourGuide
//
//  Created by tongbu_jinzhongjun on 14/12/15.
//  Copyright (c) 2014年 Bowen fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)

+(UIImage*)imageWithColor:(UIColor*) color frame:(CGRect) rect;
+(UIImage*) imageWithColor:(UIColor *)color ;

@end
