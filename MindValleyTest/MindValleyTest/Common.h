//
//  Common.h
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/24/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface Common : NSObject

+ (Common *) sharedInstance;
+ (BOOL) connected;
-(BOOL) isNullString:(NSString*)_inputString;
-(void) showOnlyAlert:(NSString*)title Msg:(NSString*)message;

@end
