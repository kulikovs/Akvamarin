//
//  KSObserverArray.h
//  KSIdapStudy
//
//  Created by KulikovS on 13.04.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KSHandlerObject)(id object);

@interface KSObserverArray : NSObject
@property (nonatomic, readonly) NSArray *handlers;

- (void)addHandler:(KSHandlerObject)handler forObject:(id)object;
- (void)removeHandlersForObject:(id)object;
- (void)removeAllHandlers;

@end