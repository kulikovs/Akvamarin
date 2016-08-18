//
//  KSEmailModel.m
//  Akvamarin
//
//  Created by KulikovS on 10.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSEmailModel.h"
#import "KSAlphabet.h"

static NSString * const kKSSymbolsForEmailAdress    =   @"@.!#$%&'*+-/=?^_`{|}~";
static NSString * const kKSCharacterAt              =   @"@";

static NSString * const kKSFilterString     = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
static NSString * const kKSLaxString        = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
static NSString * const kKSSelfMathesString = @"SELF MATCHES %@";

@interface KSEmailModel ()
@property (nonatomic, strong) NSMutableString     *resultEmail;

- (NSString *)validEmailAdressWithAdress:(UITextField *)emailAdress
                                   range:(NSRange)range
                                  string:(NSString *)string;

- (NSCharacterSet *)charactersForValidationEmailAdress;

@end

@implementation KSEmailModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.resultEmail = [NSMutableString string];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (NSString *)formattedEmailAdressWithAdress:(UITextField *)emailAdress
                                       range:(NSRange)range
                           replacementString:(NSString *)string
{
    NSString *email = [self validEmailAdressWithAdress:emailAdress range:range string:string];
    if (email) {
        [self.resultEmail setString:email];
        
    }
    
    return self.resultEmail;
}

- (BOOL)isValidEmailAdress:(NSString *)email {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = kKSFilterString;
    NSString *laxString = kKSLaxString;
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:kKSSelfMathesString, emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

#pragma mark -
#pragma mark Private Methods

- (NSString *)validEmailAdressWithAdress:(UITextField *)emailAdress
                                   range:(NSRange)range
                                  string:(NSString *)string
{
    NSCharacterSet *validationSet = [self charactersForValidationEmailAdress];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    NSString *email = [emailAdress.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *charactersAt = [email componentsSeparatedByString:kKSCharacterAt];
    
    return (components.count > 1 || charactersAt.count > 2) ? nil : email;
}

- (NSCharacterSet *)charactersForValidationEmailAdress {
    KSAlphabet *letters = [KSAlphabet lowerUpperCaseLettersAlphabet];
    KSAlphabet *numeric = [KSAlphabet numericLettersAlphabet];
    
    NSMutableCharacterSet *validationSet = [NSMutableCharacterSet
                                            characterSetWithCharactersInString:numeric.alphabetString];
    [validationSet addCharactersInString:letters.alphabetString];
    [validationSet addCharactersInString:kKSSymbolsForEmailAdress];
    [validationSet invert];
    
    return [validationSet copy];
}

@end
