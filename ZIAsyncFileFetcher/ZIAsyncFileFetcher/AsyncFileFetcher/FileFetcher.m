//
//  FileFetcher.m
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import "FileFetcher.h"
#import "FileCache.h"

@interface FileFetcher()

//represents the collection that holds the download tasks
@property (nonatomic, strong) NSMutableDictionary *dowloadTaskCollection;

//represents the in-memory caching object that manages the file cache mechanism
@property (nonatomic, strong) FileCache *fileCache;

@end

@implementation FileFetcher

- (id)init {
    self = [super init];
    if (self) {
        _dowloadTaskCollection = [[NSMutableDictionary alloc] init];
        _fileCache     = [[FileCache alloc] init];
    }
    return self;
}

// Downloads a file

- (void)startDownload:(NSString *)urlToDownloadFile AKey:(NSString *)forKey Sender:(id)sender
    CompletionHandler:(void(^)(id downloadedData, NSString* mimeType, NSString *key,id sender))completionHandler{
    
    FileInfo *fileInfo = [_fileCache retrieveFile:urlToDownloadFile];
    if (fileInfo) {
        // call the completion handler to provide the cached file
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            completionHandler(fileInfo.aFile,fileInfo.mimeType,forKey, sender);
        }];
    } else {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlToDownloadFile]];
        // create an session data task to obtain and download the app icon
        NSURLSessionDataTask *sessionTask =
        [[NSURLSession sharedSession] dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            // in case we want to know the response status code
                                            //NSInteger HTTPStatusCode = [(NSHTTPURLResponse *)response statusCode];
                                            if (error != nil) {
                                                if ([error code] == NSURLErrorAppTransportSecurityRequiresSecureConnection) {
                                                    // if you get error NSURLErrorAppTransportSecurityRequiresSecureConnection (-1022),
                                                    // then your Info.plist has not been properly configured to match the target server.
                                                    abort();
                                                }
                                            }
                                            NSString *mimeType = response.MIMEType;
                                            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                                                [_fileCache storeFile:data MIMEType:mimeType FileURL:urlToDownloadFile];
                                                // call the completion handler to provide the dowloaded file
                                                completionHandler(data,mimeType,forKey,sender);
                                            }];
                                            [_dowloadTaskCollection removeObjectForKey:forKey];
                                        }];
        
        [sessionTask resume];
        [_dowloadTaskCollection setObject:sessionTask forKey:forKey];
    }
}

// Cancels all the downloads
- (void)cancelAllDownloads {
    for (NSString *forKey in [_dowloadTaskCollection allKeys]) {
        NSURLSessionDataTask *sessionTask = [_dowloadTaskCollection objectForKey:forKey];
        if (sessionTask && (sessionTask.state == NSURLSessionTaskStateRunning ||
                            sessionTask.state == NSURLSessionTaskStateSuspended)) {
            [sessionTask cancel];
        }
        sessionTask = nil;
    }
    
    [self removeCache];
}

// Cancels a download
- (void)cancelDownload:(NSString *)forKey {
    NSURLSessionDataTask *sessionTask = [_dowloadTaskCollection objectForKey:forKey];
    if (sessionTask && (sessionTask.state == NSURLSessionTaskStateRunning ||
                        sessionTask.state == NSURLSessionTaskStateSuspended)) {
        [sessionTask cancel];
    }
    sessionTask = nil;
}

//Removes the cache
- (void)removeCache {
    [_dowloadTaskCollection removeAllObjects];
    [_fileCache removeCache];
}

@end
