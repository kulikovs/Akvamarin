//
//  KSCheckPhoneNumberModel.m
//  Akvamarin
//
//  Created by KulikovS on 09.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSCheckPhoneNumberModel.h"


static NSUInteger const kKSLocalNumberMaxLength    = 7;
static NSUInteger const kKSAreaCodeMaxLength       = 3;
static NSUInteger const kKSCountryCodeMaxLength    = 2;

static NSString * const kKSLocalNumberFormatter =   @"-";
static NSString * const kKSAreaCodeFormatter    =   @"(%@) ";
static NSString * const kKSCountryCodeFormatter =   @"+%@ ";
static NSString * const kKSSeparator            =   @"";


@interface KSCheckPhoneNumberModel ()
@property (nonatomic, strong)   NSMutableString     *resultNumber;

- (NSString *)validPhoneNumberWithNumber:(UITextField *)phoneNumber
                                   range:(NSRange)range
                                  string:(NSString *)string;

- (NSString *)localNumberFormattedWithNumber:(NSString *)phoneNumber;
- (NSString *)areaCodeFormattedWithNumber:(NSString *)phoneNumber;
- (NSString *)countryCodeFormattedWithNumber:(NSString *)phoneNumber;

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
    NSString *tempPhoneNumber = [self validPhoneNumberWithNumber:phoneNumber range:range string:string];
    if (tempPhoneNumber) {
        NSUInteger numberMaxLenght = kKSLocalNumberMaxLength + kKSAreaCodeMaxLength + kKSCountryCodeMaxLength;
        if (tempPhoneNumber.length <= numberMaxLenght) {
            [self.resultNumber setString:[self localNumberFormattedWithNumber:tempPhoneNumber]];
            
            NSMutableString *code = [NSMutableString string];
            if (tempPhoneNumber.length > kKSLocalNumberMaxLength) {
                [code setString:[self areaCodeFormattedWithNumber:tempPhoneNumber]];
            }
            
            if (tempPhoneNumber.length > kKSLocalNumberMaxLength + kKSAreaCodeMaxLength) {
                [code insertString:[self countryCodeFormattedWithNumber:tempPhoneNumber] atIndex:0];
            }
            
            [self.resultNumber insertString:code atIndex:0];
        }
    }
    
    return self.resultNumber;
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)validPhoneNumberWithNumber:(UITextField *)phoneNumber
                                   range:(NSRange)range
                                  string:(NSString *)string
{
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];

    NSString *tempPhoneNumber = [phoneNumber.text stringByReplacingCharactersInRange:range
                                                                          withString:string];
    NSArray *validComponents = [tempPhoneNumber componentsSeparatedByCharactersInSet:validationSet];
    
    return components.count > 1 ? nil : [validComponents componentsJoinedByString:kKSSeparator];
}

- (NSString *)localNumberFormattedWithNumber:(NSString *)phoneNumber {
    NSUInteger localNumberLength = MIN(phoneNumber.length, kKSLocalNumberMaxLength);
    
    NSMutableString *string = [NSMutableString string];
    [string setString:[phoneNumber substringFromIndex:phoneNumber.length - localNumberLength]];
    
    if (string.length > 3) {
        [string insertString:kKSLocalNumberFormatter atIndex:3];
    }
    
    return [string copy];
}

- (NSString *)areaCodeFormattedWithNumber:(NSString *)phoneNumber {
    NSUInteger areaCodeLengthMin = phoneNumber.length - kKSLocalNumberMaxLength;
    NSUInteger areaCodeLength = MIN(areaCodeLengthMin, kKSAreaCodeMaxLength);
    
    NSUInteger areaCodelocation = phoneNumber.length - kKSLocalNumberMaxLength - areaCodeLength;
    NSRange areaRange = NSMakeRange(areaCodelocation, areaCodeLength);
    
    NSString *areaCode = [phoneNumber substringWithRange:areaRange];
    
    return [NSString stringWithFormat:kKSAreaCodeFormatter, areaCode];
}

- (NSString *)countryCodeFormattedWithNumber:(NSString *)phoneNumber {
    NSUInteger countryCodeLengthMin = phoneNumber.length - kKSLocalNumberMaxLength - kKSAreaCodeMaxLength;
    NSUInteger countryCodeLength = MIN(countryCodeLengthMin, kKSCountryCodeMaxLength);
    
    NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
    NSString *countryCode = [phoneNumber substringWithRange:countryCodeRange];
    
    return [NSString stringWithFormat:kKSCountryCodeFormatter, countryCode];
}

@end
