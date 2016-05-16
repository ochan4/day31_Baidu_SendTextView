//
//  Face.m
//  自定义FaceView
//
//  Created by tarena on 16/5/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Face.h"

@implementation Face
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.count forKey:@"count"];
    
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.count = [aDecoder decodeIntForKey:@"count"];
        
    }
    return self;
}
@end
