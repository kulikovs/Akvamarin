//
//  UIWindow+KSExtension.m
//  KSIdapStudy
//
//  Created by KulikovS on 04.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "UIWindow+KSExtension.h"

@implementation UIWindow (KSExtension)

+ (UIWindow *)window {
    return [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}



@end
