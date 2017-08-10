//
//  ViewController.m
//  Week7
//
//  Created by YongJai on 10/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <Realm/Realm.h>
#import "AddViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    RLMResults<Person*> *personList;
    AddViewController *addViewController;
    RLMRealm *realm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    addViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    addViewController.isEdit = YES;
    personList = [Person allObjects];
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(reloadTableView) name:@"SAVED" object:nil];
    [notiCenter addObserver:self selector:@selector(reloadTableView) name:@"REMOVED" object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reloadTableView {
    [_personTableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [personList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Person *persons = [personList objectAtIndex:indexPath.row];
    cell.textLabel.text = persons.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)persons.age];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Person *persons = [personList objectAtIndex:indexPath.row];
    addViewController.editSomething = persons;
    [self presentViewController:addViewController animated:NO completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Person *persons = [personList objectAtIndex:indexPath.row];
        [_dataArray addObject:persons];
        
        [_personTableView beginUpdates];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [_personTableView deleteRowsAtIndexPaths:_dataArray withRowAnimation:UITableViewRowAnimationRight];
        [_personTableView endUpdates];
        [realm beginWriteTransaction];

        [realm deleteObject:persons];
        [realm commitWriteTransaction];

    }
}



@end
