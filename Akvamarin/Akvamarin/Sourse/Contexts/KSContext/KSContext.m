//
//  KSContext.m
//  Akvamarin
//
//  Created by KulikovS on 04.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSContext.h"
#import "KSRequestConstants.h"

@interface KSContext ()
@property (nonatomic, strong)   NSURLSession                   *URLSession;
@property (nonatomic, strong)   NSURLSessionDataTask           *dataTask;
@property (nonatomic, readonly) NSURL                          *requestURL;
@property (nonatomic, readonly) NSDictionary                   *headers;

- (void)parseResult:(NSDictionary *)result;
- (void)dump;

@end

@implementation KSContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.URLSession = [NSURLSession sessionWithConfiguration:
                           [NSURLSessionConfiguration ephemeralSessionConfiguration]];
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
#pragma mark Public Methods

- (void)prepareToLoad {
    @synchronized (self) {
        [self dump];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.requestURL];
        [request setHTTPMethod:kKSGetHTTPMethod];
        [request setAllHTTPHeaderFields:self.headers];
        
        id block = ^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [self setState:kKSModelStateFailed withObject:nil];
            } else {
                [self parseResult:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
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

}

- (void)dump {
    self.state = kKSModelStateUndefined;
}

@end