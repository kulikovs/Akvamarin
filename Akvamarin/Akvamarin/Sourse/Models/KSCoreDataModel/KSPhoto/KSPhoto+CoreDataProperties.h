//
//  KSPhoto+CoreDataProperties.h
//  Akvamarin
//
//  Created by KulikovS on 02.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KSPhoto.h"

NS_ASSUME_NONNULL_BEGIN

@class KSPhotoZone;

@interface KSPhoto (CoreDataProperties)
@property (nonatomic, copy)     NSString        *url;
@property (nonatomic, strong)   KSPhotoZone     *mainPhoto;
@property (nonatomic, strong)   KSPhotoZone     *photos;

@end

NS_ASSUME_NONNULL_END
