//
//  KSSharedCacheModel.m
//  KSIdapStudy
//
//  Created by KulikovS on 01.06.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSCache.h"

static NSString   *  const  kKSStringCachedFilesSave   =   @"cachedFilesSave.plist";
static NSString   *  const  kKSStringCachedFiles       =   @"cachedFiles";

static KSCache * model = nil;

@interface KSCache ()
@property (nonatomic, strong)   NSMutableDictionary *cachedFiles;
@property (nonatomic, readonly) NSString            *path;
@property (nonatomic, readonly) NSArray             *notificationKey;

- (void)addObserverWithKeys:(NSArray *)keys;
- (void)removeObserverWithKeys:(NSArray *)keys;
- (void)save;

@end

@implementation KSCache

#pragma mark - 
#pragma mark Class Methods

+ (instancetype)sharedCache {
    static dispatch_once_t once_token = 0;
    dispatch_once(&once_token, ^{
        KSCache *newModel =  [self new];
        model = [NSKeyedUnarchiver unarchiveObjectWithFile:newModel.path];
        
        if (!model) {
            model = [self new];
            model.cachedFiles = [NSMutableDictionary dictionary];
        }
        
        [model addObserverWithKeys:model.notificationKey];
    });
    
    return model;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self removeObserverWithKeys:self.notificationKey];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    return [NSFileManager pathToFileInDocumentsWithName:kKSStringCachedFilesSave];
}

- (NSArray *)notificationKey {
    return @[UIApplicationDidEnterBackgroundNotification, UIApplicationWillTerminateNotification];
}

#pragma mark -
#pragma mark Private Methods

- (void)addObserverWithKeys:(NSArray *)keys {
    @synchronized (self) {
        for (NSString *key in keys) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(save)
                                                         name:key
                                                       object:nil];
        }
    }
}

- (void)removeObserverWithKeys:(NSArray *)keys {
    @synchronized (self) {
        for (NSString *key in keys) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:key object:nil];
        }
    }
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self toFile:self.path];
}

#pragma mark -
#pragma mark Public Methods

- (NSString *)URLStringForFileName:(NSString *)fileName {
    @synchronized (self) {
        NSArray *keys = self.cachedFiles.allKeys;
        NSDictionary *dictionary = [self.cachedFiles copy];
        for (NSString *key in keys) {
            if ([[dictionary objectForKey:key] isEqualToString:fileName]) {
                return key;
            }
        }
    }
    
    return nil;
}

- (NSString *)fileNameForURLString:(NSString *)URLString {
   return [self.cachedFiles objectForKey:URLString];
}

- (BOOL)isCashedForURLString:(NSString *)URLString; {
    @synchronized (self) {
        return [self.cachedFiles objectForKey:URLString];
    }
}

- (void)removeURLString:(NSString *)URLString {
    @synchronized (self) {
        [self.cachedFiles removeObjectForKey:URLString];
    }
}

- (void)addURLString:(NSString *)URLString fileName:(NSString *)fileName; {
    @synchronized (self) {
        NSString *string = [self URLStringForFileName:[URLString lastPathComponent]];
        if (string && ![string isEqualToString:URLString]) {
            [self removeURLString:string];
        }
        
        [self.cachedFiles setObject:fileName forKey:URLString];
    }
}

#pragma mark -
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.cachedFiles = [decoder decodeObjectForKey:kKSStringCachedFiles];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.cachedFiles forKey:kKSStringCachedFiles];
}

@end
