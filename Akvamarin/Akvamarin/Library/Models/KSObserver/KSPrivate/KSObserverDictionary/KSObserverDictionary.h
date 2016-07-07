//
//  KSObserverDictionary.h
//  KSIdapStudy
//
//  Created by KulikovS on 13.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>


@class KSObserverArray;

typedef void(^KSHandlerObject)(id object);

@interface KSObserverDictionary : NSObject
@property (nonatomic, readonly) NSUInteger        state;
@property (nonatomic, readonly) NSArray           *handlers;

+ (instancetype)dictionaryWithState:(NSUInteger)state;

- (instancetype)initWithState:(NSUInteger)state NS_DESIGNATED_INITIALIZER;

- (void)addHandler:(KSHandlerObject)handler object:(id)object;
- (void)removeHandlersForObject:(id)object;

@end
