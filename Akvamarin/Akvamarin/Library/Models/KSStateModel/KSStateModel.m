//
//  KSStateModel.m
//  KSIdapStudy
//
//  Created by KulikovS on 12.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSStateModel.h"

@implementation KSStateModel

#pragma mark
#pragma mark Class Methods

+ (instancetype)stateModelWithState:(KSObjectState)state index:(NSUInteger)index {
    return [[[self class] alloc] initWithState:state index:index];
}

#pragma mark
#pragma mark Initializations and Deallocations

- (instancetype)initWithState:(KSObjectState)state index:(NSUInteger)index {
    self = [super init];
    if (self) {
        self.state = state;
        self.index = index;
    }
    
    return self;
}

@end
