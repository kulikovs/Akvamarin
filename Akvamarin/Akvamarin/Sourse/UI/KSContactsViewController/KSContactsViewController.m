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
static NSString * const kKSCallPhoneNumberString    = @"tel://+380668788757";
static NSString * const kKSSiteURLString            = @"http://akvamarin.ks.ua";
static NSString * const kKSVkontakteURLString       = @"http://vk.com/akvamarin_ks";

@interface KSContactsViewController ()
@property (nonatomic, readonly) KSContactsView *rootView;

- (BOOL)applicationWithURLString:(NSString *)URLString;

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

- (BOOL)applicationWithURLString:(NSString *)URLString {
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
}

#pragma mark -
#pragma mark Handling

- (IBAction)onClickCallPhoneButton:(id)sender {
    [self applicationWithURLString:kKSCallPhoneNumberString];
}

- (IBAction)onClickOpenSiteButton:(id)sender {
    [self applicationWithURLString:kKSSiteURLString];
}

- (IBAction)onClickOpenVKButton:(id)sender {
    [self applicationWithURLString:kKSVkontakteURLString];
}

@end
