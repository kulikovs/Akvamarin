//
//  NSDate+KSExtensions.m
//  Akvamarin
//
//  Created by KulikovS on 23.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "NSDate+KSExtensions.h"

@implementation NSDate (KSExtensions)

- (BOOL)currentDateIsAfterDay:(NSDate *)date {
    return  [[NSDate date] timeIntervalSinceDate:date] < 0;
}

@end
