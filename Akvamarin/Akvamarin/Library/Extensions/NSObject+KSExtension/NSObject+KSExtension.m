//
//  NSObject+KSObject.m
//  KSIdapStudy
//
//  Created by KulikovS on 24.02.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "NSObject+KSExtension.h"

@implementation NSObject (KSObject)

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger index = 0; index < count; index++) {
        id object = [self new];
        [array addObject:object];
    }
    
    return [array copy];
}

@end
