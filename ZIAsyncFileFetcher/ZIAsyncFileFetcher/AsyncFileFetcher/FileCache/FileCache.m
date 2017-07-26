//
//  FileCache.m
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import "FileCache.h"

@interface FileCache()

@property (nonatomic, strong) NSMutableArray *filesCache;
@property (nonatomic, assign) unsigned long currentCacheSize;

@end

@implementation FileCache

- (id)init {
    self = [super init];
    if (self) {
        _currentCacheSize = 0;
        _filesCache = [[NSMutableArray alloc] init];
    }
    return self;
}

//Stores a file
- (void)storeFile:(id)aFile MIMEType:(NSString *)mimeType FileURL:(NSString *)anURL {
    FileInfo *fileInfo = [[FileInfo alloc] initWithObject:aFile MIMEType:mimeType FileURL:anURL];
    //making sure the recently used data should be the last item
    if (![_filesCache containsObject:fileInfo]) {
        [self removeNotRecentlyUsedFilesIfNeeded:[fileInfo.aFile length]];
    } else {
        [_filesCache removeObject:fileInfo];
        _currentCacheSize -= [fileInfo.aFile length];
    }
    
    [_filesCache addObject:fileInfo];
    _currentCacheSize += [fileInfo.aFile length];
}

//Retrieves a file
- (FileInfo *)retrieveFile:(NSString *)anURL {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"urlString==%@",anURL];
    NSArray *filteredArray = [_filesCache filteredArrayUsingPredicate:predicate];
    FileInfo *fileInfo = (filteredArray.count > 0) ? [filteredArray objectAtIndex:0] : nil;
    //making sure the recently used data should be the last item
    if (fileInfo) {
        [_filesCache removeObject:fileInfo];
        [_filesCache addObject:fileInfo];
    }
    return fileInfo;
}

//Removes the not recently used files, if buffer size exceeds

- (void)removeNotRecentlyUsedFilesIfNeeded:(unsigned long)newItemSize {
    unsigned long expectedFileCacheSize = _currentCacheSize + newItemSize;
    
    if (expectedFileCacheSize > CACHE_MAXIMUM_CAPACITY && _filesCache.count > 0) {
        FileInfo *fileInfo = [_filesCache objectAtIndex:0];
        _currentCacheSize-= [fileInfo.aFile length];
        [_filesCache removeObjectAtIndex:0];
        
        //recursive call to remove the not recently used data and accommodate the new data
        [self removeNotRecentlyUsedFilesIfNeeded:newItemSize];
    }
}

//Removes the cache
- (void)removeCache {
    
    _currentCacheSize = 0;
    [_filesCache removeAllObjects];
    
}

@end
