//
//  ITBaiduViewController.m
//  day31_baidu贴吧_发表主题
//
//  Created by AierChen on 16/5/16.
//  Copyright © 2016年 Canterbury Tale Inc. All rights reserved.
//

#import "ITBaiduViewController.h"
#import "FaceView.h"

@interface ITBaiduViewController ()
@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UITextView *mainTV;

@end

@implementation ITBaiduViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发表主题";
    
    //************************************************//
    //创建右上角按钮
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = editItem;
    //************************************************//
}

- (IBAction)picButton:(UIButton *)sender {
}

- (IBAction)emojiButton:(UIButton *)sender {
    FaceView *fv = [[NSBundle mainBundle]loadNibNamed:@"FaceView" owner:self options:nil][0];
    
    fv.frame = CGRectMake(0, 0, 375, 216);
    
    [self.bigView addSubview:fv];
}

- (IBAction)videoButton:(UIButton *)sender {
}

- (IBAction)crownButton:(UIButton *)sender {
}

- (IBAction)plusButton:(UIButton *)sender {
}


//发送按钮：方法
-(void)editAction:(UIBarButtonItem *)item{
 
}


@end
