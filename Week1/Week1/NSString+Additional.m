//
//  NSString+Additional.m
//  Week1
//
//  Created by YongJai on 29/06/2017.
//  Copyright © 2017 YongJai. All rights reserved.
//

#import "NSString+Additional.h"

@implementation NSString (Additional)

- (NSString *)urlencode {
    NSCharacterSet *charSet = [[NSCharacterSet characterSetWithCharactersInString:@""] invertedSet];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:charSet];
}


- (NSArray *)filterHangulWord {
    NSMutableArray *wordArr;
    NSMutableString *word;
    
    //유니코드로 한글인지 아닌지 검사한다.
    for (int i = 0; i < [self length]; i++) {
        unichar character = [self characterAtIndex:i];
        if (character >= 0xAC00 && character <= 0xD743 ) {
            [word appendString:[NSString stringWithCharacters:&character length:1]];
            continue;
        }
        // 한글 다음에 다른 단어가 나오면 실행.
        if([word isEqualToString:@""] == NO) {
            [wordArr addObject:word];
            NSLog(@"%@", word);
            //단어를 array에 넣었으니 word를 다시 빈 string으로 다시 만들어줌.
            word = [NSMutableString string];
        }
    }
    return wordArr;
}

@end
