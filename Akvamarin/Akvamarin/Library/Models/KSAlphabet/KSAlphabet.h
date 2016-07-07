//
//  KSAlphabet.h
//  KSIdapStudy
//
//  Created by KulikovS on 29.02.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSAlphabet : NSObject
@property (nonatomic, readonly) NSString    *alphabetString;
@property (nonatomic, readonly) NSUInteger  count;

+ (instancetype)alphabetWithCharacterRange:(unichar)firstValue lastValue:(unichar)lastValue;
+ (instancetype)alphabetWithString:(NSString *)string;
+ (instancetype)alphabetWithRange:(NSRange)range;
+ (instancetype)alphabetWithAlphabetsArray:(NSArray *)alphabetsArray;

+ (instancetype)lowerCaseLettersAlphabet;
+ (instancetype)upperCaseLettersAlphabet;
+ (instancetype)numericLettersAlphabet;

- (instancetype)initWithCharacterRange:(unichar)firstValue lastValue:(unichar)lastValue;
- (instancetype)initWithString:(NSString *)string;
- (instancetype)initWithRange:(NSRange)range;
- (instancetype)initWithAlphabetsArray:(NSArray *)alphabets;

@end

