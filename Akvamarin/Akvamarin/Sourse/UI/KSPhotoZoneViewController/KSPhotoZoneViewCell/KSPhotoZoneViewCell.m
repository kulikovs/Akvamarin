//
//  KSPhotoZoneViewCell.m
//  Akvamarin
//
//  Created by KulikovS on 31.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSPhotoZoneViewCell.h"
#import "KSPhotoZone.h"
#import "KSImageView.h"
#import "KSPhoto.h"

@implementation KSPhotoZoneViewCell

#pragma mark -
#pragma mark Public Methods

- (void)fillWithModel:(KSPhotoZone *)photoZone {
    self.customImageView.URL = [NSURL URLWithString:photoZone.mainPhoto.url];
    self.photoZoneName.text = photoZone.name;
}

@end
