//
//  ProfileFetcher.m
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import "ProfileFetcher.h"

@implementation ProfileFetcher

-(void) fetchDataService:(NSDictionary *)params fromURL:(NSString*)urlString with_success: (void (^) (AFHTTPRequestSerializer *operation, NSArray *data))success failure:(void (^)(AFHTTPRequestSerializer *operation, NSError *error)) failure
{
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    //POST
    [requestManager GET:urlString parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject){
        NSLog(@"responseObject %@",responseObject);
        
        NSArray *responseArray = responseObject;
        if (isArray(responseArray)) {
            NSMutableArray *allData = [[NSMutableArray alloc]init];
            for (NSDictionary *response in responseArray){
                
                [allData addObject:[self profileInfoForResponse:response]];
            }
            NSLog(@"%lu data count",(unsigned long)allData.count);
            success(operation,allData);
        }
        
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failure(operation,error);
        NSLog(@"RESPONSE : %@",operation.responseString);
        NSLog(@"ERROR : %@",error.localizedDescription);
    }];
    
}


// Serialize data
- (ProfileInfo *)profileInfoForResponse:(NSDictionary*)response{
    ProfileInfo *profileInfo = [[ProfileInfo alloc]init];
    
    NSLog(@"=======  %@",response);
    id profileID = response[@"id"];
    if (isString(profileID))
        profileInfo.profileId = profileID;
    
    id userProfile = response[@"user"];
    if (isDictionary(userProfile)){
        
        id userID = userProfile[@"id"];
        if (isString(userID))
            profileInfo.userId = userID;
        
        id username = userProfile[@"username"];
        if (isString(username))
            profileInfo.userName = username;
        
        id name = userProfile[@"name"];
        if (isString(name))
            profileInfo.name = name;
        
        id profilePhotos = userProfile[@"profile_image"];
        if (isDictionary(profilePhotos)){
            id smallPhoto = profilePhotos[@"small"];
            if (isString(smallPhoto))
                profileInfo.profilePictureSmallURL = smallPhoto;
            
            id mediumPhoto = profilePhotos[@"medium"];
            if (isString(mediumPhoto))
                profileInfo.profilePictureMediumURL = mediumPhoto;
            
            id largePhoto = profilePhotos[@"large"];
            if (isString(largePhoto))
                profileInfo.profilePictureLargeURL = largePhoto;
        }
    }
    
    id URLs = response[@"urls"];
    if (isDictionary(URLs)){
        
        id rawPhoto = URLs[@"raw"];
        if (isString(rawPhoto))
            profileInfo.rawPhotoURL = rawPhoto;
        
        id fullPhoto = URLs[@"full"];
        if (isString(fullPhoto))
            profileInfo.fullPhotoURL = fullPhoto;
        
        id regularPhoto = URLs[@"regular"];
        if (isString(regularPhoto))
            profileInfo.regularPhotoURL = regularPhoto;
        
        id smallPhoto = URLs[@"small"];
        if (isString(smallPhoto))
            profileInfo.smallPhotoURL = smallPhoto;
        
        id thumbPhoto = URLs[@"thumb"];
        if (isString(thumbPhoto))
            profileInfo.thumbPhotoURL = thumbPhoto;
        
    }
    
    //Dimensions
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    id imageHeight = response[@"height"];
    NSLog(@"height: %@", imageHeight);
    if (isString(imageHeight))
    {
        NSNumber *height = [f numberFromString:imageHeight == [NSNull null]?@"0":imageHeight];
        profileInfo.imageHeight = height.floatValue / 2;
        NSLog(@"IMAGE HEIGHT: %f", profileInfo.imageHeight);
    }
    else{
        profileInfo.imageHeight = 300;
    }
    
    id imageWidth = response[@"width"];
    NSLog(@"width: %@", imageWidth);
    if (isString(imageWidth))
    {
        NSNumber *height = [f numberFromString:imageWidth == [NSNull null]?@"0":imageWidth];
        profileInfo.imageWidth = height.floatValue / 2;
        NSLog(@"IMAGE WIDTH: %f", profileInfo.imageWidth);
    }
    else{
        profileInfo.imageWidth = 200;
    }
    
    return profileInfo;
}

@end
