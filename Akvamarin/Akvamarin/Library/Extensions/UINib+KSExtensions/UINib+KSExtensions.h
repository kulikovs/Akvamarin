//
//  UINib+KSExtensions.h
//  KSIdapStudy
//
//  Created by KulikovS on 09.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (KSExtensions)

+ (id)loadFromNibWithClass:(Class)theClass;
+ (instancetype)nibWithClass:(Class)theClass;

@end
