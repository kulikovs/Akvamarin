//
//  NSString+KSExstension.m
//  KSIdapStudy
//
//  Created by KulikovS on 25.02.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "NSString+KSExtension.h"

#import "KSAlphabet.h"

const NSUInteger kKSDefaultLength          = 10;
const NSUInteger kKSMaxDefaultStringsCount = 40;

@implementation NSString (KSExtension)

#pragma mark -
#pragma mark Public Class Methods

+ (instancetype)randomStringWithLength:(NSUInteger)length alphabet:(KSAlphabet *)alphabet {
    NSMutableString *string = [NSMutableString string];
    
    for (NSUInteger index = 0; index < length; index++) {
        NSUInteger randomValue = arc4random_uniform((uint32_t)alphabet.count - 1);
        unichar symbol = [alphabet.alphabetString characterAtIndex:randomValue];
        [string appendString:[NSString stringWithFormat:@"%c", symbol]];
    }
    
    return [string mutableCopy];
}

+ (instancetype)randomStringWithAlphabet:(KSAlphabet *)alphabet {
    return [NSString randomStringWithLength:kKSDefaultLength alphabet:alphabet];
}

+ (instancetype)randomStringWithLength:(NSUInteger)length {
    return [NSString randomStringWithLength:length alphabet:[KSAlphabet lowerCaseLettersAlphabet]];
}

+ (instancetype)randomString{
    return [NSString randomStringWithLength:kKSDefaultLength alphabet:[KSAlphabet lowerCaseLettersAlphabet]];
}

+ (NSArray *)randomStringsWithRandomCount {
    return [self randomStringsWithCount:arc4random_uniform(kKSMaxDefaultStringsCount)+ 1];
}

+ (NSArray *)randomStringsWithCount:(NSUInteger)count {
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (NSUInteger index = 0; index < count; index++) {
        [mutableArray addObject:[NSString randomString]];
    }
    
    return [mutableArray copy];
}

@end
