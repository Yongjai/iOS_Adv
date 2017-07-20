//
//  ViewController.h
//  Week4
//
//  Created by YongJai on 20/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NextViewController;


@interface ViewController : UITableViewController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property BOOL isShow;

@property NextViewController *nextViewController;

@end

