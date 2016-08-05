//
//  KSCalendarContext.m
//  Akvamarin
//
//  Created by KulikovS on 14.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSCalendarContext.h"
#import "KSCalendarConstants.h"
#import "KSCoreDataConstants.h"
#import "KSRequestConstants.h"
#import "KSCalendar.h"
#import "KSEvent.h"
#import "NSCalendar+Ranges.h"

@interface KSCalendarContext ()
@property (nonatomic, strong) KSCalendar *calendar;

- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end

@implementation KSCalendarContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithCalendar:(KSCalendar *)calendar {
    self = [super init];
    if (self) {
        self.calendar = calendar;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSURL *)requestURL {
    NSString *urlString = [NSString stringWithFormat:kKSCalendarUrlFormat, kKSCalendarId, kKSApiKey];
    return [NSURL URLWithString:urlString];
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kKSTimeFormatKey];
    
    NSString *startTime = [dateFormatter stringFromDate:startDate];
    NSString *endTime = [dateFormatter stringFromDate:endDate];
    
    return [NSString stringWithFormat:kKSTitleFormat, startTime, endTime, kKSStudioBusyKey];;
}

- (void)parseResult:(NSDictionary *)result {
    @synchronized (self) {
        NSArray *array = [result valueForKeyPath:kKSItemsKey];
        NSMutableArray *events = [NSMutableArray array];
        
        for (NSDictionary *dictionary in array) {
            NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
            dayFormatter.dateFormat = kKSDateTimeFormatKey;
            NSDate *endDateTime = [dayFormatter dateFromString:
                                   [dictionary valueForKeyPath:kKSEndDateKey]];
            
            if ([[NSDate date] timeIntervalSinceDate:endDateTime] < 0) {
                NSString *ID = [dictionary valueForKey:KKSIDKey];
                KSEvent *event = [KSEvent objectWithID:ID];
                event.startDateTime = [dayFormatter dateFromString:
                                       [dictionary valueForKeyPath:kKSStartDateKey]];
                event.endDateTime = endDateTime;
                event.title = [self titleFromStartDate:event.startDateTime endDate:event.endDateTime];
                
                [events addObject:event];
            }
        }
        
        [self.calendar setEvents:[NSSet setWithArray:events]];
        [self.calendar saveManagedObject];
    }
}


@end