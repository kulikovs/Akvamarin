//
//  KSPhotoZoneContext.m
//  Akvamarin
//
//  Created by KulikovS on 02.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//
#import <MagicalRecord/MagicalRecord.h>

#import "KSPhotoZoneContext.h"
#import "KSCalendarConstants.h"
#import "KSCoreDataConstants.h"
#import "KSRequestConstants.h"
#import "KSPhoto.h"
#import "KSPhotoZone.h"
#import "KSPhotoZoneConstants.h"

@interface KSPhotoZoneContext ()
@property (nonatomic, strong) NSArray *photoZones;

- (void)updateDataBaseWithParsingResult:(NSArray *)objects context:(NSManagedObjectContext *)context;
- (BOOL)isObjectWithID:(NSString *)IDString fromArray:(NSArray *)array;

@end

@implementation KSPhotoZoneContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.photoZones = [KSPhotoZone MR_findAll];
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
        
        [MagicalRecord saveWithBlock: ^(NSManagedObjectContext *localContext) {
            for (NSDictionary *category in array) {
                NSNumber *categoryID = [category valueForKeyPath:kKSCategoryIDKey];
                KSPhotoZone *photoZone = [KSPhotoZone objectWithID:categoryID.stringValue context:localContext];
                photoZone.name = [category valueForKeyPath:kKSCategoryNameKey];
                
                NSArray *photos = [category valueForKeyPath:kKSImageKey];
                NSNumber *imageID = [photos[0] valueForKeyPath:kKSIDKey];
                KSPhoto *photo = [KSPhoto objectWithID:imageID.stringValue context:localContext];
                photo.url = [photos[0] valueForKey:kKSUrlKey];
                photoZone.mainPhoto = photo;
                
                [parsingObjects addObject:photoZone];
            }
            [self updateDataBaseWithParsingResult:parsingObjects context:localContext];
        } completion: ^(BOOL success, NSError *error) {
            if (!error) {
                [self setState:kKSModelStateLoaded withObject:nil];
            }
        }
         ];
    }
}

- (void)updateDataBaseWithParsingResult:(NSArray *)objects context:(NSManagedObjectContext *)context {
    for (KSPhotoZone *photoZone in self.photoZones) {
        NSString *photoZoneID = photoZone.ID;
        if (![self isObjectWithID:photoZoneID fromArray:objects]) {
            [photoZone.mainPhoto MR_deleteEntityInContext:context];
            for (KSPhoto *photo in photoZone.photos) {
                [photoZone removePhotosObject:photo];
                [photo MR_deleteEntityInContext:context];
            }
            
            [photoZone MR_deleteEntityInContext:context];
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
