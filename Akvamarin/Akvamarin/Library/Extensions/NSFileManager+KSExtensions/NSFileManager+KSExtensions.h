//
//  NSFileManager+KSExtensions.h
//  KSIdapStudy
//
//  Created by KulikovS on 18.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (KSExtensions)

+ (NSString *)pathToDocumentsDirectory;
+ (NSString *)pathToDocumentsForDirectory:(NSSearchPathDirectory)directory;
+ (NSString *)pathToFileInDocumentsWithName:(NSString *)fileName;

@end
