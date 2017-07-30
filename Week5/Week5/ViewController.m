//
//  ViewController.m
//  Week5
//
//  Created by YongJai on 27/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

float X;
float Y;
float screenWidth;
float screenHeight;
float splitHeight = 24.0;
float minimumHeight = 80.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panRecognizer =
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveSplitView:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [_splitView addGestureRecognizer:panRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
}

- (void)moveSplitView:(id)sender {
    [_splitView bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        X = [[sender view] center].x;
        Y = [[sender view] frame].origin.y;
        translatedPoint = CGPointMake(X + translatedPoint.x, Y);
    }
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        CGFloat changeY = [(UIPanGestureRecognizer*)sender locationInView:self.view].y;
        CGFloat finalY = changeY;
        
        if (finalY < minimumHeight) {
            finalY = minimumHeight;
        } else if (finalY > screenHeight - minimumHeight) {
            finalY = screenHeight - minimumHeight;
        }
        _topViewHeightConstraint.constant = finalY;
    }
}



@end
