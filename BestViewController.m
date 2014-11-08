//
//  BestViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "BestViewController.h"

@interface BestViewController ()

@end

@implementation BestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    sv.backgroundColor=GroupColor;
    [self.view addSubview:sv];
    
    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    lab1.text = @"       圣彼得堡的最佳旅游时间是每年的6-9月，但一年中的雨水也大都集中在这几个月里，出游要记得带一把雨伞，以备不时之需。随着每年“白夜”的到来，圣彼得堡的6月成了旅游旺季中的旺季，不仅气候适宜，节庆和活动也很多。";
    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab1.frame.origin.y+lab1.frame.size.height+20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"best1.jpg"];
    
    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       圣彼得堡地势较低，海拔仅1.2-2米，属受海洋性影响温和的大陆性气候。全年平均气温5.2℃，年降水量585毫米。夏季温和，最热月是7月，平均气温17.7℃。冬季寒冷，冬季平均气温零下6.5℃，最冷月是1月，平均气温零下8℃，积雪期持续132天。结冰期从11月中旬至来年4月中、下旬。       很少有游客在隆冬时节去圣彼得堡（温度可低至-25℃），但在严寒中的圣彼得堡体验新年，看涅瓦河畔升起的烟花，也不失为一生中难忘的体验。";
    lab2.frame = CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, lab2.optimumSize.height);
    [sv addSubview:lab2];
    
    [sv setContentSize:CGSizeMake(320, lab2.frame.origin.y+lab2.frame.size.height+30)];
    
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
