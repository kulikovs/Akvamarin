//
//  UIBarButtonItem+KSExtensions.m
//  KSTestFacebookProject
//
//  Created by KulikovS on 15.06.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "UIBarButtonItem+KSExtensions.h"

@implementation UIBarButtonItem (KSExtensions)

+ (UIBarButtonItem *)buttonWithImageName:(NSString *)imageName selector:(SEL)selector target:(id)target {
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return [[UIBarButtonItem alloc] initWithImage:image
                                            style:UIBarButtonItemStyleDone
                                           target:target
                                           action:selector];
}

@end
