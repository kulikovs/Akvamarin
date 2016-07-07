//
//  KSView.m
//  KSIdapStudy
//
//  Created by KulikovS on 19.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSView.h"

static NSString * const kKSDefaulLoadingText    = @"Loading";
static CGFloat    const kKSLoadingAlpha         = 0.5;
static CGFloat    const kKSRemovingAlpha        = 0.0;
static CGFloat    const kKSDefaultDurations     = 0.8;

@implementation KSView

- (void)showLoadingView {
    [self showLoadingViewWithText:nil];
}

- (void)showLoadingViewWithDefaultText {
    [self showLoadingViewWithText:kKSDefaulLoadingText animated:NO];
}

- (void)showLoadingViewWithDefaultTextAnimated:(BOOL)animated {
    [self showLoadingViewWithText:kKSDefaulLoadingText animated:animated];
}

- (void)showLoadingViewWithText:(NSString *)text {
    [self showLoadingViewWithText:text animated:NO];
}

- (void)showLoadingViewWithText:(NSString *)text animated:(BOOL)animated {
    KSLoadingView *loadingView = self.loadingView;
    if (!loadingView) {
       loadingView = [UINib loadFromNibWithClass:[KSLoadingView class]];
        loadingView.loadingLabel.text = text;
        loadingView.frame = self.frame;
        self.loadingView = loadingView;
    }

    [UIView animateWithDuration:animated ? kKSDefaultDurations : 0
                     animations:^ {
                         self.loadingView.alpha = kKSLoadingAlpha;
                         [self addSubview:loadingView];
                     }];
}

- (void)removeLoadingView {
    [self removeLoadingViewAnimated:NO];
}

- (void)removeLoadingViewAnimated:(BOOL)animated {
    [UIView animateWithDuration:animated ? kKSDefaultDurations : 0
                     animations:^ {
                         self.loadingView.alpha = kKSRemovingAlpha;
                     }
                     completion:^(BOOL finished){
                         [self.loadingView removeFromSuperview];
                     }];
}

@end
