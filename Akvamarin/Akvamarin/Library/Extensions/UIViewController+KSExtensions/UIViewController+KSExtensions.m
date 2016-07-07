//
//  UIViewController+KSExtentions.m
//  KSIdapStudy
//
//  Created by KulikovS on 26.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "UIViewController+KSExtensions.h"

@implementation UIViewController (KSExtentions)

+ (instancetype)controllerFromNib {
    return [self controllerFromNibWithName:NSStringFromClass([self class])];
}

+ (instancetype)controllerFromNibWithName:(NSString *)className {
    return [[[self class] alloc] initWithNibName:className bundle:[NSBundle mainBundle]];
}

@end
