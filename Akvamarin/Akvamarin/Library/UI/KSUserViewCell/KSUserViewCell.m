//
//  KSUserViewCell.m
//  KSIdapStudy
//
//  Created by KulikovS on 05.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSUserViewCell.h"
#import "KSStringModel.h"
#import "KSImageView.h"

@implementation KSUserViewCell

#pragma mark -
#pragma mark Public Methods

- (void)fillWithModel:(KSStringModel *)model {
    self.customImageView.URL = [NSURL URLWithString:model.URLString];
    self.stringsLabel.text = model.string;
}

@end
