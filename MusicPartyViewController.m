//
//  MusicPartyViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MusicPartyViewController.h"

@interface MusicPartyViewController ()

@end

@implementation MusicPartyViewController

backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    sv.backgroundColor=GroupColor;
    [self.view addSubview:sv];
    
    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    lab1.text = @"       俄罗斯音乐的历史源远流长，可以追溯到6～9世纪东斯拉夫部落生活时代。俄罗斯最伟大的作曲家柴可夫斯基(1840 - 1893)，他的抒情歌剧《叶甫盖尼·奥涅金》、《黑桃皇后》，芭蕾舞曲《天鹅湖》、《睡美人》和《胡桃夹子》都是俄罗斯音乐艺术史的高峰，为世人所熟知。圣彼得堡作为俄罗斯第二繁荣的大都市，其音乐发展毫不落后。圣彼得堡音乐学院是俄罗斯最早的音乐学院，这里培养了一代又一代杰出的音乐人才。";
    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab1.frame.origin.y+lab1.frame.size.height+20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"music1.jpg"];
    
    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       在圣彼得堡听音乐会，有很多选择。圣彼得堡爱乐管弦乐团是俄罗斯历史最悠久的管弦乐团，成立于1882年，被列为世界最佳五大乐团之一。但是这个乐团经常外出巡演，想看到他们的演出，那就要看缘分了！\n       另外，圣彼得堡著名的“BISQUIT”室内乐团，创作了许多特殊的世界音乐风格，每次表演，都会引起一次“新音乐变革”";
    lab2.frame = CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, lab2.optimumSize.height);
    [sv addSubview:lab2];
    UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab2.frame.origin.y+lab2.frame.size.height+20, 300, 200)];
    iv2.image = [UIImage imageNamed:@"music2.jpg"];
    
    [sv addSubview:iv2];
    
    RTLabel *lab3 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, 0)];
    lab3.text = @"       圣彼得堡马琳斯基歌剧院也常常上演俄罗斯各个时期的经典音乐剧、音乐演出，如《叶甫盖尼·奥涅金》、《黑桃皇后》、《西班牙随想曲》、《巫婆》、《魔湖》等。这些传统而经久不衰的俄罗斯音乐，是俄罗斯人们的精神食粮，也是各地游客最喜爱的节目之一。";
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
