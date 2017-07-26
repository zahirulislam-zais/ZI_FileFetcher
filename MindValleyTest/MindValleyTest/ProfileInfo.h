//
//  ProfileInfo.h
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ProfileInfo : NSObject

@property (strong,nonatomic) NSString *profileId;
@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *profilePictureSmallURL;
@property (strong,nonatomic) NSString *profilePictureMediumURL;
@property (strong,nonatomic) NSString *profilePictureLargeURL;
@property (strong,nonatomic) NSString *collectionPicURL;
@property (strong,nonatomic) NSString *rawPhotoURL;
@property (strong,nonatomic) NSString *fullPhotoURL;
@property (strong,nonatomic) NSString *regularPhotoURL;
@property (strong,nonatomic) NSString *smallPhotoURL;
@property (strong,nonatomic) NSString *thumbPhotoURL;
@property (nonatomic) CGFloat imageHeight;
@property (nonatomic) CGFloat imageWidth;

@end
