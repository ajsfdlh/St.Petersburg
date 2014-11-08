//
//  ShipViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "ShipViewController.h"

@interface ShipViewController ()

@end

@implementation ShipViewController

backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    sv.backgroundColor=GroupColor;
    [self.view addSubview:sv];
    
    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    lab1.text = @"       涅瓦河静静地流过圣彼得堡，使得圣彼得堡这个建在芬兰湾三角洲的古老城市显得格外美丽！它缓缓流淌过那成群的古老建筑物，处处荡漾着古代大师们留下的艺术气息和诗人普希金的痕迹。美丽、典雅、深邃！";
    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab1.frame.origin.y+lab1.frame.size.height+20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"ship1.jpg"];
    
    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       来到圣彼得堡，不坐游船从涅瓦河上看看这个迷人的水上之城，那就太遗憾了！河流两岸的冬宫、彼得堡罗要塞、彼得大帝青铜骑士像、伊萨基辅大教堂、瓦西里岛长滩、圣彼得堡大学、列宾美术学院、斯莫尔尼宫、海军总部大厦等等，以及横跨在涅瓦河上的9座风格各异的大桥，停泊在涅瓦河上的阿夫乐尔巡洋舰，都构成了圣彼得堡的无限风光。";
    lab2.frame = CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, lab2.optimumSize.height);
    [sv addSubview:lab2];
    UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab2.frame.origin.y+lab2.frame.size.height+20, 300, 200)];
    iv2.image = [UIImage imageNamed:@"ship2.jpg"];
    
    [sv addSubview:iv2];
    
    RTLabel *lab3 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, 0)];
    lab3.text = @"       涅瓦河上的大小码头近30个，其中很多码头都有民营游船，如大学堤岸码头、冬宫码头、彼得码头、宫殿码头、英格兰码头等，他们大都以彼得宫为中心。";
    lab3.frame = CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, lab3.optimumSize.height);
    [sv addSubview:lab3];
    UIImageView *iv3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab3.frame.origin.y+lab3.frame.size.height+20, 300, 200)];
    iv3.image = [UIImage imageNamed:@"ship3.jpg"];
    
    [sv addSubview:iv3];
    
    RTLabel *lab4 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv3.frame.origin.y+iv3.frame.size.height+20, 300, 0)];
    lab4.text = @"       涅瓦河上的游船除了可以观光，还可欣赏歌舞等俄罗斯传统民俗表演等，这些都是值得游客们稍稍离开两岸的美景，去观看甚至参与的节目。";
    lab4.frame = CGRectMake(10, iv3.frame.origin.y+iv3.frame.size.height+20, 300, lab4.optimumSize.height);
    [sv addSubview:lab4];
        [sv setContentSize:CGSizeMake(320, lab4.frame.origin.y+lab4.frame.size.height+30)];
    
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
