//
//  KSStartViewController.m
//  Akvamarin
//
//  Created by KulikovS on 17.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSStartViewController.h"
#import "KSCalendarViewController.h"
#import "KSCalendar.h"
#import "KSCalendarConstants.h"
#import "KSStartView.h"

@interface KSStartViewController ()
@property (nonatomic, readonly) KSStartView      *rootView;

@end

@implementation KSStartViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSStartView);

#pragma mark -
#pragma mark Handling

- (IBAction)onClickCalendar:(id)sender {
    KSCalendarViewController *calendarController = [KSCalendarViewController new];
    calendarController.calendar = [KSCalendar objectWithID:kKSCalendarId];

    [self.navigationController pushViewController:calendarController animated:YES];
}



@end
