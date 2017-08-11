//
//  AddViewController.m
//  Week7
//
//  Created by YongJai on 10/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    if(_editSomething){
        self.nameTextField.text = _editSomething.name;
        self.ageTextField.text = [NSString stringWithFormat:@"%ld", (long)_editSomething.age];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedAddBtn:(id)sender {
    Person *personText = [[Person alloc] init];
    personText.name = _nameTextField.text;
    personText.age = [_ageTextField.text intValue];
  
    if (!_isEdit) {
        personText.id = [[NSUUID UUID] UUIDString];
    } else {
        personText.id = _editSomething.id;
    }
    
    [personText saved];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"저장된 데이터 : %@", personText);
}


@end
