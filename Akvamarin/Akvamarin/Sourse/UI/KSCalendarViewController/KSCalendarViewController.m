//
//  KSCalendarViewController.m
//  Akvamarin
//
//  Created by KulikovS on 09.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "CalendarKit.h"
#import "NSCalendarCategories.h"
#import "NSDate+Components.h"
#import "NSCalendar+DateComparison.h"

#import "KSCalendarViewController.h"
#import "KSCalendarView.h"
#import "KSCalendarContext.h"
#import "KSCalendar.h"
#import "KSEvent.h"

@interface KSCalendarViewController () <CKCalendarViewDataSource>
@property (nonatomic, readonly) KSCalendarView      *rootView;
@property (nonatomic, strong)   KSCalendarContext   *context;

- (void)addHandlers;
- (void)contextDidLoad;
- (void)contextLoadFailed;
- (void)loadCalendarView;

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
        [_context load];
        
        [self addHandlers];
    }
}

- (void)setCalendar:(KSCalendar *)calendar {
    if (_calendar != calendar) {
        _calendar = calendar;
        
        self.context = [[KSCalendarContext alloc] initWithCalendar:calendar];
    }
}

- (CKCalendarView *)calendarView {
    return self.rootView.calendarView;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rootView showLoadingViewWithDefaultTextAnimated:YES];
}

#pragma mark -
#pragma mark Private Methods

- (void)addHandlers {
    KSWeakifySelf;
    [_context addHandler:^(id object) {
        KSStrongifySelfAndReturnIfNil;
        KSDispatchAsyncOnMainThread(^{
            [strongSelf contextDidLoad];
        });
    }
                   state:kKSModelStateLoaded
                  object:self];
    
    [_context addHandler:^(id object) {
        KSStrongifySelfAndReturnIfNil;
        KSDispatchAsyncOnMainThread(^{
            [strongSelf contextLoadFailed];
        });
    }
                   state:kKSModelStateFailed
                  object:self];
}

- (void)contextDidLoad {
    [self loadCalendarView];
    [self.rootView removeLoadingViewAnimated:NO];
}

- (void)contextLoadFailed {
    [self contextDidLoad];
}

- (void)loadCalendarView {
    CKCalendarView *calendarView = self.calendarView;
    calendarView  = [CKCalendarView new];
    [calendarView setDataSource:self];
    [self.rootView.subView addSubview:calendarView];
}

#pragma mark -
#pragma mark CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date {
    NSArray *events = self.calendar.events.allObjects;
    NSMutableArray *dateEvents = [NSMutableArray array];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    for (KSEvent *event in events) {
        NSDate *startDateTime = event.startDateTime;
        if ([calendar date:date isSameDayAs:startDateTime]) {
            CKCalendarEvent *ckEvent = [CKCalendarEvent eventWithTitle:event.title andDate:startDateTime andInfo:nil];
            [dateEvents addObject:ckEvent];
        }
    }
    
    return [dateEvents copy];
}

@end


