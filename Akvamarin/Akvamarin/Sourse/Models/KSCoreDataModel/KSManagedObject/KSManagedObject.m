//
//  KSManagedObject.m
//  KSTestFacebookProject
//
//  Created by KulikovS on 17.06.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>

#import "KSManagedObject.h"
#import "KSCoreDataConstants.h"

@implementation KSManagedObject

@dynamic ID;

#pragma mark -
#pragma mark Initializations and Deallocations

+ (instancetype)objectWithID:(NSString *)ID {
    return [self MR_findFirstOrCreateByAttribute:kKSIDKey withValue:ID];
}

+ (instancetype)objectWithID:(NSString *)ID context:(NSManagedObjectContext *)context {
    return [self MR_findFirstOrCreateByAttribute:kKSIDKey withValue:ID inContext:context];
}

#pragma mark -
#pragma mark Accessors

- (void)setID:(NSString *)ID {
    [self setValue:ID forKey:kKSIDKey];
}

- (NSString *)ID {
    return [self valueForKey:kKSIDKey];
}


@end
