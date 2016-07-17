//
//  KSManagedObject.h
//  KSTestFacebookProject
//
//  Created by KulikovS on 17.06.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "IDPActiveRecordKit.h"

@interface KSManagedObject : NSManagedObject
@property (nonatomic, copy)     NSString   *ID;

+ (instancetype)objectWithID:(NSString *)ID;
+ (instancetype)findObjectWithID:(NSString *)ID;

@end
