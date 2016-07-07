//
//  KSImageModel.m
//  KSIdapStudy
//
//  Created by KulikovS on 26.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSImageModel.h"
#import "KSCache.h"

@interface KSImageModel ()
@property (nonatomic, readonly, getter=isCached) BOOL                       cached;
@property (nonatomic, readonly)                  NSString                   *path;
@property (nonatomic, readonly)                  NSString                   *fileName;
@property (nonatomic, readonly)                  KSCache                    *cacheModel;
@property (nonatomic, strong)                    NSURLSession               *URLSession;
@property (nonatomic, strong)                    NSURLSessionDownloadTask   *downloadTask;

- (void)removeIfNeeded;
- (void)dump;
- (void)performDownload;
- (void)loadFromFileSystem;

@end

@implementation KSImageModel

@dynamic cached;
@dynamic fileName;
@dynamic path;
@dynamic cacheModel;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype) init {
    self = [super init];
    if (self) {
        self.URLSession = [NSURLSession sessionWithConfiguration:
                           [NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isCached {
   return [self.cacheModel isCashedForURLString:self.URL.absoluteString];
}

- (void)setURL:(NSURL *)URL {
    if (![_URL isEqual:URL]) {
        _URL = URL;
        
        [self dump];
    }
    
    [self load];
}

- (KSCache *)cacheModel {
    return [KSCache sharedCache];;
}

- (NSString *)path {
   return [NSFileManager pathToFileInDocumentsWithName:self.fileName];
}

- (NSString *)fileName {
    NSArray *paths = [self.URL pathComponents];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@",paths[paths.count - 2],
                          [self.URL lastPathComponent]];

    return fileName;
}

- (void)setDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    if (_downloadTask != downloadTask) {
        [_downloadTask cancel];
        
         _downloadTask = downloadTask;
        [_downloadTask resume];
    }
}

#pragma mark -
#pragma mark Private

- (void)removeIfNeeded {
    if (self.isCached) {
        NSError *error = nil;
        if ([[NSFileManager defaultManager] removeItemAtPath:self.path error:&error]) {
            [self.cacheModel removeURLString:self.URL.absoluteString];
        }
    }
}

- (void)performDownload {
    @synchronized (self) {
        id block = ^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSURL *URL = self.URL;
            
            if (!error) {
                NSError *fileError = nil;
                NSString *path = self.path;
                
                NSFileManager *fileManager = [NSFileManager defaultManager];
                
                if (!self.isCached && [fileManager fileExistsAtPath:path]) {
                    [fileManager removeItemAtPath:path error:nil];
                }
                
                [fileManager copyItemAtURL:location
                                     toURL:[NSURL fileURLWithPath:path]
                                     error:&fileError];
                
                if (!fileError) {
                    [self.cacheModel addURLString:URL.absoluteString
                                         fileName:self.fileName];
                }
                
                [self loadFromFileSystem];
            }
        };
        
        
        self.downloadTask = [self.URLSession downloadTaskWithURL:self.URL completionHandler:block];
    }
}

- (void)loadFromFileSystem {
    if (self.isCached) {
        UIImage *image = [UIImage imageWithContentsOfFile:self.path];
        
        if (!image) {
            [self removeIfNeeded];
        } else {
            self.image = image;
        }
    }
    
    [self completeLoading];
}

- (void)prepareToLoad {
    if (self.URL.isFileURL || self.isCached) {
        [self loadFromFileSystem];
    } else {
        [self performDownload];
    }
}

- (void)dump {
    self.state = kKSModelStateUndefined;
}

- (void)completeLoading {
    KSWeakifySelf;
    KSDispatchAsyncOnMainThread(^{
        KSStrongifySelfWithClass(KSImageModel);
        kKSArrayModelState state = self.image ? kKSModelStateLoaded : kKSModelStateFailed;
        [self setState:state withObject:self.image];
    });
}

@end
