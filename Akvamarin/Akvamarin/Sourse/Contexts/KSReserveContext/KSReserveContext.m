//
//  KSSendMailContext.m
//  Akvamarin
//
//  Created by KulikovS on 13.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSSendMailContext.h"
#import "KSRequestConstants.h"

@interface KSSendMailContext ()
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end


@implementation KSSendMailContext

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
        [request setHTTPMethod:kKSGetHTTPMethod];
        [request setAllHTTPHeaderFields:self.headers];
        
 //   Ex: {"user": {"start_time": "11.30", "end_time": "12.30", "date": "11.08.2016", "name": "Name", "email": "1@ex.com", "phone": "12345678"} }

//        
//        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:
//                             email, @"Email",
//                             fname, @"FirstName",
//                             nil];
        
        NSDictionary *data = [NSDictionary dictionary];
        NSError *error;
        NSData *postdata = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
        [request setHTTPBody:postdata];
        
        id block = ^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                [self setState:kKSModelStateFailed withObject:nil];
            } else {
                [self setState:kKSModelStateLoaded withObject:nil];
            }};


        self.dataTask = [[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:postdata completionHandler:block];
        
        [self.dataTask resume];
    }
}


@end
