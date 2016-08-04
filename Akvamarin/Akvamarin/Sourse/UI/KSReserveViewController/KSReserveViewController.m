//
//  KSReserveViewController.m
//  Akvamarin
//
//  Created by KulikovS on 25.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSReserveViewController.h"
#import "KSReserveView.h"
#import "KSCalendarConstants.h"

@interface KSReserveViewController ()
@property (nonatomic, readonly) KSReserveView *rootView;

@end

@implementation KSReserveViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSReserveView)

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kKSTimeFormatKey];
    
    NSString *startTime = [dateFormatter stringFromDate:startDate];
    NSString *endTime = [dateFormatter stringFromDate:endDate];
    
    return [NSString stringWithFormat:kKSTitleFormat, startTime, endTime, kKSStudioBusyKey];;
}

- (void)test {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kKSDateFormatKey];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:kKSTimeFormatKey];
    
    NSString *startTime = [timeFormatter stringFromDate:self.rootView.startTime.date];
    NSString *endTime = [timeFormatter stringFromDate:self.rootView.endTime.date];
    NSString *date = [dateFormatter stringFromDate:self.rootView.date.date];
    
    NSString *name = self.rootView.name.text;
    NSString *email = self.rootView.email.text;
    NSString *telephoneNumber = self.rootView.telephonNumber.text;

    NSLog(@"");
}

- (void)onSendMail:(id)sender {
    [self test];
}
@end
