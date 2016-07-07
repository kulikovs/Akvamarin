//
//  KSObserverArray.m
//  KSIdapStudy
//
//  Created by KulikovS on 13.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSObserverArray.h"
#import "KSObserverObject.h"

@interface KSObserverArray ()
@property (nonatomic, retain) NSMutableArray *handlersArray;

@end

@implementation KSObserverArray

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.handlersArray = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.handlersArray = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)handlers {
    return [self.handlersArray copy];
}

#pragma mark -
#pragma mark Public Methods

- (void)addHandler:(KSHandlerObject)handler forObject:(id)object {
    KSObserverObject *observerObject = [[KSObserverObject alloc] initWithObject:object
                                                                         handler:handler];
    [self.handlersArray addObject:observerObject];
}

- (void)removeHandlersForObject:(id)object {
    NSArray *objects = [self.handlers copy];
    for (KSObserverObject *observerObject in objects) {
        if (observerObject.object == object) {
            [self.handlersArray removeObject:observerObject];
        }
    }
}

- (void)removeAllHandlers {
    [self.handlersArray removeAllObjects];
}

@end