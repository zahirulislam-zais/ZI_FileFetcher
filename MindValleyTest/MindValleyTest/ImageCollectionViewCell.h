//
//  ImageCollectionViewCell.h
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/25/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIImageView *imageOverlay;
@property (nonatomic, weak) IBOutlet UILabel *nameLbl;

@end
