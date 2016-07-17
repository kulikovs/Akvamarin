//
//  KSCalendar+CoreDataProperties.h
//  Akvamarin
//
//  Created by KulikovS on 15.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KSCalendar.h"

@class KSEvent;

NS_ASSUME_NONNULL_BEGIN

@interface KSCalendar (CoreDataProperties)
@property (nonatomic, strong) NSSet     <KSEvent *>     *events;

@end

@interface KSCalendar (CoreDataGeneratedAccessors)

- (void)addEventsObject:(KSEvent *)value;
- (void)removeEventsObject:(KSEvent *)value;
- (void)addEvents:(NSSet<KSEvent *> *)values;
- (void)removeEvents:(NSSet<KSEvent *> *)values;

@end

NS_ASSUME_NONNULL_END
