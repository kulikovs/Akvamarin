//
//  KSCalendarContext.h
//  Akvamarin
//
//  Created by KulikovS on 14.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KSModel.h"

@class KSCalendar;

@interface KSCalendarContext : KSModel

- (instancetype)initWithCalendar:(KSCalendar *)calendar;
- (void)cancel;

@end
