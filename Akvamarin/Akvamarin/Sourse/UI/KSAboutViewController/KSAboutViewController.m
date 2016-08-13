//
//  KSAboutViewController.m
//  Akvamarin
//
//  Created by KulikovS on 13.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSAboutViewController.h"
#import "KSAboutView.h"

static NSString * const kKSAboutBarTitle = @"О нас";
static NSString * const kKSAboutURL = @"О нас";

@interface KSAboutViewController ()
@property (nonatomic, readonly) KSAboutView *rootView;

@end

@implementation KSAboutViewController

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSAboutView);

- (NSString *)navigationBarTitle {
    return kKSAboutBarTitle;
}

- (UIWebView *)webView {
    return self.rootView.webView;
}

- (NSString *)webViewURlString {
    return kKSAboutURL;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
}

@end
