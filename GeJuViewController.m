//
//  GeJuViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "GeJuViewController.h"

@interface GeJuViewController ()

@end

@implementation GeJuViewController

backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    sv.backgroundColor=GroupColor;
    [self.view addSubview:sv];
    
    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    lab1.text = @"       俄罗斯歌剧最初完全效法意大利的格调，有些郁闷悲怆的韵味。格林卡是民族歌剧的奠基人，创作了具有特殊意义的《俄罗斯主题随想曲》和《交响序曲》，这两部作品被认为是歌剧《伊凡·苏萨宁》的“特殊草稿”。1836年11月27日，《伊凡·苏萨宁》在圣彼得堡首演。在沙皇的授意下，改名为《为沙皇献身》，首演获得极大成功。这一天成为俄罗斯民族歌剧的诞生日。";
    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab1.frame.origin.y+lab1.frame.size.height+20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"geju1.jpg"];
    
    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       不管对于圣彼得堡人，还是各地游客，遍布市内的大小剧院是夜生活的中心，听上一场歌剧或看上一场芭蕾舞剧，是一场精神的洗礼。圣彼得堡的马琳斯基剧院拥有世界水准的独立交响乐团。此外，马哈伊尔洛夫斯基剧院、圣彼得堡普希金歌剧院、圣彼得堡音乐学院剧院、音乐与芭蕾舞剧院，都是圣彼得堡首选的听歌剧的场所。       俄罗斯著名的歌剧作品：《包里斯·戈杜诺夫》、里姆斯基·科萨科夫的《普斯科夫的姑娘》和《雪娘》、柴可夫斯基的《黑桃皇后》、普希金的《叶甫盖尼·奥涅金》等，这些闻名世界的歌剧，见证了俄罗斯歌剧的巅峰。";
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
