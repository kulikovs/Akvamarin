//
//  KSPriceViewController.m
//  Akvamarin
//
//  Created by KulikovS on 13.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSPriceViewController.h"
#import "KSPriceView.h"

static NSString * const kKSPriceBarTitle            = @"Стоимость";
static NSString * const kKSAlertControllerTitle     = @"Ошибка загрузки";
static NSString * const kKSAlertControllerMessage   = @"Проверьте подключение к Интернету";
static NSString * const kKSAlertActionTitle         = @"ОК";

static NSString * const kKSPriceURL = @"http://www.akvamarin.ks.ua/uslovija-raboty-v-studii";

@interface KSPriceViewController ()
@property (nonatomic, readonly) KSPriceView *rootView;

- (void)loadWebView;
- (void)showAlertView;

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

- (void)showAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:kKSAlertControllerTitle
                                                                   message:kKSAlertControllerMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:kKSAlertActionTitle
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    if ([error code] != NSURLErrorCancelled) {
        [self showAlertView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.rootView removeLoadingViewAnimated:YES];
}

@end
