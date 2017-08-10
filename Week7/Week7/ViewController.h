//
//  ViewController.h
//  Week7
//
//  Created by YongJai on 10/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *personTableView;
@property NSMutableArray *dataArray;

@end

