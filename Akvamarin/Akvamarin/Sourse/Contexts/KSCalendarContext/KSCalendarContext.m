//
//  KSCalendarContext.m
//  Akvamarin
//
//  Created by KulikovS on 14.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>

#import "KSCalendarContext.h"
#import "KSCalendarConstants.h"
#import "KSCoreDataConstants.h"
#import "KSRequestConstants.h"
#import "KSCalendar.h"
#import "KSEvent.h"

@interface KSCalendarContext ()

- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
- (void)removeOldEventsWithCalendar:(KSCalendar *)calendar;

@end

@implementation KSCalendarContext

#pragma mark -
#pragma mark Accessors

- (NSURL *)requestURL {
    NSDateComponents *components = [NSDateComponents componentsWithDate:[NSDate date]];
    NSString *urlString = [NSString stringWithFormat:kKSCalendarUrlFormat,
                           kKSCalendarId, kKSMaxResult, (long)components.year, kKSApiKey];
    
    return [NSURL URLWithString:urlString];
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormatKey:kKSTimeFormatKey];
    NSString *startTime = [dateFormatter stringFromDate:startDate];
    NSString *endTime = [dateFormatter stringFromDate:endDate];
    
    return [NSString stringWithFormat:kKSTitleFormat, startTime, endTime, kKSStudioBusyKey];;
}

- (void)parseResult:(NSDictionary *)result {
    @synchronized (self) {
        [MagicalRecord saveWithBlock: ^(NSManagedObjectContext *localContext) {
            NSArray *array = [result valueForKeyPath:kKSItemsKey];
            KSCalendar *calendar = [KSCalendar objectWithID:kKSCalendarId context:localContext];
            [self removeOldEventsWithCalendar:calendar];
            
            for (NSDictionary *dictionary in array) {
                NSDateFormatter *dayFormatter = [NSDateFormatter dateFormatterWithFormatKey:kKSDateTimeFormatKey];
                NSDate *endDateTime = [dayFormatter dateFromString:
                                       [dictionary valueForKeyPath:kKSEndDateKey]];
                if ([[NSDate date] currentDateIsBeforeDay:endDateTime]) {
                    NSString *ID = [dictionary valueForKey:kKSIDKey];
                    KSEvent *event = [KSEvent objectWithID:ID context:localContext];
                    
                    event.startDateTime = [dayFormatter dateFromString:[dictionary valueForKeyPath:kKSStartDateKey]];
                    event.endDateTime = endDateTime;
                    event.title = [self titleFromStartDate:event.startDateTime endDate:event.endDateTime];
                    [calendar addEventsObject:event];
                }
            }
        } completion: ^(BOOL success, NSError *error) {
            if (!error) {
                [self setState:kKSModelStateLoaded withObject:nil];
            }
        }
         ];
    }
}

- (void)removeOldEventsWithCalendar:(KSCalendar *)calendar {
    for (KSEvent *event in calendar.events.allObjects) {
        if ([[NSDate new] currentDateIsAfterDay:event.endDateTime]) {
            [calendar removeEventsObject:event];
        }
    }
}

@end
