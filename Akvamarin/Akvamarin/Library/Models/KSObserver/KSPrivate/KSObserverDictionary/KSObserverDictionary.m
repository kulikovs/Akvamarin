//
//  KSObserverDictionary.m
//  KSIdapStudy
//
//  Created by KulikovS on 13.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSObserverDictionary.h"
#import "KSObserverArray.h"
#import "KSObserverObject.h"

@interface KSObserverDictionary ()
@property (nonatomic, assign) NSUInteger        state;
@property (nonatomic, retain) KSObserverArray   *observerArray;

@end

@implementation KSObserverDictionary

#pragma mark -
#pragma mark Class Methods

+ (instancetype)dictionaryWithState:(NSUInteger)state {
    return [[self alloc] initWithState:state];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self.observerArray removeAllHandlers];
    self.observerArray = nil;
}

- (instancetype)init {
    return [self initWithState:0];
}

- (instancetype)initWithState:(NSUInteger)state {
    self = [super init];
    if (self) {
        self.observerArray = [[KSObserverArray alloc] init];
        self.state = state;
    }
    
    return self;
}

#pragma mark -
#pragma mark - Accessors

- (NSArray *)handlers {
    [self.observerArray removeHandlersForObject:nil];
    
    NSMutableArray *handlers = [NSMutableArray array];
    for (KSObserverObject *object in self.observerArray.handlers) {
        [handlers addObject:object.handler];
    }
    
    return [handlers copy];
}

#pragma mark -
#pragma mark - Public Methods

- (void)addHandler:(KSHandlerObject)handler object:(id)object {
    [self.observerArray addHandler:handler forObject:object];
}

- (void)removeHandlersForObject:(id)object {
    [self.observerArray removeHandlersForObject:object];
}

@end