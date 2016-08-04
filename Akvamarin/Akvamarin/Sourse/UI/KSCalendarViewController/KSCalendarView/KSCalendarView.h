//
//  KSCalendarView.h
//  Akvamarin
//
//  Created by KulikovS on 09.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSView.h"

@class CKCalendarView;

@interface KSCalendarView : KSView
@property (nonatomic, strong) IBOutlet UIView           *subView;
@property (nonatomic, strong) IBOutlet UIButton         *reserveButton;
@property (nonatomic, strong)          CKCalendarView   *calendarView;

@end
