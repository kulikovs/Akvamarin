//
//  NSDateComponents+KSExtensions.h
//  Akvamarin
//
//  Created by KulikovS on 17.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateComponents (KSExtensions)

// DateComponents for the current calendar with the year, month, day, hour, minute
+ (NSDateComponents *)componentsWithDate:(NSDate *)date;

@end
