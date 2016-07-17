//
//  KSPhoto+CoreDataProperties.h
//  Akvamarin
//
//  Created by KulikovS on 15.07.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KSPhoto.h"

NS_ASSUME_NONNULL_BEGIN

@interface KSPhoto (CoreDataProperties)
@property (nonatomic, strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
