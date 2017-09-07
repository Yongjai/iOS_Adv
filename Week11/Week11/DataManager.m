//
//  DataManager.m
//  Week11
//
//  Created by YongJai on 07/09/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

- (NSArray *)getDataFromURL {
    NSURL *url = [self urlForString:@"http://125.209.194.123/doodle.php"];
    NSData *newData = [self getJsonFromURL:url];
    return [self serializingJSON:newData];
}

- (NSArray *)serializingJSON:(NSData *)data {
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    
    NSArray *rawArr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSString *url;
    for (NSDictionary *item in rawArr) {
        url = [item objectForKey:@"image"];
        [resultArr addObject:[self urlForString:url]];
    }
    
    return resultArr;
}

- (NSData *)getJsonFromURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   
    return data;
}

- (NSURL *)urlForString:(NSString *)urlString {
    return [[NSURL alloc] initWithString:urlString];
}


@end
