//
//  NSBundle+KSExtensions.m
//  KSIdapStudy
//
//  Created by KulikovS on 19.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "NSBundle+KSExtensions.h"

@implementation NSBundle (KSExtensions)

+ (NSString *)pathToFileWithName:(NSString *)name {
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
}

@end
