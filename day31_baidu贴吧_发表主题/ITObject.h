//
//  ITObject.h
//  day31_baidu贴吧_发表主题
//
//  Created by AierChen on 16/5/16.
//  Copyright © 2016年 Canterbury Tale Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITObject : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,strong)NSArray *imagePathArray;
@property(nonatomic,strong)NSString *audioPathArray;
@end
