//
//  KSAlphabetWithRange.m
//  KSIdapStudy
//
//  Created by KulikovS on 29.02.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSAlphabetRange.h"

@interface KSAlphabetRange ()
@property (nonatomic, assign) NSRange range;

@end

@implementation KSAlphabetRange

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithRange:(NSRange)range{
    self =  [super init];
    if (self) {
        self.range = range;
    }
    
    return self;
}
    
#pragma mark -
#pragma mark Accessors

- (NSString *)alphabetString {
    NSMutableString *string = [NSMutableString string];
    NSUInteger location = self.range.location;
    
    for (NSUInteger index = location; index < location + self.range.length; index++) {
        [string appendString:[NSString stringWithFormat:@"%c", (unichar)index]];
    }
    
    return [string copy];
}

- (NSUInteger)count {
    return self.range.length;
}

@end
