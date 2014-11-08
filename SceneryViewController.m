//
//  SceneryViewController.m
//  Sochi
//
//  Created by 刘 吕琴 on 14-1-22.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SceneryViewController.h"
//#define width 320.0
//#define height 40.0
#import "AnswerViewController.h"
@interface SceneryViewController ()

@end

@implementation SceneryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{

hideTabbar
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setNewTitle:self.navibarName];
    self.view.backgroundColor=GroupColor;

    float width=320.0;
    float height=50.0;
    float imageX=10.0;

    float imageFram=26;
    if ([self.navibarName isEqualToString:@"常见问题"])
    {
        imageX=5;
        imageFram=0;
//        distance=0;
    }
    
//    NSArray*array=@[@"圣彼得堡的最佳出游时间",@"圣彼得堡的最佳出游时间是什么时候？",@"圣彼得堡的最佳出游时间是什么时候？",@"圣彼得堡的最佳出游时间是什么时候？",@"圣彼得堡的最佳出游时间是什么时候？",@"圣彼得堡的最佳出游时间是什么时候？"];
    NSInteger count=self.tittleArray.count;
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight-64)];
    [self.view addSubview:view];
    float c=0;
    
       for (int i=0; i<count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0, 0+c, width, height) ;
        button.backgroundColor=GroupColor;
        button.tag=60+i;
        [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 6, 20, 20)];
        UIImage*image=[UIImage imageNamed:@"toolQuestion.png"];
        imageView.image=image;
        [button addSubview:imageView];
        
        UIImageView*next=[[UIImageView alloc]initWithFrame:CGRectMake(290, (height-20)/2, 20, 20)];
        next.image=[UIImage imageNamed:@"cellJianTou.png"];
        [button addSubview:next];
        
        
        RTLabel*lable=[[RTLabel alloc]initWithFrame:CGRectMake(35, 7, 265, height)];
        lable.userInteractionEnabled=NO;
//      lable.font=[UIFont fontWithName:@"Microsoft YaHei" size:12];
        lable.backgroundColor=[UIColor clearColor];
        lable.font=[UIFont systemFontOfSize:16];
        lable.text=[self.tittleArray objectAtIndex:i];
        float labHeigh=lable.optimumSize.height;
        [button addSubview:lable];
        NSLog(@"%f",labHeigh);
        
        UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(10, height-2, 300, 2)];
        link.image=[UIImage imageNamed:@"entainmentLink.png"];
        [button addSubview:link];

        if (labHeigh<20)
        {
            imageView.frame=CGRectMake(15, 15, 20, 20);
            //button.frame=CGRectMake(0, 0+c, width,labHeigh);
            lable.frame=CGRectMake(35, 15, 265, button.frame.size.height);
            //next.frame=CGRectMake(290, (labHeigh-20)/2, 20, 20);
            
        }
        
        c+=button.frame.size.height;
    }
//    view.contentSize=CGSizeMake(320, c);
    
    answerArray=[NSArray arrayWithObjects:@"商务邀请在申请时最多可以填写5个目的城市，旅游邀请在申请时要填写入住宾馆的信息，有那个城市的宾馆订房就可以到那个城市，俄罗斯移民法规没有特别规定不允许去的地方，只要当地有办理落地签，就算合法了。",@"由于俄罗斯是一个处在高纬度的国家，5月到9月的时候是俄罗斯气候最好的时刻，是去旅游的最佳时间。此时的俄罗斯凉爽宜人，最适合前往避暑度假。 当然这个时间是旅游旺季，前往俄罗斯旅游的人很多，旅游景点会出现拥挤，门票价格提升现象，所以要做好心理准备。",@"俄罗斯的纪念品很多，可选购的产品有：油画、紫金手饰、望远镜、木套娃、琥珀制品、水晶制品、孔雀石、俄罗斯军表、瑞士手表、法国香水、意大利皮具以及鱼子酱、巧克力、伏特加酒等。需要注意的是：政府规定，每位游客最多只可携带250克鱼子酱出境，文物类物品禁止出境，另外还有些物品不可出境。",@"不可以！走团队免签，必须有详细的线路、地接社、往返签机票；最重要的一点，得有专业领队。自由行需办理个人旅游签证。", nil];
}
backButton
-(void)touch:(UIButton*)sender
{
//    UIButton*button=(UIButton*)sender;
    
    if ([self.navibarName isEqualToString:@"常见问题"])
    {
          AnswerViewController*text=[AnswerViewController new];
         text.head=[self.tittleArray objectAtIndex:sender.tag-60];
       text.text=[answerArray objectAtIndex:sender.tag-60];
        [self.navigationController pushViewController:text animated:NO];
        

    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
