//
//  FaceView.m
//  自定义FaceView
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "FaceView.h"
#import "FaceSV.h"
@implementation FaceView

-(void)awakeFromNib{
    self.smallSVs = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        FaceSV *sv = [[FaceSV alloc]initWithFrame:CGRectMake(i*375, 0, 375, self.mySV.bounds.size.height)];
        sv.delegate = self;
        sv.tag = i;
        [sv loadFacesWithType:i];
        [self.smallSVs addObject:sv];
     
        
        [self.mySV addSubview:sv];
        
    }
    
    self.mySV.delegate = self;
    self.mySV.contentSize = CGSizeMake(4*375, 0);
    self.mySV.contentOffset = CGPointMake(375, 0);
    self.mySV.pagingEnabled = YES;
    self.mySV.tag = -1;
    
    
    //初始化pageControl
    self.myPC.numberOfPages = 5;
    self.myPC.userInteractionEnabled = NO;
    
    //修改pageControl小圆点  KVC*************************************************
    [self.myPC setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];

    [self.myPC setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
    
    
}



- (IBAction)clicked:(UIButton *)sender {
    
    for (UIButton *btn in self.myBtns) {
        btn.selected = NO;
    }
    
    sender.selected = YES;
    [self.mySV setContentOffset:CGPointMake(sender.tag*375, 0) animated:YES];
    
    
    //更新pageControl
    UIScrollView *smallSV = self.smallSVs[sender.tag];
    self.myPC.numberOfPages = smallSV.contentSize.width/375;
    self.myPC.currentPage = smallSV.contentOffset.x/375;
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag==-1) {//大SV
        int page = scrollView.contentOffset.x/375;
        
        UIButton * btn = self.myBtns[page];
        
        for (UIButton *b in self.myBtns) {
            b.selected = NO;
        }
        
        btn.selected = YES;
        
        //更新pageControl
        UIScrollView *smallSV = self.smallSVs[page];
        self.myPC.numberOfPages = smallSV.contentSize.width/375;
        self.myPC.currentPage = smallSV.contentOffset.x/375;
        
    }else{//小SV
        
        
        self.myPC.currentPage = scrollView.contentOffset.x/375;
        
    }
    
    
    
}


@end
