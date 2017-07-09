//
//  SecondViewController.m
//  Week2
//
//  Created by YongJai on 06/07/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "CalendarViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = (int)indexPath.row;
  
    if(row == 0) {
    ThirdViewController *controller = [[ThirdViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    } else if (row == 1) {
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            controller.allowsEditing = NO;
            controller.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType: UIImagePickerControllerSourceTypePhotoLibrary];
            controller.delegate = (id)self;
            [self presentViewController: controller animated: YES completion: nil];
        }
    } else {
        CalendarViewController *controller = [[CalendarViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated: YES completion: nil];
    _imageView.image = [info valueForKey: UIImagePickerControllerOriginalImage];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated: YES completion: nil];
}



@end
