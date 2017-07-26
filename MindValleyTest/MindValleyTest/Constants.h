//
//  Constants.h
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/24/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

// Alert Message title
#define APP_ALERT_TITLE @"Mind Valley Test"

// URL to fetch data
#define DATA_URL @"http://pastebin.com/raw/wgkJgazE"

//SHORT-HANDS
#define isString(obj) [obj isKindOfClass:[NSString class]]
#define isNumber(obj) [obj isKindOfClass:[NSNumber class]]
#define isArray(obj) [obj isKindOfClass:[NSArray class]]
#define isDictionary(obj) [obj isKindOfClass:[NSDictionary class]]
#define isNSNull(obj) (obj == (id)[NSNull null])

#endif /* Constants_h */
