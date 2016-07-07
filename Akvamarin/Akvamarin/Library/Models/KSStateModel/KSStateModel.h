//
//  KSStateModel.h
//  KSIdapStudy
//
//  Created by KulikovS on 12.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger) {
    kKSStateModelAddedState,
    kKSStateModelRemoveState,
} KSObjectState;

@interface KSStateModel : NSObject
@property (nonatomic, assign) KSObjectState    state;
@property (nonatomic, assign) NSUInteger       index;

+ (instancetype)stateModelWithState:(KSObjectState)state index:(NSUInteger)index;
- (instancetype)initWithState:(KSObjectState)state index:(NSUInteger)index;

@end
