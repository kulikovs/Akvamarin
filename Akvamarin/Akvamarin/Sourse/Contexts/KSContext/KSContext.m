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
@property (nonatomic, readonly) NSURL                          *requestURL;
@property (nonatomic, readonly) NSDictionary                   *headers;

- (void)parseResult:(NSDictionary *)result;
- (void)dump;

@end

@implementation KSContext

@dynamic requestURL;
@dynamic headers;

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
    return nil;
}

- (NSDictionary *)headers {
    return nil;
}

#pragma mark -
#pragma mark Public Methods

- (void)prepareToLoad {
    @synchronized (self) {
        [self dump];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.requestURL];
        [request setHTTPMethod:kKSHTTPMethodGET];
        [request setAllHTTPHeaderFields:self.headers];
        
        KSWeakifySelf
        id block = ^(NSData *data, NSURLResponse *response, NSError *error) {
            KSStrongifySelfAndReturnIfNil
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

- (void)dump {
    self.state = kKSModelStateUndefined;
}

#pragma mark -
#pragma mark Private Methods

- (void)parseResult:(NSDictionary *)result {

}

@end