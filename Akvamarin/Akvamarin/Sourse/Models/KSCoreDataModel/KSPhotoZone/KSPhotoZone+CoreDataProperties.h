//
//  KSPhotoZone+CoreDataProperties.h
//  Akvamarin
//
//  Created by KulikovS on 02.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KSPhotoZone.h"

NS_ASSUME_NONNULL_BEGIN

@interface KSPhotoZone (CoreDataProperties)
@property (nonatomic, strong) NSString                  *name;
@property (nonatomic, strong) KSPhoto                   *mainPhoto;
@property (nonatomic, strong) NSSet     <KSPhoto *>     *photos;

@end

@interface KSPhotoZone (CoreDataGeneratedAccessors)
- (void)addPhotosObject:(KSPhoto *)value;
- (void)removePhotosObject:(KSPhoto *)value;
- (void)addPhotos:(NSSet<KSPhoto *> *)values;
- (void)removePhotos:(NSSet<KSPhoto *> *)values;

@end

NS_ASSUME_NONNULL_END
