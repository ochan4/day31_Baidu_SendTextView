//
//  ViewController.m
//  day31_baidu贴吧_发表主题
//
//  Created by AierChen on 16/5/16.
//  Copyright © 2016年 Canterbury Tale Inc. All rights reserved.
//

#import "ViewController.h"
#import "ITBaiduViewController.h"

@interface ViewController ()<SphereMenuDelegate>
@property (nonatomic, strong)SphereMenu *sphereMenu;//属性

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加发送按钮
    [self addSendButtons];
}

-(void)addSendButtons{
    
    //按钮图片
    UIImage *startImage = [UIImage imageNamed:@"start"];
    UIImage *image1 = [UIImage imageNamed:@"icon-twitter"];
    UIImage *image2 = [UIImage imageNamed:@"icon-email"];
    UIImage *image3 = [UIImage imageNamed:@"icon-facebook"];
    NSArray *imagesArray = @[image1, image2, image3];
    
    //创建sphereMenu对象
    SphereMenu *sphereMenu = [[SphereMenu alloc] initWithStartPoint:CGPointMake(187, 80)
                                                         startImage:startImage
                                                      submenuImages:imagesArray];
    //添加至主页面
    [self.view addSubview:sphereMenu];
    
    //添加协议
    sphereMenu.delegate = self;
    
    //添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [sphereMenu addGestureRecognizer:pan];
    
    self.sphereMenu = sphereMenu;
    
}

//拖动方法：
-(void)panAction:(UIPanGestureRecognizer *)pan{
    
    pan.view.center = [pan locationInView:self.view];
    
    //添加拖动按钮的方法
    [self.sphereMenu shrinkSubmenu];
}

//点击按钮
- (void)sphereDidSelected:(int)index{
    
    NSLog(@"%d",index);
    
    switch (index) {
        case 0:
        {
            
            ITBaiduViewController *vc = [ITBaiduViewController new];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 1:
        {
            NSLog(@"拖动了第二个");
        }
            break;
            
        case 2:
        {
            NSLog(@"拖动了第三个");
        }
            break;
    }
    
}


@end
