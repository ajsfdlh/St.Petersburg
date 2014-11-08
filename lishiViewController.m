//
//  lishiViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "lishiViewController.h"

@interface lishiViewController ()

@end

@implementation lishiViewController

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
    lab1.text = @"       圣彼得堡位于波罗的海芬兰湾东岸，涅瓦河河口，始建于1703年，至今已有300多年的历史，市名源自耶稣的弟子圣徒彼得。1712年，圣彼得堡成为俄国首都。其后200余年，建起了沙皇和贵族们的宫殿，随着战争和工程建设迁移来大量军人、平民和农奴，最终发展成俄罗斯帝国的心脏，俄罗斯的第二大城，以及重要的工业中心和交通枢纽。";
    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab1.frame.origin.y+lab1.frame.size.height+20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"shili1.jpg"];
    
    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       1703年宁尚茨堡战役胜利之后，俄罗斯控制了整个涅瓦河流域，并获得了通向波罗的海的出海口。由于原有的防御设施离海岸太远，为了防备瑞典军队反攻，并为控制波罗的海做准备，彼得一世下令在涅瓦河口的兔子岛上建立一座要塞，即现在著名的彼得堡罗要塞。于1703年5月16日动工修建要塞，这一天后来被定为圣彼得堡建城纪念日。";
    lab2.frame = CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, lab2.optimumSize.height);
    [sv addSubview:lab2];
    UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab2.frame.origin.y+lab2.frame.size.height+20, 300, 200)];
    iv2.image = [UIImage imageNamed:@"lishi2.jpg"];
    
    [sv addSubview:iv2];
    
    RTLabel *lab3 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, 0)];
    lab3.text = @"       1712年俄罗斯将首都从莫斯科迁到这里定都200多年，直到1914年，这一时期一直叫圣彼得堡。1914年第一次世界大战爆发，当时俄罗斯同德国是敌对国，因为圣彼得堡的“堡”字是源自德语发音，当局决定把城市改名叫彼得格勒；1917年，随着阿芙乐尔号巡洋舰的一声炮响，列宁领导的十月革命在这里获得成功，从此开创了一个全新的苏联时代。       1918年3月，首都从这里又迁回莫斯科。1924年列宁逝世后，人们深切怀念这位革命领袖，正如诗人马雅可夫斯基所说：这里每一块石头都记得列宁。为了纪念他，1924年城市改名为列宁格勒，“格勒”在俄语中为城市的意思。直到1992年1月，为了给城市重新命名，圣彼得堡市又举行了一次全名投票。结果，大多数人赞同改回圣彼得堡。";
    lab3.frame = CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, lab3.optimumSize.height);
    [sv addSubview:lab3];

  
    [sv setContentSize:CGSizeMake(320, lab3.frame.origin.y+lab3.frame.size.height+30)];
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
