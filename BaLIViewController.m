//
//  BaLIViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "BaLIViewController.h"

@interface BaLIViewController ()

@end

@implementation BaLIViewController

backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    sv.backgroundColor=GroupColor;
    [self.view addSubview:sv];
    
    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    lab1.text = @"       圣彼得堡拥有马琳剧院、俄罗斯芭蕾舞剧院、亚历山大剧院等著名剧院，而在剧院里除了可以看到《天鹅湖》、《睡美人》、《胡桃夹子》，还有《堂吉诃德》、《帕吉蒂》、《沃尔帕吉斯之夜》及芭蕾明星庆典音乐会等经典的剧目，都让现场的观众无不在谢幕时站起来为他们表演欢呼、鼓掌。来圣彼得堡，不看一场芭蕾舞剧，是最大的遗憾。";
    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab1.frame.origin.y+lab1.frame.size.height+20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"bali1.jpg"];
    
    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       圣彼得堡“SPBT”的主跳芭蕾舞演员伊莲娜·科勒斯妮科娃被欧洲众多媒体誉为“国际芭蕾舞皇后”、“俄罗斯第一天鹅”，她在许多次国际芭蕾舞比赛中获奖。界新闻界用不吝啬的词语对伊琳娜进行了评价，称她是“真正的明星”，“真实的奇迹”。由于她表演时间不能确定，想看到她的表演，可以到圣彼得堡俄罗斯芭蕾舞剧院了解每周的演出时间安排表。";
    lab2.frame = CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, lab2.optimumSize.height);
    [sv addSubview:lab2];
   
    [sv setContentSize:CGSizeMake(320, lab2.frame.origin.y+lab2.frame.size.height+30)];
 
 
 
 
 
 
 
 
 
    
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
