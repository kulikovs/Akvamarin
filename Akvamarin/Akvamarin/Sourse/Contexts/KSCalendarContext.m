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
#import "KSCalendar.h"
#import "KSEvent.h"
#import "NSCalendar+Ranges.h"

@interface KSCalendarContext ()
@property (nonatomic, strong) KSCalendar                     *calendar;
@property (nonatomic, strong) NSURLSession                   *URLSession;
@property (nonatomic, strong) NSURLSessionDataTask           *dataTask;

- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
- (void)parseResult:(NSDictionary *)result;
- (void)dump;

@end

@implementation KSCalendarContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithCalendar:(KSCalendar *)calendar {
    self = [super init];
    if (self) {
        self.URLSession = [NSURLSession sessionWithConfiguration:
                           [NSURLSessionConfiguration defaultSessionConfiguration]];
        
        self.calendar = calendar;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)prepareToLoad {
    @synchronized (self) {
        [self dump];
        
        NSString *calendarUrl = [NSString stringWithFormat:kKSCalendarUrlFormat, kKSCalendarId, kKSApiKey];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:calendarUrl]];
        [request setHTTPMethod:kKSHTTPMethod];
        
        id block = ^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [self setState:kKSModelStateFailed withObject:nil];
            } else {
                [self parseResult:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                [self.calendar saveManagedObject];
                [self setState:kKSModelStateLoaded withObject:nil];
            }};
        
        self.dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:block];
        
        [self.dataTask resume];
    }
}

- (void)cancel {
    [self.dataTask cancel];
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kKSTimeFormateKey];
    
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
            dayFormatter.dateFormat = kKSDateFormatKey;
            NSDate *endDateTime = [dayFormatter dateFromString:
                                   [dictionary valueForKeyPath:kKSEndDateTimeKey]];
            
            if ([[NSDate date] timeIntervalSinceDate:endDateTime] < 0) {
                NSString *ID = [dictionary valueForKey:KKSIDKey];
                KSEvent *event = [KSEvent objectWithID:ID];
                event.startDateTime = [dayFormatter dateFromString:
                                       [dictionary valueForKeyPath:kKSStartDateTimeKey]];
                event.endDateTime = endDateTime;
                event.title = [self titleFromStartDate:event.startDateTime endDate:event.endDateTime];
                
                [events addObject:event];
            }
        }
        
        [self.calendar setEvents:[NSSet setWithArray:events]];
    }
}

- (void)dump {
    self.state = kKSModelStateUndefined;
}

@end