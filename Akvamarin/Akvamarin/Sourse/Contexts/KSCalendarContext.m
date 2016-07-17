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

@interface KSCalendarContext ()
@property (nonatomic, strong) KSCalendar                     *calendar;
@property (nonatomic, strong) NSURLSession                   *URLSession;
@property (nonatomic, strong) NSURLSessionDataTask           *dataTask;

- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;
- (void)parseResult:(NSDictionary *)result;

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
#pragma mark Private Methods

- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateComponents *startDateComponents = [NSDateComponents componentsWithDate:startDate];
    NSDateComponents *endDateComponents = [NSDateComponents componentsWithDate:endDate];
    
    NSString *titleString = [NSString stringWithFormat:kKSTitleFormat, startDateComponents.hour,
                             startDateComponents.minute, endDateComponents.hour, endDateComponents.minute,
                             kKSStudioBusyKey];
    
    return titleString;
}

- (void)parseResult:(NSDictionary *)result {
    NSArray *array = [result valueForKeyPath:kKSItemsKey];
    NSMutableArray *events = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        NSString *ID = [dictionary valueForKey:KKSIDKey];
        KSEvent *event = [KSEvent objectWithID:ID];
        
        NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
        dayFormatter.dateFormat = kKSDateFormatKey;
        event.startDateTime = [dayFormatter dateFromString:[dictionary valueForKeyPath:kKSStartDateTimeKey]];
        event.endDateTime = [dayFormatter dateFromString:[dictionary valueForKeyPath:kKSEndDateTimeKey]];
        event.title = [self titleFromStartDate:event.startDateTime endDate:event.endDateTime];
    
        [events addObject:event];
    }
    
    [self.calendar setEvents:[NSSet setWithArray:events]];
}

#pragma mark -
#pragma mark Public Methods

- (void)execute {
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

- (void)cancel {
    [self.dataTask cancel];
}

@end