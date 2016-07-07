//
//  UINib+KSExtensions.m
//  KSIdapStudy
//
//  Created by KulikovS on 09.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "UINib+KSExtensions.h"

@implementation UINib (KSExtensions)

+ (id)loadFromNibWithClass:(Class)theClass {
    UINib *nib = [self nibWithClass:theClass];
    
    NSArray *array = [nib instantiateWithOwner:self options:nil];
    for (id object in array) {
        if ([object isMemberOfClass:[theClass class]]) {
            return object;
        }
    }
    
    return nil;
}

+ (instancetype)nibWithClass:(Class)theClass {
    return [UINib nibWithNibName:NSStringFromClass(theClass) bundle:[NSBundle mainBundle]];
}

@end
