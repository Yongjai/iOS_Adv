//
//  ViewController.m
//  Week12
//
//  Created by YongJai on 14/09/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *birthdayBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedBirthdayBtn:(id)sender {
    NSString *birthdayString = NSLocalizedStringFromTable(@"Birthday", @"Localizable", nil);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthday = [dateFormatter dateFromString: birthdayString];
    
    NSString *dateFormat = NSLocalizedStringFromTable(@"STYLE", @"Localizable", nil);
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:dateFormat];
    NSString *dateString = [format stringFromDate:birthday];
    
    [_birthdayBtn setTitle:dateString forState:UIControlStateNormal];
}

@end
