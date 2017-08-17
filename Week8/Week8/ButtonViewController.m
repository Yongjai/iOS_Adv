//
//  ButtonViewController.m
//  Week8
//
//  Created by YongJai on 17/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ButtonViewController.h"
#import "Transcript.h"

@interface ButtonViewController ()
@end

@implementation ButtonViewController
int number;

- (void)viewDidLoad {
    [super viewDidLoad];
    _sessionContainer.delegate = self;
    NSLog(@"------%@----", _sessionContainer);
    NSLog(@"service: %@, name: %@", _serviceType, _displayName);
    self.title = _serviceType;
    number = 0;
    _numberLabel.text = [NSString stringWithFormat:@"%d", number];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)ClickedPlusBtn:(id)sender {
    [self.sessionContainer sendMessage:@"+"];
}

- (IBAction)clickedMinusBtn:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self minusNumber];
    });
}

- (void)minusNumber {
    number--;
    _numberLabel.text = [NSString stringWithFormat:@"%d", number];
}

- (IBAction)connectUser:(id)sender {
    MCBrowserViewController *browserViewController = [[MCBrowserViewController alloc] initWithServiceType:_serviceType session:self.sessionContainer.session];
    
    browserViewController.delegate = self;
    browserViewController.minimumNumberOfPeers = kMCSessionMinimumNumberOfPeers;
    browserViewController.maximumNumberOfPeers = kMCSessionMaximumNumberOfPeers;
    
    [self presentViewController:browserViewController animated:YES completion:nil];
}

- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    return YES;
}

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)receivedTranscript:(Transcript *)transcript {
    if ([transcript.message isEqualToString: @"+"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self insertTranscript:transcript];
        });
    }
}

- (void)insertTranscript:(Transcript *)transcript {
    number++;
    _numberLabel.text = [NSString stringWithFormat:@"%d", number];
}

- (void)updateTranscript:(Transcript *)transcript {
    //nothing
}


@end
