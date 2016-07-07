//
//  UICollectionView+UICollectionView.m
//  KSTestFacebookProject
//
//  Created by KulikovS on 23.06.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "UICollectionView+UICollectionView.h"

@implementation UICollectionView (UICollectionView)

- (id)dequeueReusableCellFromNibWithClass:(Class)theClass indexPath:(NSIndexPath *)indexPath; {
    
    id cell = [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(theClass) forIndexPath:indexPath];
    if (!cell) {
        cell = [UINib loadFromNibWithClass:(theClass)];
    }
    
    return cell;
}

- (void)registerCollectionViewCellWithClass:(Class)theClass {
    [self registerNib:[UINib nibWithClass:(theClass)] forCellWithReuseIdentifier:NSStringFromClass(theClass)];
}

@end
