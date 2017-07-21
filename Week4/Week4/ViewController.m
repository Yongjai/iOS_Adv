//
//  ViewController.m
//  Week4
//
//  Created by YongJai on 20/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"nextSegue"]) {
        NextViewController *nextViewController = [segue destinationViewController];
        
        nextViewController.transitioningDelegate = self;
        nextViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
//    segue.destinationViewController.transitioningDelegate = self;
//    segue.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    ViewController *animator = [[ViewController alloc] init];
    animator.isShow = YES;
    return animator;
}

// 추가하면 dismiss에서 동작을 안 함.
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    ViewController *animator = [[ViewController alloc] init];
//    animator.isShow = NO;
//    return animator;
//}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ViewController *viewControllerA = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    NextViewController *viewControllerB = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = viewControllerB.view;
    UIView *containerView = [transitionContext containerView];
    CGRect initialFrame = [transitionContext initialFrameForViewController:viewControllerA];
    CGRect offscreenRect = CGRectOffset(initialFrame, 0, -[UIScreen mainScreen].bounds.size.height);
    
    if (self.isShow) {
        CGRect viewFrame = CGRectMake(110, 280, 150, 150);

        toView.frame = offscreenRect;
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:1.0
             usingSpringWithDamping:0.5
              initialSpringVelocity:1
                            options:0
                         animations: ^{
                             toView.frame = viewFrame;
                         } completion: ^(BOOL finished) {
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
}

@end
