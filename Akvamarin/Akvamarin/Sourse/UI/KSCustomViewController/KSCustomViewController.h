//
//  KSCustomViewController.h
//  Akvamarin
//
//  Created by KulikovS on 04.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSContext;

@interface KSCustomViewController : UIViewController
@property (nonatomic, strong)   KSContext           *context;

- (void)showCustomNavigationBar;

- (void)showNavigationBarWithTitle:(NSString *)title
               leftButtonImageName:(NSString *)leftButtonImageName
              rightButtonImageName:(NSString *)rightButtonImageName;

//these methods are called in subclasses
//you should never call these method directly from outside subclasses
- (void)addHandlers;
- (void)contextDidLoad;
- (void)contextLoadFailed;

@end
