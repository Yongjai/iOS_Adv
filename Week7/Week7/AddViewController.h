//
//  AddViewController.h
//  Week7
//
//  Created by YongJai on 10/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface AddViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property Person *editSomething;
@property BOOL isEdit;

@end
