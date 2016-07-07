//
//  NSFileManager+KSExtensions.m
//  KSIdapStudy
//
//  Created by KulikovS on 18.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "NSFileManager+KSExtensions.h"

@implementation NSFileManager (KSExtensions)

+ (NSString *)pathToDocumentsDirectory {
    return [self pathToDocumentsForDirectory:NSDocumentDirectory];
}

+ (NSString *)pathToDocumentsForDirectory:(NSSearchPathDirectory)directory {
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentsPaths firstObject];
    
    return documentsDir;
}

+ (NSString *)pathToFileInDocumentsWithName:(NSString *)fileName {
    NSString *documentsDir = [self pathToDocumentsDirectory];
    
    return [documentsDir stringByAppendingPathComponent:fileName];
}

@end
