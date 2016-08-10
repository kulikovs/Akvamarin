//
//  KSReserveViewController.m
//  Akvamarin
//
//  Created by KulikovS on 25.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSReserveViewController.h"
#import "KSReserveView.h"
#import "KSCalendarConstants.h"
#import "KSCheckPhoneNumberModel.h"

static NSString * const kKSPhotoZoneBarTitle = @"Бронирование";

@interface KSReserveViewController () <UITextFieldDelegate>
@property (nonatomic, readonly) KSReserveView                *rootView;
@property (nonatomic, strong)   KSCheckPhoneNumberModel      *phoneNumberModel;

@end

@implementation KSReserveViewController

@dynamic rootView;


#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.phoneNumberModel = [KSCheckPhoneNumberModel new];
    }
    
    return self;
}




#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSReserveView)

- (NSString *)navigationBarTitle {
    return kKSPhotoZoneBarTitle;
}

#pragma mark -
#pragma mark View LifeCycle

//- (NSString *)titleFromStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:kKSTimeFormatKey];
//    
//    NSString *startTime = [dateFormatter stringFromDate:startDate];
//    NSString *endTime = [dateFormatter stringFromDate:endDate];
//    
//    return [NSString stringWithFormat:kKSTitleFormat, startTime, endTime, kKSStudioBusyKey];;
//}
//
//- (void)test {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:kKSDateFormatKey];
//    
//    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
//    [timeFormatter setDateFormat:kKSTimeFormatKey];
//    
//    NSString *startTime = [timeFormatter stringFromDate:self.rootView.startTime.date];
//    NSString *endTime = [timeFormatter stringFromDate:self.rootView.endTime.date];
//    NSString *date = [dateFormatter stringFromDate:self.rootView.date.date];
//    
//    NSString *name = self.rootView.name.text;
//    NSString *email = self.rootView.email.text;
//    NSString *telephoneNumber = self.rootView.telephonNumber.text;

 //   NSLog(@"");
//}

- (void)onSendMailButton:(id)sender {
//    [self test];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:[self.rootView.textFields lastObject]]) {
          [textField resignFirstResponder];
    } else {
        NSUInteger index = [self.rootView.textFields indexOfObject:textField];
        [self.rootView.textFields[index + 1] becomeFirstResponder];
    }
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSUInteger objectIndex = [self.rootView.textFields indexOfObject:textField];
    if (objectIndex == 1) {
        
        //  [self.phoneNumberModel validPhoneNumberWithPhoneNumber:textField Range:range replacementString:string];
        textField.text = [self.phoneNumberModel checkPhoneNumberWithNumber:textField range:range replacementString:string];
    }
    
    
//    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
//    
//    if ([components count] > 1) {
//        return NO;
//    }
//    
//    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//
//    
//    NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
//    
//    newString = [validComponents componentsJoinedByString:@""];
//    
//    static const int localNumberMaxLength = 7;
//    static const int areaCodeMaxLength = 3;
//    static const int countryCodeMaxLength = 2;
//    
//    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
//        return NO;
//    }
//    
//    NSMutableString *resultString = [NSMutableString string];
//
//    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
//    
//    if (localNumberLength > 0) {
//        
//        NSString* number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
//        
//        [resultString appendString:number];
//        
//        if ([resultString length] > 3) {
//            [resultString insertString:@"-" atIndex:3];
//        }
//        
//    }
//    
//    if ([newString length] > localNumberMaxLength) {
//        
//        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
//        
//        NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
//        
//        NSString* area = [newString substringWithRange:areaRange];
//        
//        area = [NSString stringWithFormat:@"(%@) ", area];
//        
//        [resultString insertString:area atIndex:0];
//    }
//    
//    if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
//        
//        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
//        
//        NSRange countryCodeRange = NSMakeRange(0, countryCodeLength);
//        
//        NSString* countryCode = [newString substringWithRange:countryCodeRange];
//        
//        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
//        
//        [resultString insertString:countryCode atIndex:0];
//    }
//    
//    
//    textField.text = resultString;
    
    return NO;
}

@end
