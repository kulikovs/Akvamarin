//
//  KSPhoneNumberModel.m
//  Akvamarin
//
//  Created by KulikovS on 09.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSPhoneNumberModel.h"

static NSUInteger const kKSLocalNumberMaxLength        = 7;
static NSUInteger const kKSAreaCodeMaxLength           = 3;
static NSUInteger const kKSCountryCodeMaxLength        = 2;
static NSUInteger const kKSNumberMinLengthFormatted    = 14;
static NSUInteger const kKSNumberMaxLengthFormatted    = 17;

static NSString * const kKSLocalNumberFormatter =   @"-";
static NSString * const kKSAreaCodeFormatter    =   @"(%@) ";
static NSString * const kKSCountryCodeFormatter =   @"+%@ ";
static NSString * const kKSSeparator            =   @"";

@interface KSPhoneNumberModel ()
@property (nonatomic, strong)   NSMutableString     *resultNumber;

- (NSString *)validPhoneNumberWithNumber:(UITextField *)phoneNumber
                                   range:(NSRange)range
                                  string:(NSString *)string;

- (NSString *)formattedLocalNumberWithPhoneNumber:(NSString *)phoneNumber;
- (NSString *)formattedAreaCodeWithPhoneNumber:(NSString *)phoneNumber;
- (NSString *)formattedCountryCodeWithPhoneNumber:(NSString *)phoneNumber;
- (NSString *)formattedCodeWithPhoneNumber:(NSString *)phoneNumber
                                     range:(NSRange)range
                             codeFormatter:(NSString *)formatter;

@end

@implementation KSPhoneNumberModel

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

- (NSString *)formattedPhoneNumberWithNumber:(UITextField *)number
                                       range:(NSRange)range
                           replacementString:(NSString *)string
{
    NSString *tempPhoneNumber = [self validPhoneNumberWithNumber:number range:range string:string];
    if (tempPhoneNumber) {
        NSUInteger numberMaxLenght = kKSLocalNumberMaxLength + kKSAreaCodeMaxLength + kKSCountryCodeMaxLength;
        if (tempPhoneNumber.length <= numberMaxLenght) {
            [self.resultNumber setString:[self formattedLocalNumberWithPhoneNumber:tempPhoneNumber]];
            
            if (tempPhoneNumber.length > kKSLocalNumberMaxLength) {
                [self.resultNumber insertString:[self formattedAreaCodeWithPhoneNumber:tempPhoneNumber]
                                        atIndex:0];
            }
            if (tempPhoneNumber.length > kKSLocalNumberMaxLength + kKSAreaCodeMaxLength) {
                [self.resultNumber insertString:[self formattedCountryCodeWithPhoneNumber:tempPhoneNumber]
                                        atIndex:0];
            }
        }
    }
    
    return self.resultNumber;
}

- (BOOL)isValidPhoneNumber:(NSString *)phoneNumber {
    NSUInteger length = phoneNumber.length;
    
    return (length == kKSNumberMinLengthFormatted || length >= kKSNumberMaxLengthFormatted );
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)validPhoneNumberWithNumber:(UITextField *)number
                                   range:(NSRange)range
                                  string:(NSString *)string
{
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    NSString *tempPhoneNumber = [number.text stringByReplacingCharactersInRange:range
                                                                          withString:string];
    
    NSArray *validComponents = [tempPhoneNumber componentsSeparatedByCharactersInSet:validationSet];
    
    return components.count > 1 ? nil : [validComponents componentsJoinedByString:kKSSeparator];
}

- (NSString *)formattedLocalNumberWithPhoneNumber:(NSString *)phoneNumber {
    NSUInteger numberLength = phoneNumber.length;
    NSUInteger localNumberLength = MIN(numberLength, kKSLocalNumberMaxLength);
    
    NSMutableString *localNumber = [NSMutableString string];
    [localNumber setString:[phoneNumber substringFromIndex:numberLength - localNumberLength]];
    if (localNumber.length > 3) {
        [localNumber insertString:kKSLocalNumberFormatter atIndex:3];
    }
    
    return [localNumber copy];
}

- (NSString *)formattedAreaCodeWithPhoneNumber:(NSString *)phoneNumber {
    NSUInteger numberLength = phoneNumber.length;
    NSUInteger areaLengthMin = numberLength - kKSLocalNumberMaxLength;
    NSUInteger areaLength = MIN(areaLengthMin, kKSAreaCodeMaxLength);
    NSUInteger areaLocation = numberLength - kKSLocalNumberMaxLength - areaLength;
    NSRange areaRange = NSMakeRange(areaLocation, areaLength);

    return [self formattedCodeWithPhoneNumber:phoneNumber
                                        range:areaRange
                                codeFormatter:kKSAreaCodeFormatter];
}

- (NSString *)formattedCountryCodeWithPhoneNumber:(NSString *)phoneNumber {
    NSUInteger countryLengthMin = phoneNumber.length - kKSLocalNumberMaxLength - kKSAreaCodeMaxLength;
    NSUInteger countryLength = MIN(countryLengthMin, kKSCountryCodeMaxLength);
    NSRange countryRange = NSMakeRange(0, countryLength);
    
    return [self formattedCodeWithPhoneNumber:phoneNumber
                                        range:countryRange
                                codeFormatter:kKSCountryCodeFormatter];
}

- (NSString *)formattedCodeWithPhoneNumber:(NSString *)phoneNumber
                                     range:(NSRange)range
                             codeFormatter:(NSString *)formatter
{
    NSString *countryCode = [phoneNumber substringWithRange:range];
    
    return [NSString stringWithFormat:formatter, countryCode];
}

@end
