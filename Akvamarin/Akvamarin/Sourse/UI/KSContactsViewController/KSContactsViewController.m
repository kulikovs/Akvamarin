//
//  KSContactsViewController.m
//  Akvamarin
//
//  Created by KulikovS on 18.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSContactsViewController.h"
#import "KSContactsView.h"

static NSString * const kKSContactsBarTitle         = @"Контакты";
static NSString * const kKSCallPhoneNumberString    = @"tel://0681598557";
static NSString * const kKSSiteURLString            = @"http://akvamarin.ks.ua";
static NSString * const kKSVkontakteURLString       = @"http://vk.com/akvamarin_ks";

@interface KSContactsViewController ()
@property (nonatomic, readonly) KSContactsView *rootView;

- (BOOL)applicationWithString:(NSString *)string;

@end

@implementation KSContactsViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSContactsView);

- (NSString *)navigationBarTitle {
    return kKSContactsBarTitle;
}

#pragma mark -
#pragma mark Private Methods

- (BOOL)applicationWithString:(NSString *)string {
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

#pragma mark -
#pragma mark Handling

- (IBAction)onClickCallPhoneButton:(id)sender {
    [self applicationWithString:kKSCallPhoneNumberString];
}

- (IBAction)onClickOpenSiteButton:(id)sender {
    [self applicationWithString:kKSSiteURLString];
}

- (IBAction)onClickOpenVKButton:(id)sender {
    [self applicationWithString:kKSVkontakteURLString];
}

@end
