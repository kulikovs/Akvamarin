//
//  KSCalendarView.h
//  Akvamarin
//
//  Created by KulikovS on 09.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSView.h"

@class CKCalendarView;

@interface KSCalendarView : UIView
@property (nonatomic, strong) IBOutlet KSView           *subView;
@property (nonatomic, strong)          CKCalendarView   *calendarView;

@end
