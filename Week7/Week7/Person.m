//
//  Person.m
//  Week7
//
//  Created by YongJai on 10/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "Person.h"

@implementation Person {
    RLMRealm *realm;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    
    realm = [RLMRealm defaultRealm];
    
    return self;
}

+ (NSString *)primaryKey {
    return @"id";
}

-(void)saved {
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:self];
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVED" object:nil];
}

- (void)removed:(int)id {
    Person *person = [self getPerson:id];
    [realm deleteObject:person];
}

- (Person *)getPerson:(int)id {
    return [Person objectInRealm:realm forPrimaryKey:@(id)];
}



@end
