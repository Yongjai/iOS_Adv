//
//  ViewController.m
//  Week11
//
//  Created by YongJai on 07/09/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"
#import "DataManager.h"


@interface ViewController () 

@end

@implementation ViewController

NSArray *dataArr;


- (void)viewDidLoad {
    [super viewDidLoad];
    DataManager *dataManager = [[DataManager alloc] init];
    dataArr = [dataManager getDataFromURL];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cell";
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    NSURL *url = [dataArr objectAtIndex:indexPath.row];
    
    // async하게
    // sync일 경우 확실히 느려짐.
    dispatch_queue_t queue = dispatch_queue_create("googleImage", NULL);
        dispatch_async(queue, ^{

            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = img;
            });
        });
    
    return cell;
}

// Cell을 선택할 경우 확대
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}





@end
