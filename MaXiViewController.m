//
//  MaXiViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MaXiViewController.h"

@interface MaXiViewController ()

@end

@implementation MaXiViewController

backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    sv.backgroundColor=GroupColor;
    [self.view addSubview:sv];
    
    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    lab1.text = @"       马戏在俄罗斯的表演历史可谓源远流长，从18世纪起，每一位沙皇都有自己专署的皇家马戏表演者，这些表演者以马戏、驯兽为家族事业，世代相传，形成了许多今天仍然活跃在世界马戏表演舞台的著名马戏世家。";
    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab1.frame.origin.y+lab1.frame.size.height+20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"maxi1.jpg"];
    
    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       1877年12月26日在圣彼得堡建成了俄罗斯第一个砖石结构的马戏场——丰坦卡马戏场，也就是现在的圣彼得堡国家大马戏团。目前可容纳2345名观众。建时目标：建一座欧洲最好的马戏表演场。敞开的拱形窗上有缪斯女神的雕像、檐口上有类似剧院里面的装饰等。在这里，在1892年，观众第一次看到哑剧。";
    lab2.frame = CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, lab2.optimumSize.height);
    [sv addSubview:lab2];
    UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab2.frame.origin.y+lab2.frame.size.height+20, 300, 200)];
    iv2.image = [UIImage imageNamed:@"maxi2.jpg"];
    
    [sv addSubview:iv2];
    
    RTLabel *lab3 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, 0)];
    lab3.text = @"       圣彼得堡马戏大师的演出总是能给人们带来欢声笑语，让人们情不自禁的为他们鼓掌喝彩。大型猛兽驯演，如狮、虎、熊、象等都是传统的表演项目，驯养难度非常大、演出异常精彩。滑稽小丑、大跳板和高空飞人也是非常经典演出项目。";
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
