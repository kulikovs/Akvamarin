//
//  KSPhoneNumberModel.h
//  Akvamarin
//
//  Created by KulikovS on 09.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSPhoneNumberModel : NSObject

- (NSString *)formattedPhoneNumberWithNumber:(UITextField *)number
                                       range:(NSRange)range
                           replacementString:(NSString *)string;

- (BOOL)isValidPhoneNumber:(NSString *)phoneNumber;

@end
