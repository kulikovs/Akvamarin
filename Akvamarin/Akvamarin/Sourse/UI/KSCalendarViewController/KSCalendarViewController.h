//
//  KSCalendarViewController.h
//  Akvamarin
//
//  Created by KulikovS on 09.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KSCustomViewController.h"

@class KSCalendar;

@interface KSCalendarViewController : KSCustomViewController
@property (nonatomic, strong) KSCalendar  *calendar;

- (IBAction)onReserveButtonClick:(id)sender;

@end
