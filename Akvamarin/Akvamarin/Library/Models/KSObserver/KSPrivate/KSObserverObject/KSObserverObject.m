//
//  KSObserverObject.m
//  KSIdapStudy
//
//  Created by KulikovS on 13.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSObserverObject.h"

@interface KSObserverObject ()
@property (nonatomic, weak) id                object;
@property (nonatomic, copy) KSHandlerObject   handler;

@end

@implementation KSObserverObject

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithObject:nil handler:nil];
}

- (instancetype)initWithObject:(id)object handler:(KSHandlerObject)handler {  
    self = [super init];
    if (self) {
        self.object = object;
        self.handler = [handler copy];
    }
    
    return self;
}

@end
