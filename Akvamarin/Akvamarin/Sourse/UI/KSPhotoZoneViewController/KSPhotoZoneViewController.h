//
//  KSPhotoZoneViewController.h
//  Akvamarin
//
//  Created by KulikovS on 31.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSPhotoZoneContext;

@interface KSPhotoZoneViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)   KSPhotoZoneContext  *context;

@end
