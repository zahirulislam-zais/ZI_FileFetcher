//
//  FileFetcher.h
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileFetcher : NSObject

//downloads a file
- (void)startDownload:(NSString *)urlToDownloadFile AKey:(NSString *)forKey Sender:(id)sender
    CompletionHandler:(void(^)(id downloadedData, NSString* mimeType, NSString *key, id sender))completionHandler;

//cancels a download using the key
- (void)cancelDownload:(NSString *)forKey;

//Cancels all the downloads
- (void)cancelAllDownloads;

@end
