//
//  KSSendMailContext.m
//  Akvamarin
//
//  Created by KulikovS on 13.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSSendMailContext.h"
#import "KSRequestConstants.h"

@implementation KSSendMailContext

#pragma mark -
#pragma mark Accessors

- (NSURL *)requestURL {
    NSString *urlString = @"http://test-self-app.herokuapp.com/send_email";
    return [NSURL URLWithString:urlString];
}

- (NSDictionary *)headers {
    return  @{kKSAcceptHeaderKey: kKSApplicationHeaderKey, kKSContentHeaderKey:kKSApplicationHeaderKey};
}

@end
