//
//  FaceSV.h
//  自定义FaceView
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, FaceType) {
    FaceTypeHistory,
    FaceTypeNormal,
    FaceTypeEmoji,
    FaceTypeLXH,
};

@interface FaceSV : UIScrollView


-(void)loadFacesWithType:(FaceType)facetype;
@end
