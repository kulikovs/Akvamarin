//
//  UITableView+KSExtensions.m
//  KSIdapStudy
//
//  Created by KulikovS on 05.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "UITableView+KSExtensions.h"

@implementation UITableView (KSExtensions)

- (id)dequeueReusableCellWithClass:(Class)theClass {
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(theClass)];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:NSStringFromClass(theClass)];
    }
    
    return cell;
}

- (id)dequeueReusableCellFromNibWithClass:(Class)theClass {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(theClass)];
    if (!cell) {
        cell = [UINib loadFromNibWithClass:(theClass)];
    }
    
    return cell;
}

- (id)dequeueReusableCellFromBundleWithClass:(Class)theClass {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(theClass)];
    if (!cell) {
        NSBundle *bundle = [NSBundle mainBundle];
        cell = [[bundle loadNibNamed:NSStringFromClass(theClass) owner:self options:nil] firstObject];
    }
    
    return cell;
}

@end
