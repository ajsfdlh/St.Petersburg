//
//  HuaJuViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "HuaJuViewController.h"

@interface HuaJuViewController ()

@end

@implementation HuaJuViewController
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    sv.backgroundColor=GroupColor;
    [self.view addSubview:sv];
    
//    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
//    lab1.text = @"       圣彼得堡(俄语：Санкт-Петербург)是俄罗斯第二大城市，整个城市由42个岛屿组成，由360多座桥梁连接起来，由于河渠纵横、岛屿错落、风光旖旎，素有“北方威尼斯”之称。美丽的涅瓦河、童话般的欧式风格建筑、各式各样金壁辉煌的宫殿、蓝天白云等等，这一切令人无法不爱上这个城市。";
//    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
//    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"huaju1.jpg"];
    
    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       普希金话剧院（国立普希金模范话剧院）是圣彼得堡欣赏话剧的最佳场所，它于1832年建成。该话剧院的建筑极具特色：剧院有六根巨大的圆柱，正面两侧壁龛里有舞蹈女神缪斯忒尔普西科拉和悲剧女神缪斯墨尔波墨涅的塑像，楣额上是镶在楼冠里的竖琴，再上面是美神和艺术保护神阿波罗的飞辇，剧院墙壁的四周，装饰着用悲剧面具和花环组成的饰带，剧院广场上矗立着叶卡特琳娜二世的全身雕像。\n       此外，圣彼得堡的马林斯基剧院、圣彼得堡青年剧院等也是欣赏俄罗斯话剧的绝佳场所。\n       俄罗斯有名的话剧有：《三姐妹》、《轨道》、《五个黄昏》、《战争与和平》、奥斯特洛夫斯基的《智者千虑，必有一失》和《狼与羊》、高尔基的《小市民》、《狼与羊》等，都是认识和体验博大的俄罗斯文化的绝好作品。";
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
