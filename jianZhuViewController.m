//
//  jianZhuViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-1.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "jianZhuViewController.h"

@interface jianZhuViewController ()

@end

@implementation jianZhuViewController

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
    
//    RTLabel *lab1 = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
//    lab1.text = @"       圣彼得堡(俄语：Санкт-Петербург)是俄罗斯第二大城市，整个城市由42个岛屿组成，由360多座桥梁连接起来，由于河渠纵横、岛屿错落、风光旖旎，素有“北方威尼斯”之称。美丽的涅瓦河、童话般的欧式风格建筑、各式各样金壁辉煌的宫殿、蓝天白云等等，这一切令人无法不爱上这个城市。";
//    lab1.frame = CGRectMake(10, 20, 300, lab1.optimumSize.height);
//    [sv addSubview:lab1];
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 300, 200)];
    iv1.image = [UIImage imageNamed:@"jianzhu1.jpg"];
    
    [sv addSubview:iv1];
    
    RTLabel *lab2 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, 0)];
    lab2.text = @"       圣彼得堡是世界上最早按照统一风格的规划建造的城市之一，在规划中几乎包括了十八到二十世纪世界各国及俄罗斯所有基本的建筑风格。圣彼得堡的建筑经历了从巴洛克风格到古典主义，再到折中主义和现代派建筑风格的变化。城市至今完好保留着所有这些风格的建筑，不能不让人佩服俄罗斯人对传统的继承和发展。这不仅仅需要设计师、建筑师的智慧和创造，更需要对前人建筑风格的继承和发展，需要对这片土地的挚爱。";
    lab2.frame = CGRectMake(10, iv1.frame.origin.y+iv1.frame.size.height+20, 300, lab2.optimumSize.height);
    [sv addSubview:lab2];
    UIImageView *iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab2.frame.origin.y+lab2.frame.size.height+20, 300, 200)];
    iv2.image = [UIImage imageNamed:@"jianzhu2.jpg"];
    
    [sv addSubview:iv2];
    
    RTLabel *lab3 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, 0)];
    lab3.text = @"       如今，圣彼得堡有1000多个保存完好的名胜古迹，包括548座宫殿、庭院和大型建筑物，32座纪念碑，137座艺术园林，此外还有大量的桥梁、塑像等等。其中，最著名的名胜古迹有彼得保罗要塞、彼得保罗大教堂，以及要塞附近的彼得大帝小舍、海军部岛上的彼得大帝夏花园、华西里耶夫岛上的缅希科夫公爵府、涅瓦河畔的伏罗佐夫大臣府和斯特罗加诺夫大臣府等等。";
    lab3.frame = CGRectMake(10, iv2.frame.origin.y+iv2.frame.size.height+20, 300, lab3.optimumSize.height);
    [sv addSubview:lab3];
    UIImageView *iv3 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab3.frame.origin.y+lab3.frame.size.height+20, 300, 200)];
    iv3.image = [UIImage imageNamed:@"jianzhu3.jpg"];
    
    [sv addSubview:iv3];
    
    RTLabel *lab4 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv3.frame.origin.y+iv3.frame.size.height+20, 300, 0)];
    lab4.text = @"       这些18世纪早期的建筑，具有俄国早期巴洛克式建筑的典型风格。18世纪后期的主要建筑，有斯莫尔尼宫、冬宫、大理石宫等。19世纪初的建筑，有宏伟的喀山大教堂、高达101米的伊萨基耶大教堂等。圣彼得堡郊区著名的景点有堪称“俄罗斯凡尔塞”的沙皇离宫——彼得宫、巴夫洛夫斯克别墅区、皇宫庭苑所在地加特奇纳、皇村等。";
    lab4.frame = CGRectMake(10, iv3.frame.origin.y+iv3.frame.size.height+20, 300, lab4.optimumSize.height);
    [sv addSubview:lab4];
    UIImageView *iv4 = [[UIImageView alloc]initWithFrame:CGRectMake(10, lab4.frame.origin.y+lab4.frame.size.height+20, 300, 200)];
    iv4.image = [UIImage imageNamed:@"jianzhu4.jpg"];
    
    [sv addSubview:iv4];
    RTLabel *lab5 = [[RTLabel alloc]initWithFrame:CGRectMake(10, iv4.frame.origin.y+iv4.frame.size.height+20, 300, 0)];
    lab5.text = @"       现在在世界各大城市的中心见不到一幢现代建筑的，并不多见，有人说，就凭借这一点，圣彼得堡足够称雄于世界古典城市之列。两三百年前的建筑，既追求宏伟气势，又注重雕塑细节，特别是那些镶嵌在每幢建筑上的细节，成了一种特殊语言，诉说着这座城市浪漫典雅的过去。";

    lab5.frame = CGRectMake(10, iv4.frame.origin.y+iv4.frame.size.height+20, 300, lab5.optimumSize.height);
    [sv addSubview:lab5];
    [sv setContentSize:CGSizeMake(320, lab5.frame.origin.y+lab5.frame.size.height+30)];
    

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
