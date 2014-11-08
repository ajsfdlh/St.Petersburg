//
//  ImageScrollView.m
//  ScrollViewPropertyDemo
//

//  Created by jack.fan on 13-8-26.
//  Copyright (c) 2013年 fan xiao. All rights reserved.
//

#import "ImageScrollView.h"

@implementation ImageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置scrollView的属性
        self.maximumZoomScale = 2.5;
        self.minimumZoomScale = 1;
        //添加图片
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (DeviceHeight-207.5)/2, 320, 207.5)];
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_imageView];
        
         //设置代理
        self.delegate = self;
        
        
        //添加双击事件
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomInOut:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        
    }
    return self;
}


#pragma mark --------UIScrollViewDelegate---------
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
//      _imageView.frame=CGRectMake(_imageView.frame.origin.x, ((460.0-_imageView.frame.size.height))/2, _imageView.frame.size.width,_imageView.frame.size.height);
    return _imageView;
}

#pragma mark ---------Target Action--------------
-(void)zoomInOut:(UITapGestureRecognizer*)tapGesture
{
    if (self.zoomScale >= 2.5) {
        [self setZoomScale:1 animated:YES];
    }else{
        //获取手势点击的point
        CGPoint point = [tapGesture locationInView:self];
        //放大某个区域
        [self zoomToRect:CGRectMake(point.x - 40, point.y - 40, 80, 80) animated:YES];
    }
}


-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    _imageView.frame=CGRectMake(_imageView.frame.origin.x, ((DeviceHeight-_imageView.frame.size.height))/2, _imageView.frame.size.width,_imageView.frame.size.height);
      AppDelegate *mydelegate=[[UIApplication sharedApplication] delegate];
    mydelegate.isTime=NO;
    NSLog(@"scrollViewDidZoom");
}

- (void)dealloc
{
   
}

@end
