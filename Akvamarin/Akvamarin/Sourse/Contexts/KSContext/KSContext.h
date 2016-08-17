//
//  KSContext.h
//  Akvamarin
//
//  Created by KulikovS on 04.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSModel.h"

@interface KSContext : KSModel
@property (nonatomic, strong)   NSURLSession                   *URLSession;
@property (nonatomic, strong)   NSURLSessionDataTask           *dataTask;

- (void)cancel;
- (void)dump;

@end
