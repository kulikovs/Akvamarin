//
//  KSPhotoZoneViewCell.h
//  Akvamarin
//
//  Created by KulikovS on 31.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSImageView;
@class KSPhotoZone;

@interface KSPhotoZoneViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel      *photoZoneName;
@property (nonatomic, strong) IBOutlet KSImageView  *customImageView;

- (void)fillWithModel:(KSPhotoZone *)photoZone;

@end
