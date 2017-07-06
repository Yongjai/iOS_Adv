//
//  ViewController.m
//  Week1
//
//  Created by YongJai on 29/06/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//지정된 주소로 request를 async로 보냄
- (void)requestData {
    NSString *urlString = @"http://www.osxdev.org/forum/index.php?threads/ios8-에서-webgl-지원.356/";
    NSURL *url = [NSURL URLWithString:[urlString urlencode]];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSString *dataStrings = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self alertView:dataStrings];
                });
            }] resume];
}


//AlertView를 띄움
//message가 맨 처음에 안띄어지고 에러가 났었음.
//App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file. 이러한 에러...
//info에 들어가서 security설정을 바꿔줌. Allow arbitary Loads를 YES로..
//그랬더니 이젠 잘 동작하는데 안보임...
//로그도 정상적으로 보임...ㅜㅜ
//message가 너무 많아서 안 보였던 것임. 따라서 substring으로 잘라서 보여주면 됨.
- (void)alertView:(NSString *)dataString {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"받았다!!!" message:[dataString substringToIndex:50] preferredStyle:UIAlertControllerStyleAlert];
    NSLog(@"%@", dataString);
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}


//버튼을 누르면 requestData가 실행
- (IBAction)buttonClicked:(id)sender {
    [self requestData];
}


- (IBAction)filterButtonClicked:(id)sender {
    NSString *urlString = @"http://www.osxdev.org/forum/index.php?threads/swift-2-0에서-try-catch로-fatal-error-잡을-수-있나요.382/";
    [urlString filterHangulWord];
}


@end
