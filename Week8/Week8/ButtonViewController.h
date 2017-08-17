//
//  ButtonViewController.h
//  Week8
//
//  Created by YongJai on 17/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionContainer.h"

@interface ButtonViewController : UIViewController <MCBrowserViewControllerDelegate, SessionContainerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property NSString *serviceType;
@property NSString *displayName;
@property SessionContainer *sessionContainer;

@end

