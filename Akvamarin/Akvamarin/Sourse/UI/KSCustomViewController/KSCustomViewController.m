//
//  KSCustomViewController.m
//  Akvamarin
//
//  Created by KulikovS on 04.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSCustomViewController.h"
#import "KSContext.h"
#import "KSAlertViewConstants.h"

#define kKSAkvamarinColor [UIColor colorWithRedColor:55 greenColor:170 blueColor:165 alpha:1.0];

static NSString * const kKSLeftBarBattonImageName   = @"back";

@interface KSCustomViewController ()
@property (nonatomic, readonly) NSString            *navigationBarTitle;
@property (nonatomic, readonly) NSString            *imageNameForLeftButton;
@property (nonatomic, readonly) NSString            *imageNameForRightButton;

@property (nonatomic, readonly) UINavigationItem    *navigationItem;

- (void)leftBarButtonClick;
- (void)rightBarButtonClick;

@end

@implementation KSCustomViewController

@dynamic navigationItem;
@dynamic navigationBarTitle;
@dynamic imageNameForRightButton;
@dynamic imageNameForLeftButton;

#pragma mark -
#pragma mark Accessors

- (UINavigationItem *)navigationItem {
    return self.navigationController.navigationBar.topItem;
}

- (NSString *)navigationBarTitle {
    return nil;
}

- (NSString *)imageNameForLeftButton {
    return kKSLeftBarBattonImageName;
}

- (NSString *)imageNameForRightButton {
    return nil;
}

- (void)setContext:(KSContext *)context {
    if (_context != context) {
        [_context cancel];
        _context = context;
        [_context load];
        
        [self addHandlers];
    }
}

#pragma mark -
#pragma mark Life Cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showCustomNavigationBar];
}

#pragma mark -
#pragma mark Public Methods

- (void)contextDidLoad {
    
}

- (void)contextLoadFailed {
    
}

- (void)showCustomNavigationBar {
    NSDictionary *titleColor = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                           forKey:NSForegroundColorAttributeName];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    navigationBar.barTintColor = kKSAkvamarinColor;
    navigationBar.titleTextAttributes = titleColor;
    
    [self showNavigationBarWithTitle:self.navigationBarTitle
                 leftButtonImageName:self.imageNameForLeftButton
                rightButtonImageName:self.imageNameForRightButton];
}

- (void)showNavigationBarWithTitle:(NSString *)title
               leftButtonImageName:(NSString *)leftButtonImageName
              rightButtonImageName:(NSString *)rightButtonImageName
{
    self.navigationController.navigationBarHidden = NO;
    UINavigationItem *navigationItem = self.navigationItem;
    
    navigationItem.title = title;
    
    navigationItem.leftBarButtonItem = [UIBarButtonItem
                                        buttonWithImageName:leftButtonImageName
                                        selector:@selector(leftBarButtonClick)
                                        target:self];
    
    navigationItem.rightBarButtonItem = [UIBarButtonItem
                                         buttonWithImageName:rightButtonImageName
                                         selector:@selector(rightBarButtonClick)
                                         target:self];
}


- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
                 actionHandler:(KSActionHandler)handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:kKSAlertActionTitle
                                                            style:UIAlertActionStyleDefault
                                                          handler:handler];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -
#pragma mark Private Methods

- (void)addHandlers {
    KSWeakifySelf;
    [_context addHandler:^(id object) {
        KSStrongifySelfAndReturnIfNil;
        KSDispatchAsyncOnMainThread(^{
            [strongSelf contextDidLoad];
        });
    }
                   state:kKSModelStateLoaded
                  object:self];
    
    [_context addHandler:^(id object) {
        KSStrongifySelfAndReturnIfNil;
        KSDispatchAsyncOnMainThread(^{
            [strongSelf contextLoadFailed];
        });
    }
                   state:kKSModelStateFailed
                  object:self];
}

- (void)leftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonClick {
    
}

@end
