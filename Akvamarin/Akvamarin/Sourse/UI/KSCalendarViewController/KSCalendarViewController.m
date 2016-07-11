//
//  KSCalendarViewController.m
//  Akvamarin
//
//  Created by KulikovS on 09.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLCalendar.h"

#import "KSCalendarViewController.h"
#import "KSCalendarView.h"

static NSString * const kKSCalendarURLString = @"https://calendar.google.com/calendar/embed?src=q962o107vv3t9t3pfmkrkuj6is@group.calendar.google.com&wkst=2&mode=WEEK&showPrint=0&showTabs=0&showCalendars=0&showTz=0&showTitle=0&ctz=Europe/Kiev";

@interface KSCalendarViewController ()
@property (nonatomic, readonly) KSCalendarView *rootView;

- (void)loadCalendar;

@end

@implementation KSCalendarViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSCalendarView);

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadCalendar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark -
#pragma mark Private Methods

- (void)loadCalendar {
    NSURL *urlCalendar = [NSURL URLWithString:kKSCalendarURLString];
    [self.rootView.webView loadRequest:[NSURLRequest requestWithURL:urlCalendar]];
}

@end

