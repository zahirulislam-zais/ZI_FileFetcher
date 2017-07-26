//
//  FileInfo.m
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import "FileInfo.h"

@implementation FileInfo

//Custom initializer of the class
- (instancetype)initWithObject:(id)inputFile MIMEType:(NSString *)aMIMEType FileURL:(NSString *)anURL {
    self = [super init];
    if(self) {
        _aFile     = inputFile;
        _urlString = anURL;
        _mimeType  = aMIMEType;
    }
    return self;
}

// Encodes the class
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.aFile forKey:@"aFile"];
    [aCoder encodeObject:self.urlString forKey:@"urlString"];
    [aCoder encodeObject:self.mimeType forKey:@"mimeType"];
}

@end
