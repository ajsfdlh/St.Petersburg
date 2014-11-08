//
//  SubwayNewViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-7-17.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SubwayNewViewController.h"

@implementation SubwayNewViewController
backButton
- (void)viewDidLoad{
    hideTabbar
    [self.navigationItem setNewTitle:@"圣彼得堡地铁"];
    UIScrollView *sv2 = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    sv2.delegate = self;
    sv2.minimumZoomScale = 1;
    sv2.maximumZoomScale = 10;
    float scale = self.view.frame.size.height/self.view.frame.size.width;
    NSLog(@"%f",scale);
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2960/8, 3208/8)];
    iv1.image = [UIImage imageNamed:@"tool_subwayLine.gif"];
    [sv2 addSubview:iv1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 2;
    [sv2 addGestureRecognizer:tap];
    sv2.zoomScale=3;
    //[sv2 setContentSize:CGSizeMake(320*4, 347*4)];
    [self.view addSubview:sv2];
}
- (void)tap:(UITapGestureRecognizer *)tap {
    UIScrollView *sv = (UIScrollView *)tap.view;
    
    if (sv.zoomScale >= 4){
        sv.zoomScale = 1;
    }else sv.zoomScale=4;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return [scrollView.subviews firstObject];
}

@end
