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
#import "KSRequestConstants.h"
#import "KSReserveContext.h"
#import "KSAlertViewConstants.h"

static NSString * const kKSPhotoZoneBarTitle = @"Бронирование";
static NSString * const kKSDataSendingString = @"Идет отправка данных...";

@interface KSReserveViewController () <UITextFieldDelegate>
@property (nonatomic, readonly) KSReserveView           *rootView;
@property (nonatomic, strong)   KSPhoneNumberModel      *phoneNumberModel;
@property (nonatomic, strong)   KSEmailModel            *emailModel;

- (void)addObserverWithKey:(NSString *)key selector:(SEL)selector;
- (void)removeObserverWithKey:(NSString *)key;
- (NSDictionary *)reserveData;
- (BOOL)isValidPhoneNumber:(NSString *)phoneNumber emailAdress:(NSString *)emailAdress;
- (void)keyboardWasShown:(NSNotification *)aNotification;
- (void)keyboardWillBeHidden:(NSNotification *)aNotification;

@end

@implementation KSReserveViewController

@dynamic rootView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self removeObserverWithKey:UIKeyboardDidShowNotification];
    [self removeObserverWithKey:UIKeyboardWillHideNotification];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.phoneNumberModel = [KSPhoneNumberModel new];
        self.emailModel = [KSEmailModel new];
        
        [self addObserverWithKey:UIKeyboardDidShowNotification
                        selector:@selector(keyboardWasShown:)];
        [self addObserverWithKey:UIKeyboardWillHideNotification
                        selector:@selector(keyboardWillBeHidden:)];
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
#pragma mark Private Methods

- (void)addObserverWithKey:(NSString *)key selector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:key
                                               object:nil];
}

- (void)removeObserverWithKey:(NSString *)key {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:key object:nil];
}

- (BOOL)isValidPhoneNumber:(NSString *)phoneNumber emailAdress:(NSString *)emailAdress {
    BOOL validPhoneNumber = [self.phoneNumberModel isValidPhoneNumber:phoneNumber];
    BOOL validEmail = [self.emailModel isValidEmailAdress:emailAdress];
    
    return (validEmail && validPhoneNumber);
}

- (NSDictionary *)reserveData {
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormatKey:kKSDateFormatKey];
    NSDateFormatter *timeFormatter = [NSDateFormatter dateFormatterWithFormatKey:kKSTimeFormatKey];
    
    KSReserveView *view = self.rootView;
    NSString *startTime = [timeFormatter stringFromDate:view.startTimePicker.date];
    NSString *endTime = [timeFormatter stringFromDate:view.endTimePicker.date];
    NSString *date = [dateFormatter stringFromDate:view.datePicker.date];
    
    NSDictionary *data = @{kKSUserKey: @{kKSStartTimeKey: startTime,
                                           kKSEndTimeKey: endTime,
                                              kKSDateKey: date,
                                              kKSNameKey: view.nameField.text,
                                             kKSEmailKey: view.emailField.text,
                                             kKSPhoneKey: view.phoneNumberField.text
                                         }
                           };
    return data;
}

- (void)contextDidLoad {
    [self.rootView removeLoadingViewAnimated:YES];
    
    KSWeakifySelf
    KSActionHandler action = ^(UIAlertAction *action) {
        KSStrongifySelfAndReturnIfNil
        [self.navigationController popToRootViewControllerAnimated:YES];
    };
    [self showAlertViewWithTitle:kKSThankYouString message:kKSWaitingAdminString actionHandler:action];
}

- (void)contextLoadFailed {
    [self.rootView removeLoadingView];
    [self showAlertViewWithTitle:kKSDataSendingErrorString
                         message:kKSCheckInternetMessage
                   actionHandler:nil];
}

- (void)keyboardWasShown:(NSNotification *)aNotification {
    UIScrollView *scrollView = self.rootView.scrollView;
    CGSize keyboardSize = [[[aNotification userInfo]
                            objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect frameView = self.view.frame;
    CGRect frameField = self.rootView.activeField.frame;
    frameView.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(frameView, frameField.origin) ) {
        [self.rootView.scrollView scrollRectToVisible:frameField animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    UIScrollView *scrollView= self.rootView.scrollView;
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark -
#pragma mark Handling

- (IBAction)onClickSendDataButton:(id)sender {
    KSReserveView *view = self.rootView;
    NSString *email = view.emailField.text;
    NSString *phoneNumber = view.phoneNumberField.text;
    
    if ([self isValidPhoneNumber:phoneNumber emailAdress:email]) {
        self.context = [[KSReserveContext alloc] initWithReserveData:[self reserveData]];
        [view showLoadingViewWithText:kKSDataSendingString];
    } else {
        [self showAlertViewWithTitle:kKSDataEntryErrorTitle message:kKSCheckPhoneEmailMessage actionHandler:nil];
    }
}

- (IBAction)touchFieldsView:(id)sender {
    UITextField *activeField = self.rootView.activeField;
    if(activeField)
        [activeField resignFirstResponder];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.rootView.activeField = textField;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.rootView.activeField = nil;
}

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
