//
//  KSCalendarViewController.m
//  Akvamarin
//
//  Created by KulikovS on 09.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>
#import "CalendarKit.h"

#import "NSCalendarCategories.h"
#import "NSDate+Components.h"
#import "NSCalendar+DateComparison.h"
#import "KSCalendarViewController.h"
#import "KSCalendarView.h"
#import "KSCalendarContext.h"
#import "KSCalendar.h"
#import "KSEvent.h"
#import "KSReserveViewController.h"
#import "KSAlertViewConstants.h"

static NSString * const kKSCalendarBarTitle = @"Аренда студии";

@interface KSCalendarViewController () <CKCalendarViewDataSource>
@property (nonatomic, readonly) KSCalendarView *rootView;

- (void)loadCalendarView;
- (NSArray *)sortedEventsArray:(NSArray *)events;

@end

@implementation KSCalendarViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSCalendarView);

- (NSString *)navigationBarTitle {
    return kKSCalendarBarTitle;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rootView showLoadingViewWithDefaultTextAnimated:YES];
}

#pragma mark -
#pragma mark Public Methods

- (void)contextDidLoad {
    self.calendar = [KSCalendar MR_findFirst];
    [self loadCalendarView];
    [self.rootView removeLoadingViewAnimated:NO];
}

- (void)contextLoadFailed {
    [self showAlertViewWithTitle:kKSLoadingErrorTitle message:kKSCalendarNotUpdateString actionHandler:nil];
    [self contextDidLoad];
}

#pragma mark -
#pragma mark Private Methods

- (void)loadCalendarView {
    CKCalendarView *calendarView = self.rootView.calendarView;
    calendarView = [CKCalendarView new];
    calendarView.firstWeekDay = 2;
    [calendarView setDataSource:self];
    [self.rootView.subView addSubview:calendarView];
}

- (NSArray *)sortedEventsArray:(NSArray *)events {
    id comparisonResult = ^NSComparisonResult(KSEvent *event1, KSEvent *event2) {
        return [event1.startDateTime compare:event2.startDateTime];
    };
    
    return [events sortedArrayUsingComparator:comparisonResult];
}

#pragma mark -
#pragma mark Handling

- (IBAction)onClickReserveButton:(id)sender {
    KSReserveViewController *reserveController = [KSReserveViewController new];
    [self.navigationController pushViewController:reserveController animated:YES];
}

#pragma mark -
#pragma mark CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date {
    NSArray *sortedEventArray = [self sortedEventsArray:self.calendar.events.allObjects];
    NSMutableArray *dateEvents = [NSMutableArray array];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    for (KSEvent *event in sortedEventArray) {
        NSDate *startDateTime = event.startDateTime;
        if ([calendar date:date isSameDayAs:startDateTime]) {
            CKCalendarEvent *ckEvent = [CKCalendarEvent eventWithTitle:event.title
                                                               andDate:startDateTime andInfo:nil];
            [dateEvents addObject:ckEvent];
        }
    }
    
    return [dateEvents copy];
}

@end


