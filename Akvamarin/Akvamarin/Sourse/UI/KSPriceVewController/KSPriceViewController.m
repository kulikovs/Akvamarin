//
//  KSPriceViewController.m
//  Akvamarin
//
//  Created by KulikovS on 13.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSPriceViewController.h"
#import "KSPriceView.h"
#import "KSAlertViewConstants.h"

static NSString * const kKSPriceBarTitle            = @"Стоимость";

static NSString * const kKSPriceURL = @"http://www.akvamarin.ks.ua/uslovija-raboty-v-studii";

@interface KSPriceViewController ()
@property (nonatomic, readonly) KSPriceView *rootView;

- (void)loadWebView;

@end

@implementation KSPriceViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSPriceView);

- (NSString *)navigationBarTitle {
    return kKSPriceBarTitle;
}

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    [self.rootView showLoadingViewWithDefaultTextAnimated:YES];
}

#pragma mark -
#pragma mark Private Methods

- (void)loadWebView {
    NSURL *URL = [NSURL URLWithString:kKSPriceURL];
    [self.rootView.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    if ([error code] != NSURLErrorCancelled) {
        KSWeakifySelf
        KSActionHandler action = ^(UIAlertAction * action) {
            KSStrongifySelfAndReturnIfNil
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
        [self showAlertViewWithTitle:kKSLoadingErrorTitle message:kKSCheckInternetMessage actionHandler:action];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.rootView removeLoadingViewAnimated:YES];
}

@end
