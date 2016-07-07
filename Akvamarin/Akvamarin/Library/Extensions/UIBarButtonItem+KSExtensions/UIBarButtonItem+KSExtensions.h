//
//  UIBarButtonItem+KSExtensions.h
//  KSTestFacebookProject
//
//  Created by KulikovS on 15.06.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (KSExtensions)
+ (UIBarButtonItem *)buttonWithImageName:(NSString *)imageName selector:(SEL)selector target:(id)target;

@end
