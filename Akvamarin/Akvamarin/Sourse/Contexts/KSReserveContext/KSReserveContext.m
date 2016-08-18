//
//  KSReserveContext.m
//  Akvamarin
//
//  Created by KulikovS on 13.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSReserveContext.h"
#import "KSRequestConstants.h"

@interface KSReserveContext ()
@property (nonatomic, strong) NSDictionary *reserveData;

@end

@implementation KSReserveContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [[[self class] alloc] initWithReserveData:nil];
}

- (instancetype)initWithReserveData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        self.reserveData = data;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSURL *)requestURL {
    return [NSURL URLWithString:kKSSendMailUrlString];
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
        NSError *error;
        NSData *postdata = [NSJSONSerialization dataWithJSONObject:self.reserveData
                                                           options:0
                                                             error:&error];
        [request setHTTPMethod:kKSHTTPMethodPOST];
        [request setAllHTTPHeaderFields:self.headers];
        [request setHTTPBody:postdata];
        
        KSWeakifySelf
        id block = ^(NSData *data, NSURLResponse *response, NSError *error) {
            KSStrongifySelfAndReturnIfNil
            if (error) {
                [self setState:kKSModelStateFailed withObject:nil];
            } else {
                [self setState:kKSModelStateLoaded withObject:nil];
            }};
        
        self.dataTask = [[NSURLSession sharedSession] uploadTaskWithRequest:request
                                                                   fromData:postdata
                                                          completionHandler:block];
        [self.dataTask resume];
    }
}

@end
