//
//  CalendarViewController.m
//  Week2
//
//  Created by YongJai on 06/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "CalendarViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface CalendarViewController (){
    NSUInteger dayNum;
    NSUInteger weekday;
    NSUInteger month;
    NSUInteger year;
}
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self prevButton];
    [self nextButton];
    [self presentFirstCalendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createCalendar {
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:month];
    [components setYear:year];
    NSDate * newDate = [calendar dateFromComponents:components];
    NSDateComponents *newComponents = [gregorian components:NSCalendarUnitWeekday fromDate:newDate];
    weekday=[newComponents weekday];
    
    dayNum = [self getCurrentDateInfo:newDate];
    NSUInteger newWeekDay = weekday - 1;
    
    int yVal = 180;
    int count = 1;
    
    UILabel *yearMonth = [[UILabel alloc]initWithFrame:CGRectMake(112, 80, 150, 55)];
    [yearMonth setText:[NSString stringWithFormat:@"%ld년 %ld월", (long)year, (long)month]];
    [yearMonth setTextColor:[UIColor blackColor]];
    yearMonth.textAlignment = NSTextAlignmentCenter;
    yearMonth.tag = 32;
    [self.view addSubview:yearMonth];
    
    UILabel *dayName = [[UILabel alloc]initWithFrame:CGRectMake(0, 165, 375, 55)];
    [dayName setText:[NSString stringWithFormat:@"일      월      화      수      목      금     토"]];
    [dayName setTextColor:[UIColor blackColor]];
    dayName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:dayName];
    
    for (int startDay = 1; startDay <= dayNum; startDay++) {
        UIButton *dayNumBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        
        if (startDay % 2 == 0) {
            dayNumBtn.backgroundColor = [UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1.0];
        }
        
        dayNumBtn.layer.borderWidth = 1.0f;
        dayNumBtn.layer.borderColor = [UIColor blackColor].CGColor;
        
        NSUInteger xCoord = (newWeekDay * 40) + 48;
        NSUInteger yCoord = (count * 40) + yVal;
        newWeekDay++;
        
        if (newWeekDay > 6) {
            newWeekDay = 0;
            count++;
        }
        
        
        dayNumBtn.frame = CGRectMake(xCoord, yCoord, 40, 40);
        [dayNumBtn setTitle:[NSString stringWithFormat:@"%d",startDay]forState:UIControlStateNormal];
        [dayNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        dayNumBtn.tag = startDay;
        
        [self.view addSubview:dayNumBtn];
    }
}

- (void)presentFirstCalendar {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth|NSCalendarUnitYear fromDate:[NSDate date]];
    year = [components year];
    month = [components month];
    
    [self createCalendar];
}

- (void)prevButton {
    UIButton *prevBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [prevBtn setFrame:CGRectMake(30, 50, 55, 55)];
    [prevBtn setTitle:@"<< prev" forState:UIControlStateNormal];
    [prevBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [prevBtn addTarget:self action:@selector(prev:) forControlEvents:UIControlEventTouchUpInside];
    prevBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.view addSubview:prevBtn];
}

- (void)nextButton {
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextBtn setFrame:CGRectMake(290, 50, 55, 55)];
    [nextBtn setTitle:@"next >>" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.view addSubview:nextBtn];
}

- (void)next:(id)sender {
    month++;
    [self removeTag];
    [self updateCalNow];
}

- (void)prev:(id)sender {
    month--;
    [self removeTag];
    [self updateCalNow];
}

- (void)updateCalNow {
    if (month > 12) {
        month = 1;
        year++;
    } else if (month < 1) {
        month = 12;
        year--;
    }
    [self createCalendar];
}

- (NSUInteger)getCurrentDateInfo:(NSDate *)myDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:myDate];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

- (void)removeTag {
    int x = 1;
    while (x <= 40) {
        [[self.view viewWithTag:x]removeFromSuperview];
        x++;
    }
}

@end
