//
//  ViewController.h
//  Week6
//
//  Created by YongJai on 03/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property NSUInteger day;
@property NSUInteger month;
@property NSUInteger year;
@property (weak, nonatomic) NSString *date;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) NSString *count;



@end

