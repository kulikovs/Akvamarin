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
#import "KSPhoneNumberModel.h"
#import "KSEmailModel.h"

static NSString * const kKSPhotoZoneBarTitle = @"Бронирование";

@interface KSReserveViewController () <UITextFieldDelegate>
@property (nonatomic, readonly) KSReserveView           *rootView;
@property (nonatomic, strong)   KSPhoneNumberModel      *phoneNumberModel;
@property (nonatomic, strong)   KSEmailModel            *emailModel;

@end

@implementation KSReserveViewController

@dynamic rootView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.phoneNumberModel = [KSPhoneNumberModel new];
        self.emailModel = [KSEmailModel new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSReserveView)

- (NSString *)navigationBarTitle {
    return kKSPhotoZoneBarTitle;
}









- (void)test {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:kKSDateFormatKey];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:kKSTimeFormatKey];
    
    NSString *startTime = [timeFormatter stringFromDate:self.rootView.startTimePicker];
    NSString *endTime = [timeFormatter stringFromDate:self.rootView.endTimePicker];
    NSString *date = [dateFormatter stringFromDate:self.rootView.datePicker];
    
//    UITextField *nameField = [self.rootView.textFields objectAtIndex:0];
//        UITextField *phoneNumberField = [self.rootView.textFields objectAtIndex:1];
//    UITextField *emailField = [self.rootView.textFields objectAtIndex:2];
//    NSString *name = nameField.text;
//    NSString *email = emailField.text;
//    NSString *phoneNumber = phoneNumberField.text;
//    
//    BOOL validEmail = [self.emailModel isValidEmailAdress:email];
//    BOOL validPhoneNumber = [self.phoneNumberModel isValidPhoneNumber:phoneNumber];

    NSLog(@"");
}

- (void)onSendMailButton:(id)sender {
    [self test];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    KSReserveView *view = self.rootView;
    if (textField == view.nameField) {
        [view.phoneNumberField becomeFirstResponder];
    }
    if (textField == view.phoneNumberField) {
        [view.emailField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)                textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string
{
    KSReserveView *view = self.rootView;
    if (textField == view.nameField) {
        return YES;
    }
    if (textField == view.phoneNumberField) {
        textField.text = [self.phoneNumberModel formattedPhoneNumberWithNumber:textField
                                                                         range:range
                                                             replacementString:string];
    }
    if (textField == view.emailField) {
        textField.text = [self.emailModel formattedEmailAdressWithAdress:textField
                                                                   range:range
                                                       replacementString:string];        
    }
    
    return NO;
}


@end
