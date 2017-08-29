//
//  AlbumViewController.m
//  Week9
//
//  Created by YongJai on 24/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "AlbumViewController.h"
#import "PhotoCollectionViewCell.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _photos = [[NSMutableArray alloc] init];
    [self getAllPicture];
    NSLog(@"%@", _photos);
    [_photoCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAllPicture {
    NSLog(@"Started...");
    PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.synchronous = YES;
    PHFetchOptions *allPhotosOptions = [PHFetchOptions new];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];

    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
    for (PHAsset *asset in result) {
//        NSMutableArray *dic = [[NSMutableArray alloc] init];
//        [dic setValue:asset forKey:@"assest"];

        [_photos insertObject:asset atIndex:0];
//        dic = nil;
    }
    NSLog(@"Completed...");
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"카운트 : %lu", (unsigned long)_photos.count);
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"photoCell";
    PhotoCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    PHAsset *asset = _photos[indexPath.row];
    CGImageRef thumbnailImageRef = (__bridge CGImageRef)(asset);
    UIImage *thumbnail = [UIImage imageWithCGImage:thumbnailImageRef];
    cell.photoImageView.image = thumbnail;
    
    NSLog(@"gpgp");
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectImage.backgroundColor = [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectImage.backgroundColor = [UIColor redColor];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
