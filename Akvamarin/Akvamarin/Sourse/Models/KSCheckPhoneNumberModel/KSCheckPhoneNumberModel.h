//
//  KSCheckPhoneNumberModel.h
//  Akvamarin
//
//  Created by KulikovS on 09.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSCheckPhoneNumberModel : UIViewController


- (NSString *)checkPhoneNumberWithNumber:(UITextField *)phoneNumber
                                   range:(NSRange)range
                       replacementString:(NSString *)string;

@end
