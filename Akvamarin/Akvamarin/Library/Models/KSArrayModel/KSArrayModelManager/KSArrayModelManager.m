//
//  KSArrayModelManager.m
//  KSIdapStudy
//
//  Created by KulikovS on 22.05.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#import "KSArrayModelManager.h"
#import "KSStringModel.h"

static NSString * const kKSSaveArrayModelKey = @"saveArrayModel.plist";

@interface KSArrayModelManager ()
@property (nonatomic, readonly) NSString    *path;
@property (nonatomic, readonly) NSArray     *notificationKey;

- (void)addObserverWithKeys:(NSArray *)keys;
- (void)removeObserverWithKeys:(NSArray *)keys;
- (void)save;

@end

@implementation KSArrayModelManager

@dynamic path;
@dynamic notificationKey;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self removeObserverWithKeys:self.notificationKey];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addObserverWithKeys:self.notificationKey];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    return [NSFileManager pathToFileInDocumentsWithName:kKSSaveArrayModelKey];
}

- (NSArray *)notificationKey {
    return @[UIApplicationDidEnterBackgroundNotification, UIApplicationWillTerminateNotification];
}

#pragma mark -
#pragma mark Private Methods

- (void)addObserverWithKeys:(NSArray *)keys {
    for (NSString *key in keys) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(save)
                                                     name:key
                                                   object:nil];
    }
}

- (void)removeObserverWithKeys:(NSArray *)keys {
    for (NSString *key in keys) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:key object:nil];
    }
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self toFile:self.path];
}

#pragma mark -
#pragma mark Public Methods

- (void)prepareToLoad {
    KSArrayModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
    model = model ? model : [KSArrayModel arrayModelWithObjects:[KSStringModel randomStringsModels]];
    [self addObjects:model.objects];
}

- (void)finishLoading {
    self.state = kKSModelStateLoaded;
}

@end
