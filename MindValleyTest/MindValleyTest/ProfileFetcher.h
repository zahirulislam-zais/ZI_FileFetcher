//
//  ProfileFetcher.h
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileInfo.h"
#import "Constants.h"
#import "Common.h"
#import <AFNetworking/AFNetworking.h>

@interface ProfileFetcher : NSObject

//Fetch Data using AFNetworking
-(void) fetchDataService:(NSDictionary *)params fromURL:(NSString*)urlString with_success: (void (^) (AFHTTPRequestSerializer *operation, NSArray *data))success failure:(void (^)(AFHTTPRequestSerializer *operation, NSError *error)) failure;

- (ProfileInfo *)profileInfoForResponse:(NSDictionary*)response;

@end
