//
//  ViewController.m
//  Week10
//
//  Created by YongJai on 31/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NSMutableArray *acctArr;
NSMutableArray *studentNumberArr;
NSMutableString *studentName;

@implementation ViewController

- (void)viewDidLoad {
    [self getStudentName];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedAddBtn:(id)sender {
    NSMutableDictionary *keychainItem = [NSMutableDictionary dictionary];
    
    NSString *studentName = self.nameTextField.text;
    NSString *number = self.numberTextField.text;
    
    
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassInternetPassword;
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked;
    keychainItem[(__bridge id)kSecAttrAccount] = studentName;
    
    if(SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, NULL) == noErr)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"이미 존재합니다."
                                     message:@""
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        
    }else
    {
        keychainItem[(__bridge id)kSecValueData] = [number dataUsingEncoding:NSUTF8StringEncoding];
        
        OSStatus sts = SecItemAdd((__bridge CFDictionaryRef)keychainItem, NULL);
        NSLog(@"Error Code: %d", (int)sts);
    }
    NSLog(@"%@", keychainItem);
    [self getStudentName];
    [_tableView reloadData];
}


- (void) getStudentName {
    studentName = [[NSMutableString alloc] init];
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  (__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnAttributes,
                                  (__bridge id)kSecMatchLimitAll, (__bridge id)kSecMatchLimit,
                                  nil];
    
    NSArray *secItemClasses = [NSArray arrayWithObjects:
                               (__bridge id)kSecClassGenericPassword,
                               (__bridge id)kSecClassInternetPassword,
                               (__bridge id)kSecClassCertificate,
                               (__bridge id)kSecClassKey,
                               (__bridge id)kSecClassIdentity,
                               nil];
    
    NSMutableArray *resultArr;
    for (id secItemClass in secItemClasses) {
        [query setObject:secItemClass forKey:(__bridge id)kSecClass];
        CFTypeRef result = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        
        NSLog(@"%@", (__bridge id)result);
        if (result != NULL) {
            resultArr = [NSArray arrayWithObject:(__bridge id)result];
            CFRelease(result);
        }
    }
    NSMutableArray *extractedArr = [resultArr valueForKey:@"acct"];
    acctArr = extractedArr[0];
}

- (void) getStudentNumber {
    NSMutableDictionary *keychainItem = [NSMutableDictionary dictionary];
    
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassInternetPassword;
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked;
    keychainItem[(__bridge id)kSecAttrAccount] = studentName;
    
    keychainItem[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;
    keychainItem[(__bridge id)kSecReturnAttributes] = (__bridge id)kCFBooleanTrue;
    
    CFDictionaryRef result = nil;
    
    OSStatus sts = SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, (CFTypeRef *)&result);
    
    NSLog(@"Error Code: %d", (int)sts);
    
    NSDictionary *resultDict = (__bridge_transfer NSDictionary *)result;
    NSData *pswd = resultDict[(__bridge id)kSecValueData];
    NSString *number = [[NSString alloc] initWithData:pswd encoding:NSUTF8StringEncoding];
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"선택한 학생의 번호"
                                 message:number
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}


- (IBAction)clickedGetBtn:(id)sender {
    [self getStudentName];
    [_tableView reloadData];
}


- (IBAction)clickedDeleteBtn:(id)sender {
    NSMutableDictionary *keychainItem = [NSMutableDictionary dictionary];
    
    NSString *studentName = self.deleteTargetTextField.text;
    
    
    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassInternetPassword;
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked;
    keychainItem[(__bridge id)kSecAttrAccount] = studentName;
    
    if(SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, NULL) == noErr)
    {
        OSStatus sts = SecItemDelete((__bridge CFDictionaryRef)keychainItem);
        NSLog(@"Error Code: %d", (int)sts);
    }else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"불러올 데이터가 없음"
                                     message:@""
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }
    [self getStudentName];
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [acctArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"학생 이름";
    cell.detailTextLabel.text = [acctArr  objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    studentName = [acctArr objectAtIndex:indexPath.row];
    [self getStudentNumber];
}




@end


