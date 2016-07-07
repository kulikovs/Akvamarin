//
//  UIViewController+KSExtentions.h
//  KSIdapStudy
//
//  Created by KulikovS on 26.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KSExtentions)

+ (instancetype)controllerFromNib;
+ (instancetype)controllerFromNibWithName:(NSString *)className;

@end
