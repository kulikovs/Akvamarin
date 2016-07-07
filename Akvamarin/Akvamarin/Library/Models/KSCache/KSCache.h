//
//  KSSharedCacheModel.h
//  KSIdapStudy
//
//  Created by KulikovS on 01.06.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSModel.h"

@interface KSCache : NSObject <NSCoding>;

+ (instancetype)sharedCache;

- (NSString *)URLStringForFileName:(NSString *)fileName;
- (NSString *)fileNameForURLString:(NSString *)URLString;
- (BOOL)isCashedForURLString:(NSString *)URLString;
- (void)removeURLString:(NSString *)URLString;
- (void)addURLString:(NSString *)URLString fileName:(NSString *)fileName;

@end
