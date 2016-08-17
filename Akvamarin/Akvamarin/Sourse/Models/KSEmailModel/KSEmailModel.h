//
//  KSEmailModel.h
//  Akvamarin
//
//  Created by KulikovS on 10.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSEmailModel : NSObject

- (NSString *)formattedEmailAdressWithAdress:(UITextField *)emailAdress
                                       range:(NSRange)range
                           replacementString:(NSString *)string;

- (BOOL)isValidEmailAdress:(NSString *)email;

@end
