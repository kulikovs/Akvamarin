//
//  UIColor+KSExtensions.m
//  Akvamarin
//
//  Created by KulikovS on 06.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "UIColor+KSExtensions.h"

@implementation UIColor (KSExtensions)

+ (UIColor *)colorWithRedColor:(CGFloat)red
                    greenColor:(CGFloat)green
                     blueColor:(CGFloat)blue
                         alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

@end
