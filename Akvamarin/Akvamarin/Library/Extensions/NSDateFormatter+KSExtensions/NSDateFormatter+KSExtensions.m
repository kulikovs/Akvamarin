//
//  NSDateFormatter+KSExtensions.m
//  Akvamarin
//
//  Created by KulikovS on 16.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "NSDateFormatter+KSExtensions.h"

@implementation NSDateFormatter (KSExtensions)
+ (NSDateFormatter *)dateFormatterWithFormatKey:(NSString *)formatKey {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatKey];
    
    return dateFormatter;
}

@end
