//
//  KSModel.h
//  KSIdapStudy
//
//  Created by KulikovS on 24.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSObserver.h"

typedef NS_ENUM(NSUInteger, kKSModelState) {
    kKSModelStateUndefined,
    kKSModelStateLoading,
    kKSModelStateChanged,
    kKSModelStateLoaded,
    kKSModelStateFailed,
};

@interface KSModel : KSObserver

- (void)setUpLoading;
- (void)prepareToLoad;
- (void)completeLoading;
- (void)finishLoading;
- (void)load;

@end
