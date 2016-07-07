//
//  KSImageView.h
//  KSIdapStudy
//
//  Created by KulikovS on 26.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSImageModel;

@interface KSImageView : UIView
@property (nonatomic, strong)   NSURL           *URL;
@property (nonatomic, strong)   KSImageModel    *imageModel;

@end
