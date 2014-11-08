//
//  SynopsisViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SynopsisViewController.h"

@interface SynopsisViewController ()

@end

@implementation SynopsisViewController

backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    sv.backgroundColor=GroupColor;
    [self.view addSubview:sv];
    
    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    lab1.text = @"       圣彼得堡(俄语：Санкт-Петербург)是俄罗斯第二大城市，整个城市由42个岛屿组成，由360多座桥梁连接起来，由于河渠纵横、岛屿错落、风光旖旎，素有“北方威尼斯”之称。美丽的涅瓦河、童话般的欧式风格建筑、各式各样金壁辉煌的宫殿、蓝天白云等等，这一切令人无法不爱上这个城市。";
    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab1.frame.origin.y+lab1.frame.size.height+20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"Synopsis1.jpg"];

    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       圣彼得堡是世界上少数拥有“白夜”的城市。6月底这里有个神奇的 “白昼节”，在这个时段，圣彼得堡每天有23个小时的白昼。白夜时漫步在静静的涅瓦河畔，看着街上的人们无需掌灯，便可在凌晨时分于街上读书看报，着实是一番神奇的景象。事实上，即使是在一天中那唯一的一小时“黑夜”里，太阳也并非真正“落山”，天边还会透出微薄的光亮。除了白昼节以外，这个城市还有个独特的节日“红帆节”，是庆祝中学毕业生的节日，所有的中学毕业生在这一天告别少年，黎明来临之际迎接人生新的阶段。";
    lab2.frame = CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, lab2.optimumSize.height);
    [sv addSubview:lab2];
    UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab2.frame.origin.y+lab2.frame.size.height+20, 300, 200)];
    iv2.image = [UIImage imageNamed:@"Synopsis2.jpg"];

    [sv addSubview:iv2];
    
    RTLabel *lab3 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, 0)];
    lab3.text = @"       俄国沙皇彼得大帝下令创建了这座城市（始建于1703年），这个城市的第一座建筑物是扼守涅瓦河河口的彼得堡罗要塞。叶卡捷琳娜女王、亚历山大一世曾发誓，要把圣彼得堡变成欧洲最美丽的城市，他们从欧洲各国请来了一流的建筑师和工匠，请法国人设计了艺术学院，请英国人设计了巴弗洛夫斯克宫，请意大利人设计了俄罗斯博物馆、埃尔米塔什博物馆、斯莫尔尼教堂和叶卡捷琳娜宫，俄罗斯名匠则设计了喀山教堂和海军部，著名的滴血大教堂则是少有的纯俄罗斯式建筑……因此，圣彼得堡的建筑是举世闻名的，它们风格多样，既保留了传统的俄罗斯文化，又吸收了西欧多个城市的建筑艺术。";
    lab3.frame = CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, lab3.optimumSize.height);
    [sv addSubview:lab3];
    UIImageView *iv3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab3.frame.origin.y+lab3.frame.size.height+20, 300, 200)];
    iv3.image = [UIImage imageNamed:@"Synopsis3.jpg"];

    [sv addSubview:iv3];
    
    RTLabel *lab4 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv3.frame.origin.y+iv3.frame.size.height+20, 300, 0)];
    lab4.text = @"       圣彼得堡是一座文化名城，美术、音乐、芭蕾舞和文学，是这个城市的骄傲。列宾美术学院是世界四大美术学院之一，是无数美术人心里的艺术殿堂；音乐学院与奥地利维也纳的音乐学院齐名；芭蕾舞更是世界首位，著名芭蕾舞剧《天鹅湖》的首秀就在这个城市举行；俄罗斯历史上的许多文学巨匠都与圣彼得堡的名字有着密切的联系，普希金一生中最重要的时光是在这里度过的，陀思妥耶夫斯基的名著《罪与罚》也是在这里完成的。这里还因为拥有众多博物馆，而被称为“博物馆之城”。";
    lab4.frame = CGRectMake(10, iv3.frame.origin.y+iv3.frame.size.height+20, 300, lab4.optimumSize.height);
    [sv addSubview:lab4];
    UIImageView *iv4 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab4.frame.origin.y+lab4.frame.size.height+20, 300, 200)];
    iv4.image = [UIImage imageNamed:@"Synopsis4.jpg"];

    [sv addSubview:iv4];
    RTLabel *lab5 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv4.frame.origin.y+iv4.frame.size.height+20, 300, 0)];
    lab5.text = @"       像素再高的相机、再华丽的辞藻、再努力的描述都不足以形容圣彼得堡的美好。也许只有亲自来到这里，从那些街头即兴起舞的俄罗斯少女柔美身姿里，从那些席地而坐专心看书的男男女女专注的眼神里，从随处可见拍摄婚纱照的幸福小夫妻相拥的身影里……才能知道，为什么那么多人爱着这座城市！\n\n现在跟随俄罗斯旅游中文网<font size=13 color=blue><a href='http://www.Russia-Online.cn'>(www.Russia-Online.cn)</a></font>，一起去“看看”这座城市！";
    lab5.delegate=self;
    lab5.frame = CGRectMake(10, iv4.frame.origin.y+iv4.frame.size.height+20, 300, lab5.optimumSize.height);
    [sv addSubview:lab5];
    [sv setContentSize:CGSizeMake(320, lab5.frame.origin.y+lab5.frame.size.height+30)];

}
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    NSLog(@"rtLabel is clicked,url is %@",url);
    [[UIApplication sharedApplication] openURL:url];
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
