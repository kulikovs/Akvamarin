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
@property (nonatomic, strong) NSURLSession                   *URLSession;
@property (nonatomic, strong) NSURLSessionDataTask           *dataTask;
@property (nonatomic, strong) NSArray                        *photoZones;

- (void)parseResult:(NSDictionary *)result;
- (void)dump;

@end

@implementation KSPhotoZoneContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.URLSession = [NSURLSession sessionWithConfiguration:
                           [NSURLSessionConfiguration defaultSessionConfiguration]];
        self.photoZones = [KSPhotoZone fetchEntityWithSortDescriptors:nil predicate:nil prefetchPaths:nil];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)prepareToLoad {
    @synchronized (self) {
        [self dump];
        
        NSURL *photoZoneURL = [NSURL URLWithString:kKSPhotoZoneUrlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:photoZoneURL];
        
        NSDictionary *headers = @{kKSAcceptHeaderKey: kKSApplicationHeaderKey,                                  kKSContentHeaderKey:kKSApplicationHeaderKey};
        
        [request setHTTPMethod:kKSGetHTTPMethod];
        [request setAllHTTPHeaderFields:headers];
        
        id block = ^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [self setState:kKSModelStateFailed withObject:nil];
            } else {
                [self parseResult:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
                self.photoZones = [KSPhotoZone fetchEntityWithSortDescriptors:nil
                                                                    predicate:nil
                                                                prefetchPaths:nil];
                [self setState:kKSModelStateLoaded withObject:nil];
            }};
        
        self.dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:block];
        
        [self.dataTask resume];
    }
}

- (void)cancel {
    [self.dataTask cancel];
}

#pragma mark -
#pragma mark Private Methods

- (void)parseResult:(NSDictionary *)result {
    @synchronized (self) {
        NSArray *array = [result valueForKeyPath:kKSDataKey];

        
        for (NSDictionary *category in array) {
            NSNumber *categoryID = [category valueForKeyPath:kKSCategoryIDKey];
            KSPhotoZone *photoZone = [KSPhotoZone objectWithID:categoryID.stringValue];
            photoZone.name = [category valueForKeyPath:kKSCategoryNameKey];
            
            NSArray *photos = [category valueForKeyPath:kKSImageKey];
            NSNumber *imageID = [photos[0] valueForKeyPath:KKSIDKey];
            KSPhoto *photo = [KSPhoto objectWithID:imageID.stringValue];
            photo.url = [photos[0] valueForKey:kKSUrlKey];
            
            photoZone.mainPhoto = photo;

            [photoZone saveManagedObject];
        }
        
  //      [self removeOldPhotoZones];
    }
}

- (void)dump {
    self.state = kKSModelStateUndefined;
}
//
//- (void)removeOldPhotoZones {
//    NSArray *newPhotoZone = [KSPhotoZone fetchEntityWithSortDescriptors:nil predicate:nil prefetchPaths:nil];
//    
//    for (KSPhotoZone *photoZone in self.photoZones) {
//        if ([newPhotoZone indexOfObject:photoZone]) {
//            NSString *idString = photoZone.ID;
//            KSPhotoZone *photoZone = [KSPhotoZone objectWithID:idString];
//            [photoZone deleteManagedObject];
//        }
//    }
//}

@end
