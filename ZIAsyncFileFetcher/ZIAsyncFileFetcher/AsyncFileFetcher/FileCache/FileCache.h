//
//  FileCache.h
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileInfo.h"
#import "FileFetcherConfig.h"

@interface FileCache : NSObject

//Stores a file
- (void)storeFile:(id)aFile MIMEType:(NSString *)mimeType FileURL:(NSString *)anURL;

//Retrieves a file
- (FileInfo *)retrieveFile:(NSString *)anURL;

//Removes the cache
- (void)removeCache;
@end
