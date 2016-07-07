//
//  KSView.h
//  KSIdapStudy
//
//  Created by KulikovS on 19.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KSLoadingView.h"

@interface KSView : UIView
@property (nonatomic, strong) KSLoadingView *loadingView;

- (void)showLoadingView;
- (void)showLoadingViewWithDefaultText;
- (void)showLoadingViewWithDefaultTextAnimated:(BOOL)animated;
- (void)showLoadingViewWithText:(NSString *)text;
- (void)showLoadingViewWithText:(NSString *)text animated:(BOOL)animated;

- (void)removeLoadingView;
- (void)removeLoadingViewAnimated:(BOOL)animated;

@end
