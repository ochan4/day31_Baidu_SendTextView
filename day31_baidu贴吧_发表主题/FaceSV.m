//
//  FaceSV.m
//  自定义FaceView
//
//  Created by tarena on 16/5/5.
//  Copyright © 2016年 tarena. All rights reserved.
//
#import "Face.h"
#import "FaceSV.h"
#import "EmojiUtils.h"
#define HistoryPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/historyFaces.arch"]
static NSMutableArray *_historyFaces = nil;
@implementation FaceSV
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (!_historyFaces) {
            NSData *data = [NSData dataWithContentsOfFile:HistoryPath];
            if (data) {
                _historyFaces = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }else{
                _historyFaces = [NSMutableArray array];
            }
        }
        
    }
    return self;
}

-(void)loadFacesWithType:(FaceType)facetype{
    
    switch (facetype) {
        case FaceTypeHistory:
        {
            
            [self loadHistory];
           
            
            //监听表情按钮事件的触发
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(faceNotificationAction:) name:@"FaceNotification" object:nil];
            
            
        }
            break;
            
        case FaceTypeNormal:
            
            [self loadFacesWithPath:[[NSBundle mainBundle]pathForResource:@"default" ofType:@"plist"]];
            break;
        case FaceTypeEmoji:
            [self loadEmoji];
            break;
        case FaceTypeLXH:
              [self loadFacesWithPath:[[NSBundle mainBundle]pathForResource:@"lxh" ofType:@"plist"]];
            break;
    }
    
    
    
}


-(void)faceNotificationAction:(NSNotification *)noti{
    
    //添加监听的目的 就是为了当数组发生改变的时候界面跟着更新
    [self loadHistory];
    
}



-(void)loadHistory{
    
    //清空原来的图片
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
    
    
    float w = self.bounds.size.width/7;
    float h = self.bounds.size.height/3;
    
    _historyFaces = [[_historyFaces sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        Face *face1 = obj1;
        Face *face2 = obj2;
        if (face1.count<face2.count) {
            return NSOrderedDescending;
        }else return NSOrderedAscending;
    }] mutableCopy];
    
    
    for (int i=0; i<_historyFaces.count; i++) {
        Face *face = _historyFaces[i];
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i%20%7*w+i/20*self.bounds.size.width, i%20/7*w, w, h)];
        
      
            [btn setImage:[UIImage imageNamed:face.name] forState:UIControlStateNormal];
   
            [btn setTitle:face.name forState:UIControlStateNormal];
      
        
        
        btn.titleLabel.font = [UIFont systemFontOfSize:32];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(faceAction:) forControlEvents:UIControlEventTouchUpInside];
        //        21
        //添加删除按钮
        if (i%20==0) {
            UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(6*w+i/20*self.bounds.size.width, 2*h, w, h)];
            [delBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
            [self addSubview:delBtn];
            
        }
        
    }
    long page = _historyFaces.count%20==0?_historyFaces.count/20:_historyFaces.count/20+1;
    self.contentSize = CGSizeMake(page * 375, 0);
    self.pagingEnabled = YES;
    
    
}

-(void)loadEmoji{
    NSArray *faces = [EmojiUtils defaultEmoticons];
    
    float w = self.bounds.size.width/7;
    float h = self.bounds.size.height/3;

    for (int i=0; i<faces.count; i++) {
        NSString *title = faces[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i%20%7*w+i/20*self.bounds.size.width, i%20/7*w, w, h)];
        
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:32];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(faceAction:) forControlEvents:UIControlEventTouchUpInside];
        //        21
        //添加删除按钮
        if (i%20==0) {
            UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(6*w+i/20*self.bounds.size.width, 2*h, w, h)];
            [delBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
            [self addSubview:delBtn];
            
        }
        
    }
    long page = faces.count%20==0?faces.count/20:faces.count/20+1;
    self.contentSize = CGSizeMake(page * 375, 0);
    self.pagingEnabled = YES;
    
    
}

-(void)loadFacesWithPath:(NSString *)path{
    
  
    
    NSArray *faceArr = [NSArray arrayWithContentsOfFile:path];
    
    float w = self.bounds.size.width/7;
    float h = self.bounds.size.height/3;
    
    for (int i=0; i<faceArr.count; i++) {
        NSDictionary *faceDic = faceArr[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i%20%7*w+i/20*self.bounds.size.width, i%20/7*w, w, h)];
        
        [btn setImage:[UIImage imageNamed:faceDic[@"png"]] forState:UIControlStateNormal];
       
        
        [btn setTitle:faceDic[@"png"] forState:UIControlStateNormal];
        
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(faceAction:) forControlEvents:UIControlEventTouchUpInside];
        
//        21
        //添加删除按钮
        if (i%20==0) {
            UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(6*w+i/20*self.bounds.size.width, 2*h, w, h)];
            [delBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
            [self addSubview:delBtn];
            
        }
    }
    
    long page = faceArr.count%20==0?faceArr.count/20:faceArr.count/20+1;
    self.contentSize = CGSizeMake(page * 375, 0);
    self.pagingEnabled = YES;
}

-(void)faceAction:(UIButton *)btn{
    
//   名称 次数
    NSString *imageName = [btn titleForState:UIControlStateNormal];
    NSLog(@"%@",imageName);
    
    
    [self saveFaceWithName:imageName];
    
    
    //把内存中的数组保存到文件中
     NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_historyFaces];
    [data writeToFile:HistoryPath atomically:YES];
   
    
    
    //把点击表情按钮的事件广播 出去 并且把表情图片的名称也发送出去
    [[NSNotificationCenter defaultCenter]postNotificationName:@"FaceNotification" object:imageName];
    
    
    
}

-(void)saveFaceWithName:(NSString *)name{
   //判断是否有重复表情 有则+1
    for (Face *face in _historyFaces) {
        if ([face.name isEqualToString:name]) {
            face.count++;
            return;
        }
    }
    //没有则创建一个新的表情对象
    Face *face = [Face new];
    face.name = name;
    
    [_historyFaces addObject:face];
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
