//
//  CHTCollectionViewWaterfallHeader.m
//  Demo
//
//  Created by Neil Kimmett on 21/10/2013.
//  Copyright (c) 2013 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallHeader.h"

@implementation CHTCollectionViewWaterfallHeader
@synthesize collectionView;

#pragma mark - Accessors
- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor clearColor];
      
//      _collectionView = [[UICollectionView alloc] initWithFrame:frame;//CGRectMake(0, 8, 375, 109)];
//      UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)_collectionView.collectionViewLayout;
//      layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
//      layout.minimumInteritemSpacing = 15;
//      layout.minimumLineSpacing = 15;
      
      collectionView.backgroundColor = [UIColor redColor];
  }
  return self;
}

@end
