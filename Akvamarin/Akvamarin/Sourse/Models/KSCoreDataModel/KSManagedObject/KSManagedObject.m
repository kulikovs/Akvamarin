//
//  KSManagedObject.m
//  KSTestFacebookProject
//
//  Created by KulikovS on 17.06.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSManagedObject.h"
#import "KSCoreDataConstants.h"

@implementation KSManagedObject

@dynamic ID;

#pragma mark -
#pragma mark Initializations and Deallocations

+ (instancetype)objectWithID:(NSString *)ID {
    KSManagedObject *object = [self findObjectWithID:ID];
    if (object) {
        return object;
    }
    
    object = [self managedObject];
    object.ID = ID;
    
    return object;
}

#pragma mark -
#pragma mark Accessors

- (void)setID:(NSString *)ID {
    [self setCustomValue:ID forKey:KKSIDKey];
}

- (NSString *)ID {
    return [self customValueForKey:KKSIDKey];
}

#pragma mark -
#pragma mark Public Methods

+ (instancetype)findObjectWithID:(NSString *)ID {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",KKSIDKey, ID];
    
    return [[[self class] fetchEntityWithSortDescriptors:nil predicate:predicate prefetchPaths:nil] firstObject];
}

@end
