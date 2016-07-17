//
//  NSDateComponents+KSExtensions.m
//  Akvamarin
//
//  Created by KulikovS on 17.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "NSDateComponents+KSExtensions.h"

@implementation NSDateComponents (KSExtensions)

+ (NSDateComponents *)componentsWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
   
    return [calendar components:(NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |
                                 NSCalendarUnitHour | NSCalendarUnitMinute)
                       fromDate:date];
}
@end
