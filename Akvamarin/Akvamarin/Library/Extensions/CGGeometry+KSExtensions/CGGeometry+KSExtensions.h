//
//  CGGeometry+KSExtentions.h
//  KSIdapStudy
//
//  Created by KulikovS on 01.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

CG_INLINE CGRect
CGRectMakeWithSize(CGFloat x, CGFloat y, CGSize size) {
    return CGRectMake(x, y, size.width, size.height);
}

CG_INLINE CGRect
CGRectMakeWithPointSize(CGPoint point, CGSize size) {
    return CGRectMake(point.x, point.y, size.width, size.height);
    
}

CG_INLINE CGRect
CGRectMakeWithPoint(CGPoint point, CGFloat widht, CGFloat height) {
    return CGRectMake(point.x, point.y, widht, height);
}

CG_INLINE CGRect
CGRectMakeWithPointZero(CGFloat widht, CGFloat height) {
    return CGRectMake(0, 0, widht, height);
}
