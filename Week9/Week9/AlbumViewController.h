//
//  AlbumViewController.h
//  Week9
//
//  Created by YongJai on 24/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>


@interface AlbumViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)NSMutableArray *photos;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@end
