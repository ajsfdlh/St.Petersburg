//
//  TextImageViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "TextImageViewController.h"
#define fontSize 15
@interface TextImageViewController ()

@end

@implementation TextImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:self.navName];
    hideTabbar
  
    NSLog(@"%@",self.titleArray);
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    _scrollView.backgroundColor=GroupColor;
    [self.view addSubview:_scrollView];
      a=0;
    
    a=[QYHMeThod creatTextImage:self.titleArray andImageArray:self.imageArray andSuperView:_scrollView andViewHeight:a];
    _scrollView.contentSize=CGSizeMake(320, a+40);
	// Do any additional setup after loading the view.
}
backButton
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
