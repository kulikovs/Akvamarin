//
//  UITableView+KSExtensions.h
//  KSIdapStudy
//
//  Created by KulikovS on 05.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (KSExtensions)
- (id)dequeueReusableCellWithClass:(Class)theClass;
- (id)dequeueReusableCellFromNibWithClass:(Class)theClass;
- (id)dequeueReusableCellFromBundleWithClass:(Class)theClass;

@end
