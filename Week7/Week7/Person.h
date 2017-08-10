//
//  Person.h
//  Week7
//
//  Created by YongJai on 10/08/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMObject.h"

@interface Person : RLMObject

@property NSString *uuid;
@property NSString *name;
@property NSInteger age;
@property BOOL isMale;

- (void)saved;
- (void)removed;
@end
