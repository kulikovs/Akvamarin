//
//  KSEvent+CoreDataProperties.h
//  Akvamarin
//
//  Created by KulikovS on 15.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KSEvent.h"

@class KSCalendar;

NS_ASSUME_NONNULL_BEGIN

@interface KSEvent (CoreDataProperties)
@property (nonatomic, strong) NSString      *title;
@property (nonatomic, strong) NSDate        *startDateTime;
@property (nonatomic, strong) NSDate        *endDateTime;
@property (nonatomic, strong) KSCalendar    *calendar;

@end

NS_ASSUME_NONNULL_END
