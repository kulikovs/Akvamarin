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
#import "KSRequestConstants.h"
#import "KSStartView.h"
#import "KSPhotoZoneViewController.h"
#import "KSPhotoZoneContext.h"
#import "KSPriceViewController.h"

@interface KSStartViewController ()
@property (nonatomic, readonly) KSStartView      *rootView;

@end

@implementation KSStartViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSStartView);

#pragma mark -
#pragma mark View LifeCycle

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark -
#pragma mark Handling

- (IBAction)onCalendarButtonClick:(id)sender {
    KSCalendarViewController *calendarController = [KSCalendarViewController new];
    calendarController.calendar = [KSCalendar objectWithID:kKSCalendarId];

    [self.navigationController pushViewController:calendarController animated:YES];
}

- (IBAction)onPhotoZoneButtonClick:(id)sender {
    KSPhotoZoneViewController *photoZoneController = [KSPhotoZoneViewController new];
    photoZoneController.context = [KSPhotoZoneContext new];
    
    [self.navigationController pushViewController:photoZoneController animated:YES];
}

- (IBAction)onPriceButtonClick:(id)sender {
    KSPriceViewController *priceViewController = [KSPriceViewController new];
    [self.navigationController pushViewController:priceViewController animated:YES];
}

@end
