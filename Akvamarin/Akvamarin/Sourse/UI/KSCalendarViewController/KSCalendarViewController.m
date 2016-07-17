//
//  KSCalendarViewController.m
//  Akvamarin
//
//  Created by KulikovS on 09.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "CalendarKit.h"

#import "KSCalendarViewController.h"
#import "KSCalendarView.h"
#import "KSCalendarContext.h"
#import "KSCalendar.h"
#import "KSCalendarConstants.h"


@interface KSCalendarViewController ()
@property (nonatomic, readonly) KSCalendarView      *rootView;
@property (nonatomic, strong)   KSCalendarContext   *context;
@property (nonatomic, strong)   KSCalendar          *calendar;


- (void)setCalendarWithID:(NSString *)IDString;

@end

@implementation KSCalendarViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSCalendarView);

- (void)setContext:(KSCalendarContext *)context {
    if (_context != context) {
        [_context cancel];
        _context = context;
        [_context execute];
    }
}

- (void)setCalendar:(KSCalendar *)calendar {
    if (_calendar != calendar) {
        _calendar = calendar;
        
        self.context = [[KSCalendarContext alloc] initWithCalendar:calendar];
    }
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCalendarWithID:kKSCalendarId];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Private Methods

- (void)setCalendarWithID:(NSString *)IDString {
    self.calendar = [KSCalendar objectWithID:IDString];
    
    CKCalendarView *calendarView = [CKCalendarView new];
    //    [calendarView setDelegate:self];
    //    [calendarView setDataSource:self];
    [self.rootView addSubview:calendarView];
}

- (void)createCalendar {

    
}

//NSCalendar *calendar = [NSCalendar currentCalendar];
//NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:startDateTime];
//
//
//- (void)nsdateWithComponents {
//NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//[dateComponents setYear:2014];
//[dateComponents setMonth:1];
//[dateComponents setDay:28];
//[dateComponents setHour:11];
//[dateComponents setMinute:9];
//
//NSCalendar *calendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSGregorianCalendar];
//NSDate *configuredDate = [calendar dateFromComponents:dateComponents];
//}
//
//- (void)parseCalendar {
//    NSDate *date = [NSDate date];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setHour:15];
//    [components setMinute:55];
//    
//    NSString *calendarId = @"ubvnm5gta74qgg9vrfclv99nl4@group.calendar.google.com";
//    NSString *apiKey = @"AIzaSyDtYcy1F9oeUXwjREGM5YnlndEGn0d_luM";
//    NSString *urlFormat = @"https://www.googleapis.com/calendar/v3/calendars/%@/events?key=%@&fields=items(id,start,summary,status)";
//    NSString *calendarUrl = [NSString stringWithFormat:urlFormat, calendarId, apiKey];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:calendarUrl]];
//        [request setHTTPMethod:@"GET"];
//
//        
//        self.dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
//                                                        completionHandler:^(NSData *data,
//                                                                            NSURLResponse *response,
//                                                                            NSError *error) {
//                                                            if (!error) {
//                                                                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                                                NSLog(@"Log");
//  
//                                                            }}];
//        [self.dataTask resume];
//    }


//AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//manager.responseSerializer = [AFJSONResponseSerializer serializer];
//[manager GET:calendarUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    // HTTP request succeeded!
//    for (NSDictionary *eventData in responseObject[@"items"]) {
//        NSLog(@"%@", eventData[@"summary"]);
//    }
//} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    // HTTP request failed!
//}];


@end

