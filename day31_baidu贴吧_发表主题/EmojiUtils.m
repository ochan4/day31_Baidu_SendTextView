//
//  EmojiUtils.m
//  Day2YYText框架
//
//  Created by Ivan on 15/12/25.
//  Copyright © 2015年 Ivan. All rights reserved.
//

#import "EmojiUtils.h"

@implementation EmojiUtils
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);
//获取默认表情数组
+ (NSArray *)defaultEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [array addObject:emoT];
        }
    }
    return array;
}




@end
