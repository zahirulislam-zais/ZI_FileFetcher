//
//  ViewController.h
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/24/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.m"
#import "ProfileInfo.h"
#import "ProfileFetcher.h"
#import "Constants.h"
#import "Common.h"
#import <ZIAsyncFileFetcher/FileFetcher.h>


@interface ViewController : UIViewController<CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDataSource>


@end

