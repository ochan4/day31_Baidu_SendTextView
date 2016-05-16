//
//  FaceView.h
//  自定义FaceView
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceView : UIView<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *myBtns;
@property (weak, nonatomic) IBOutlet UIPageControl *myPC;
@property (weak, nonatomic) IBOutlet UIScrollView *mySV;
@property (nonatomic, strong)NSMutableArray *smallSVs;
@end
