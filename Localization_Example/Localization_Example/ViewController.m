//
//  ViewController.m
//  Localization_Example
//
//  Created by YongJai on 12/09/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.testLabel setText:NSLocalizedString(@"Test", @"Test")];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
