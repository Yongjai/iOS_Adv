//
//  ViewController.m
//  Week6
//
//  Created by YongJai on 03/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"
#import "DataModel.h"
#import "TodayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self calculateDate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calculateDate {
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY/MM/dd"];
    NSString *dateString = [dateFormat stringFromDate:today];
    NSLog(@"%@", dateString);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [formatter dateFromString:dateString];
    NSDate *endDate = [formatter dateFromString:_date];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    NSLog(@"%ld", [components day]);
    _dayLabel.text = [NSString stringWithFormat: @"%ld", [components day]];
    _count = _dayLabel.text;
    
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.kr.week6"];
    
    [sharedDefaults setInteger:[self.dayLabel.text integerValue] forKey:@"MyNumberKey"];
    [sharedDefaults synchronize];
    
}





@end
