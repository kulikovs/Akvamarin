//
//  KSAlphabetWithString.m
//  KSIdapStudy
//
//  Created by KulikovS on 29.02.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSAlphabetString.h"
#import "KSAlphabet.h"

@interface KSAlphabetString ()
@property (nonatomic, copy) NSString *stringAlphabet;

@end

@implementation KSAlphabetString

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        self.stringAlphabet = [string copy];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)alphabetString {
    return self.stringAlphabet;
}

@end

