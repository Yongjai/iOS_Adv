//
//  SetupViewController.h
//  Week6
//
//  Created by YongJai on 03/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupViewController : UIViewController {
    UIDatePicker *datePicker;
    NSString *date;
}
@property (weak, nonatomic) IBOutlet UITextField *dateSelectionTextField;


@end
