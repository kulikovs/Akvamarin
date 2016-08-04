//
//  KSCalendarViewController.h
//  Akvamarin
//
//  Created by KulikovS on 09.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSCalendar;

@interface KSCalendarViewController : UIViewController
@property (nonatomic, strong) KSCalendar  *calendar;

- (IBAction)onResereButtonClick:(id)sender;

@end
