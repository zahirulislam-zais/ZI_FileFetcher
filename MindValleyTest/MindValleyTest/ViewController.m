//
//  ViewController.m
//  MindValleyTest
//
//  Created by Zahirul Islam on 7/24/17.
//  Copyright © 2017 ZI. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"

@interface ViewController (){
    UIRefreshControl *refresh;
}
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CGFloat cellWidth;
@property (nonatomic,assign) NSInteger pagePointer;
@property (nonatomic,strong) ProfileInfo *profileInfo;
@property (strong,nonatomic) NSMutableArray *dataListArray;
//file cache downloader
@property (nonatomic, strong) FileFetcher *fileFetcher;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fileFetcher = [[FileFetcher alloc] init];
    self.dataListArray = [[NSMutableArray alloc] init];
    _pagePointer = 0;
    _cellWidth = (self.collectionView.frame.size.width )/ 2 - 22.5;
    
    //For Pinterest like layout
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 25, 15);
    layout.minimumColumnSpacing = 15;
    layout.minimumInteritemSpacing = 12;
    self.collectionView.collectionViewLayout = layout;
    
    // Pull to refresh
    refresh = [[UIRefreshControl alloc] init];
    refresh.backgroundColor = [UIColor whiteColor];
    refresh.tintColor = [UIColor lightGrayColor];
    [refresh addTarget:self
                action:@selector(pullToRefreshDataWithHud:)
      forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refresh];
    
    // Fetch data from the webservice
    [self fetchProfileData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pullToRefreshDataWithHud:(BOOL)showHud{
    
    BOOL isNetworkConnectionAvailable = [Common connected];
    
    if (isNetworkConnectionAvailable) {
        ProfileFetcher *profileFetcher = [[ProfileFetcher alloc]init];
        //Provision for parameter dictionary has been kept in case the concept of paging is implemented in the web service or any other parameter is required to pass
        NSDictionary *param = nil;
        
        [profileFetcher fetchDataService:param fromURL:DATA_URL with_success:^(AFHTTPRequestSerializer *operation, NSArray *data) {
            
            _dataListArray = [data mutableCopy];
            NSLog(@"Profile Data Array: %@", _dataListArray);
            NSLog(@"Data Array Count====  %lu",(unsigned long)_dataListArray.count);
            [self.collectionView reloadData];
            [refresh endRefreshing];
            
        } failure:^(AFHTTPRequestSerializer *operation, NSError *error) {
            
            [refresh endRefreshing];
            [[Common sharedInstance] showOnlyAlert:APP_ALERT_TITLE Msg:error.localizedDescription];
            
        }];
    }
    else{
        [[Common sharedInstance] showOnlyAlert:APP_ALERT_TITLE Msg:@"Internet Connection is not available. Please try again later."];
    }
}

-(void) fetchProfileData
{
    BOOL isNetworkConnectionAvailable = [Common connected];
    if (isNetworkConnectionAvailable) {
        ProfileFetcher *profileFetcher = [[ProfileFetcher alloc]init];
        //Provision for parameter dictionary has been kept in case the concept of paging is implemented in the web service or any other parameter is required to pass
        NSDictionary *param = nil;
        
        [profileFetcher fetchDataService:param fromURL:DATA_URL with_success:^(AFHTTPRequestSerializer *operation, NSArray *data) {
            
            _dataListArray = [data mutableCopy];
            NSLog(@"Profile Data Array: %@", _dataListArray);
            NSLog(@"Data Array Count====  %lu",(unsigned long)_dataListArray.count);
            [self.collectionView reloadData];
            
        } failure:^(AFHTTPRequestSerializer *operation, NSError *error) {
            
            [[Common sharedInstance] showOnlyAlert:APP_ALERT_TITLE Msg:error.localizedDescription];
            
        }];
    }
    else{
        [[Common sharedInstance] showOnlyAlert:APP_ALERT_TITLE Msg:@"Internet Connection is not available. Please try again later."];
    }
}

#pragma mark  - Collection View Datasource
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataListArray.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    _profileInfo = _dataListArray[indexPath.row];
    NSLog(@"Image URL: %@", _profileInfo.smallPhotoURL);
//    cell.imageView.image =
    cell.nameLbl.text = _profileInfo.name;
    
    [self addActivityIndicatorToCellImageView:cell];
    [self startLogoDownload:indexPath ImageURL:_profileInfo.smallPhotoURL Sender:cell];
    
    cell.imageView.layer.cornerRadius = 8.0;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageOverlay.layer.cornerRadius = 8.0;
    cell.imageOverlay.layer.masksToBounds = YES;
    
    [cell layoutSubviews];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProfileInfo *profileInfo = self.dataListArray[indexPath.row];
    CGFloat imageWidth = profileInfo.imageWidth;
    CGFloat imageHeight = profileInfo.imageHeight;
    
    CGFloat aspectRatio = imageHeight/imageWidth;
    imageHeight = _cellWidth * aspectRatio;
    if (imageHeight >=  300) {
        imageHeight = 300;
    }
    CGFloat heightToAdd = imageHeight+90;
    if (profileInfo.name && profileInfo.name.length > 0){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _cellWidth - 16, 10)];
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"Helvetica" size:12];
        NSString* result = [profileInfo.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        label.text = result;
        [label sizeToFit];
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        heightToAdd = heightToAdd + label.bounds.size.height;
    }
    return CGSizeMake(_cellWidth, heightToAdd);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark  - Async Image File Download
//Add Collection View Cell Activity indicator
- (void)addActivityIndicatorToCellImageView:(ImageCollectionViewCell *)cell {
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] init];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    activityView.center = cell.imageOverlay.center;
    [activityView startAnimating];
    [cell.imageOverlay addSubview:activityView];
}

//Download image file asynchronously
- (void)startLogoDownload:(NSIndexPath *)indexPath ImageURL:(NSString *)urlString Sender:(id)senderObj {
    [_fileFetcher startDownload:urlString AKey:urlString Sender:senderObj
              CompletionHandler:^(id downloadedData, NSString *mimeType, NSString *key, id sender) {
                  if (downloadedData !=nil) {
                      
                      //checking the downloaded file type is image or not
                      if ([mimeType rangeOfString:@"image"].location != NSNotFound) {
                          UIImage *dowloadedImage = [[UIImage alloc] initWithData:downloadedData];
                          dispatch_async(dispatch_get_main_queue(), ^{
                              if ([sender isKindOfClass:[ImageCollectionViewCell class]]) {
                                  ImageCollectionViewCell *imageCollectionViewCell = (ImageCollectionViewCell *)sender;
                                  // Display the loaded image
                                  imageCollectionViewCell.imageView.image = dowloadedImage;
                                  [self removeActivityIndicatorFromCellImageView:imageCollectionViewCell];
                              }
                          });
                      }
                  }
                  else{
                      NSLog(@"downloadedData is empty");
                      if ([sender isKindOfClass:[ImageCollectionViewCell class]]) {
                          ImageCollectionViewCell *imageCollectionViewCell = (ImageCollectionViewCell *)sender;
                          // Remove the activity indicator
                          [self removeActivityIndicatorFromCellImageView:imageCollectionViewCell];
                      }
                  }
              }];
}

//Remove Collection View Cell Activity indicator
- (void)removeActivityIndicatorFromCellImageView:(ImageCollectionViewCell *)cell {
    for (id item in cell.imageOverlay.subviews) {
        if ([item isKindOfClass:[UIActivityIndicatorView class]]) {
            UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)item;
            [activityView stopAnimating];
            [activityView removeFromSuperview];
        }
    }
}

@end
