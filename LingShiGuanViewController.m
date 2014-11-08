//
//  LingShiGuanViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "LingShiGuanViewController.h"

@interface LingShiGuanViewController ()

@end

@implementation LingShiGuanViewController

backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    hideTabbar
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    sv.backgroundColor=GroupColor;
    [self.view addSubview:sv];
    
    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    lab1.text = @"驻圣彼得堡总领事馆";
    lab1.font = [UIFont boldSystemFontOfSize:20];
    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
    [sv addSubview:lab1];
    
    UIScrollView *sv2 = [[UIScrollView alloc]initWithFrame:CGRectMake(10, lab1.frame.origin.y+lab1.frame.size.height+20, 300, 200)];
    sv2.delegate = self;
    sv2.minimumZoomScale = 1;
    sv2.maximumZoomScale = 5;
    
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 172)];
    iv1.image = [UIImage imageNamed:@"lingshiguan1.jpg"];
    [sv2 addSubview:iv1];
    [sv addSubview:sv2];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 2;
    [sv2 addGestureRecognizer:tap];
    sv2.zoomScale=3;
    [sv2 setContentOffset:CGPointMake(0, 180)];
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, sv2.frame.origin.y+sv2.frame.size.height+20, 300, 0)];
    lab2.text = @"       <b>办公时间</b>：9:00-12:00  15:00-18:00\n       <b>电话</b>：007-812-7137605\n       <b>传真</b>：007-812-7144958\n       <b>邮箱</b>：chinaconsul_sp_ru@mfa.gov.cn\n       <b>地址</b>：俄罗斯圣彼得堡市戈里鲍耶多夫沿河街134号\n       <b>签证办理时间</b>：周一至周五9:00-13:00、14:00-18:00\n       <b>领区</b>：圣彼得堡市、列宁格勒州、普斯科夫州、诺夫哥罗德州、摩尔曼斯克州、阿尔汉格尔斯克州、卡雷利阿共和国\n       <b>交通信息</b>：坐公交车在公园站(Садовая д.77)或者列拉马多夫斯基大街站Лермонтовский проспект д.10)下车";
    lab2.frame = CGRectMake(10, sv2.frame.origin.y+sv2.frame.size.height+20, 300, lab2.optimumSize.height);
    [sv addSubview:lab2];
        [sv setContentSize:CGSizeMake(320, lab2.frame.origin.y+lab2.frame.size.height+30)];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
