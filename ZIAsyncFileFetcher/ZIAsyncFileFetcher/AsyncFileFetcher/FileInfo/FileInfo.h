//
//  FileInfo.h
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileInfo : NSObject

//represents the file to cache
@property (nonatomic, strong) id aFile;

//represents the dowloadanle link/location of the file
@property (nonatomic, strong) NSString *urlString;

//represents the mime type of the downloaded file.
@property (nonatomic, strong) NSString *mimeType;

//custom initilizer of the class
- (instancetype)initWithObject:(id)inputFile MIMEType:(NSString *)aMIMEType FileURL:(NSString *)anURL;

@end
