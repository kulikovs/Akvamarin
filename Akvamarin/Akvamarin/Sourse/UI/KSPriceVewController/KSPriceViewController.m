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

static NSString * const kKSPriceBarTitle = @"Стоимость";

@interface KSPriceViewController ()
@property (nonatomic, readonly) KSPriceView *rootView;

@end

@implementation KSPriceViewController

@dynamic rootView;

#pragma mark -
#pragma mark Accessors

KSRootViewAndReturnNilMacro(KSPriceView);

- (NSString *)navigationBarTitle {
    return kKSPriceBarTitle;
}

- (void)viewDidLayoutSubviews {
    [self.rootView.priceTextView setContentOffset:CGPointZero animated:NO];
}

@end
