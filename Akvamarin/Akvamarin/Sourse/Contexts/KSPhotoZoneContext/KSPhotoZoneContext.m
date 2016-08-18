//
//  KSPhotoZoneContext.m
//  Akvamarin
//
//  Created by KulikovS on 02.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSPhotoZoneContext.h"
#import "KSCalendarConstants.h"
#import "KSCoreDataConstants.h"
#import "KSRequestConstants.h"
#import "KSPhoto.h"
#import "KSPhotoZone.h"
#import "KSPhotoZoneConstants.h"

@interface KSPhotoZoneContext ()
@property (nonatomic, strong) NSArray *photoZones;

- (void)updateDataBaseWithParsingResult:(NSArray *)objects;
- (BOOL)isObjectWithID:(NSString *)IDString fromArray:(NSArray *)array;

@end

@implementation KSPhotoZoneContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.photoZones = [KSPhotoZone fetchEntityWithSortDescriptors:nil predicate:nil prefetchPaths:nil];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSURL *)requestURL {
    return [NSURL URLWithString:kKSPhotoZoneUrlString];
}

- (NSDictionary *)headers {
    return  @{kKSAcceptHeaderKey: kKSApplicationHeaderKey, kKSContentHeaderKey:kKSApplicationHeaderKey};
}

#pragma mark -
#pragma mark Private Methods

- (void)parseResult:(NSDictionary *)result {
    @synchronized (self) {
        NSArray *array = [result valueForKeyPath:kKSDataKey];
        NSMutableArray *parsingObjects = [NSMutableArray array];
        
        for (NSDictionary *category in array) {
            NSNumber *categoryID = [category valueForKeyPath:kKSCategoryIDKey];
            KSPhotoZone *photoZone = [KSPhotoZone objectWithID:categoryID.stringValue];
            photoZone.name = [category valueForKeyPath:kKSCategoryNameKey];
            
            NSArray *photos = [category valueForKeyPath:kKSImageKey];
            NSNumber *imageID = [photos[0] valueForKeyPath:KKSIDKey];
            KSPhoto *photo = [KSPhoto objectWithID:imageID.stringValue];
            photo.url = [photos[0] valueForKey:kKSUrlKey];
            photoZone.mainPhoto = photo;
            
            [parsingObjects addObject:photoZone];
            [photoZone saveManagedObject];
        }
        
        [self updateDataBaseWithParsingResult:parsingObjects];
    }
}

- (void)updateDataBaseWithParsingResult:(NSArray *)objects {
    for (KSPhotoZone *photoZone in self.photoZones) {
        NSString *photoZoneID = photoZone.ID;
        if (![self isObjectWithID:photoZoneID fromArray:objects]) {
            [photoZone.mainPhoto deleteManagedObject];
            for (KSPhoto *photo in photoZone.photos) {
                [photoZone removePhotosObject:photo];
                [photo deleteManagedObject];
            }
            
            [photoZone deleteManagedObject];
        }
    }
}

- (BOOL)isObjectWithID:(NSString *)IDString fromArray:(NSArray *)array {
    for (KSPhotoZone *photoZone in array) {
        if ([photoZone.ID isEqualToString:IDString]) {
            return YES;
        }
    }
    
    return NO;
}

@end