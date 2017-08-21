//
//  ViewController.m
//  Week8
//
//  Created by YongJai on 17/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"
#import "ButtonViewController.h"

@interface ViewController ()

@end

@implementation ViewController

bool isServiceTyped;
bool isNameTyped;
ButtonViewController *buttonViewController;

- (IBAction)serviceTypeChanged:(id)sender {
    if (_serviceTypeTextField.text.length > 1) {
        isServiceTyped = YES;
        
        if (isNameTyped)
            _doneBtn.enabled = YES;
    }
}

- (IBAction)displayNameChanged:(id)sender {
    if (_displayNameTextField.text.length > 1) {
        isNameTyped = YES;
        
        if (isServiceTyped)
            _doneBtn.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isServiceTyped = _serviceTypeTextField.text.length > 1 ? YES : NO;
    isNameTyped  = _displayNameTextField.text.length > 1 ? YES : NO;
    _doneBtn.enabled = (isServiceTyped && isNameTyped) ? YES : NO;
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showbuttonView"]) {
        buttonViewController = segue.destinationViewController;
        buttonViewController.serviceType = _serviceTypeTextField.text;
        buttonViewController.displayName = _displayNameTextField.text;
        
        [self createSession];
    }
    NSLog(@"buttonViewController: %@", buttonViewController);
}

- (void)createSession {
    NSLog(@"newSessionContainer service : %@, name: %@", _serviceTypeTextField.text, _displayNameTextField.text);
    SessionContainer *newSessionContainer = [[SessionContainer alloc] initWithDisplayName:_displayNameTextField.text serviceType:_serviceTypeTextField.text];
    buttonViewController.sessionContainer = newSessionContainer;
}

@end
