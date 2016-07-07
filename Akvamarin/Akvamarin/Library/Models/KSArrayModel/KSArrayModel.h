//
//  KSArrayModel.h
//  KSIdapStudy
//
//  Created by KulikovS on 08.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KSModel.h"

@class KSStateModel;

@interface KSArrayModel : KSModel <NSFastEnumeration, NSCoding>
@property (nonatomic, readonly) NSArray     *objects;
@property (nonatomic, readonly) NSUInteger  count;

+ (instancetype)arrayModelWithObject:(id)object;
+ (instancetype)arrayModelWithObjects:(NSArray *)objects;

- (instancetype)initWithObject:(id)object;
- (instancetype)initWithArray:(NSArray *)objects;

- (id)objectAtIndex:(NSUInteger)index;
- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id)object;

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex;
- (void)addObject:(id)object;
- (void)addObjects:(NSArray *)objects;
- (void)removeObject:(id)object;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)removeAllObject;

@end
