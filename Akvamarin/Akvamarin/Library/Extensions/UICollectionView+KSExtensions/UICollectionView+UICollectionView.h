//
//  UICollectionView+UICollectionView.h
//  KSTestFacebookProject
//
//  Created by KulikovS on 23.06.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (UICollectionView)
- (id)dequeueReusableCellFromNibWithClass:(Class)theClass indexPath:(NSIndexPath *)indexPath;
- (void)registerCollectionViewCellWithClass:(Class)theClass;

@end
