//
//  KSCheckPhoneNumberModel.m
//  Akvamarin
//
//  Created by KulikovS on 09.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSCheckPhoneNumberModel.h"


static NSUInteger const localNumberMaxLength    = 7;
static NSUInteger const areaCodeMaxLength       = 3;
static NSUInteger const countryCodeMaxLength    = 2;

@interface KSCheckPhoneNumberModel ()
@property (nonatomic, strong)   NSMutableString     *resultNumber;
@property (nonatomic, copy)     NSString            *tempNumber;

- (NSString *)validLocalNumberForNumber:(NSString *)phoneNumber;
- (NSString *)validAreaCodeForNumber:(NSString *)phoneNumber;
- (NSString *)validCountryCodeForNumber:(NSString *)phoneNumber;

@end

@implementation KSCheckPhoneNumberModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.resultNumber = [NSMutableString string];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSString *)checkPhoneNumberWithNumber:(UITextField *)phoneNumber
                                   range:(NSRange)range
                       replacementString:(NSString *)string
{
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if (components.count > 1) {
        return self.resultNumber;
    }
    
    self.tempNumber = [phoneNumber.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *validComponents = [self.tempNumber componentsSeparatedByCharactersInSet:validationSet];
    self.tempNumber = [validComponents componentsJoinedByString:@""];
    
    NSUInteger numberMaxLenght = localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength;
    if (self.tempNumber.length <= numberMaxLenght) {
        [self.resultNumber setString:[self validLocalNumberForNumber:self.tempNumber]];
        
        if (self.tempNumber.length > localNumberMaxLength) {
            [self.resultNumber insertString:[self validAreaCodeForNumber:self.tempNumber] atIndex:0];
        }
        
        if (self.tempNumber.length > localNumberMaxLength + areaCodeMaxLength) {
            [self.resultNumber insertString:[self validCountryCodeForNumber:self.tempNumber] atIndex:0];
        }
    }
    
    return self.resultNumber;
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)validLocalNumberForNumber:(NSString *)phoneNumber {
    NSUInteger localNumberLength = MIN(phoneNumber.length, localNumberMaxLength);
    NSMutableString *string = [NSMutableString string];
    [string setString:[phoneNumber substringFromIndex:phoneNumber.length - localNumberLength]];
    
    if (string.length > 3) {
        [string insertString:@"-" atIndex:3];
    }
    
    return [string copy];
}

- (NSString *)validAreaCodeForNumber:(NSString *)phoneNumber {
    NSUInteger areaCodeLengthMin = phoneNumber.length - localNumberMaxLength;
    NSUInteger areaCodeLength = MIN(areaCodeLengthMin, areaCodeMaxLength);
    
    NSUInteger areaCodelocation = phoneNumber.length - localNumberMaxLength - areaCodeLength;
    NSRange areaRange = NSMakeRange(areaCodelocation, areaCodeLength);
    
    NSString *areaCode = [phoneNumber substringWithRange:areaRange];
    
    return [NSString stringWithFormat:@"(%@) ", areaCode];
}

- (NSString *)validCountryCodeForNumber:(NSString *)phoneNumber {
    NSUInteger countryCodeLengthMin = phoneNumber.length - localNumberMaxLength - areaCodeMaxLength;
    NSUInteger countryCodeLength = MIN(countryCodeLengthMin, countryCodeMaxLength);
    
    NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
    NSString *countryCode = [phoneNumber substringWithRange:countryCodeRange];
    
    return [NSString stringWithFormat:@"+%@ ", countryCode];
}

@end
