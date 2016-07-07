//
//  KSStringModel.h
//  KSIdapStudy
//
//  Created by KulikovS on 08.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KSModel.h"

@interface KSStringModel : KSModel <NSCoding>
@property (nonatomic, readonly) NSString  *string;
@property (nonatomic, readonly) NSString  *URLString;

+ (instancetype)randomStringModel;
+ (instancetype)stringModelWithString:(NSString *)string;

//This two methods initialized with random string and random count.
- (instancetype)initWithString:(NSString *)string;

+ (NSArray *)randomStringsModels;

@end
