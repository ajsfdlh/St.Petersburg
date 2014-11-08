//
//  HomeViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated
{

 
    appearTabbar
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
    
}

 -(void)netChange:(NSNotification*)sender
{
    Reachability*reach=[sender object];
    if ([reach currentReachabilityStatus]==NotReachable)
    {
        [self.navigationItem setNewTitle:@"(未连接)玩转圣彼得堡"];
       
    }
    else
    {
        [self.navigationItem setNewTitle:@"玩转圣彼得堡"];


       
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   
    
    UIImageView*imageView=[UIImageView new];
    if (DeviceHeight==568)
    {
        imageView.frame=CGRectMake(6, 6, 308, 213);
         imageView.image=[UIImage imageNamed:@"homePic_1.jpg"];
    }
    else
    {
        imageView.frame=CGRectMake(6, 6, 308, 125);
        imageView.image=[UIImage imageNamed:@"homePic_2.jpg"];
    }
       [self.view addSubview:imageView];
    
    
    NSArray*homePic=[NSArray arrayWithObjects:@"homePic_introduce",@"homePic_information",@"homePic_travelNotes", nil];
    for (int i=0; i<3; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(6+(99+5.5)*i, imageView.frame.origin.y+imageView.frame.size.height+6, 99, 67);
        [button setImage:[UIImage imageNamed:[homePic objectAtIndex:i]] forState:UIControlStateNormal];
        button.tag=1000+i;
        [button addTarget:self action:@selector(touche:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

        

        
    }
    
    float buttomFram=72.5;
    NSArray*image=[NSArray arrayWithObjects:@"homeLine.png",@"homeScenery.png",@"homeSleep.png",@"homeFood.png",@"homeShop.png",@"homeFun.png",@"homeGuide.png",@"homeTaxi.png", nil];
    for (int i=0; i<8; i++)
    {
        
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(6+(buttomFram+6)*(i%4), imageView.frame.origin.y+imageView.frame.size.height+6+67+6+(i/4)*(buttomFram+6), buttomFram, buttomFram);

        [button setImage:[UIImage imageNamed:[image objectAtIndex:i]] forState:UIControlStateNormal];
        // [button setBackgroundImage:[UIImage imageNamed:@"homePic_button_h.gif"] forState:UIControlStateHighlighted];
        button.tag=1100+i;
        [button addTarget:self action:@selector(touche:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        
        
        
    }
    
   
    
    noNetButton=NoNetButton(noNetButton);

   
//   -(void)refreshing

}
GO_NET
-(void)touche:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 1000:
        {
            IntroduceViewController*tab=[IntroduceViewController new];
//            tab.tag=@"资讯";
            tab.navibarName=@"圣彼得堡介绍";
            tab.tittleArray=[NSArray arrayWithObjects:@"简介", @"历史",@"建筑",@"出游时间",nil];
            tab.imageArray=[NSArray arrayWithObjects:@"home_introduce.png", @"home_ history.png",@"home_build.png",@"home_time.png",nil];
            [self.navigationController pushViewController:tab animated:NO];
            
        }
            break;
        case 1001:
        {
            TabViewViewController*tab=[TabViewViewController new];
            tab.tag=@"资讯";
            tab.pageName=@"资讯列表";
            [self.navigationController pushViewController:tab animated:NO];
        
        }
            break;
        case 1002:
        {
            TabViewViewController*tab=[TabViewViewController new];
            tab.tag=@"游记";
             tab.pageName=@"游记列表";
            [self.navigationController pushViewController:tab animated:NO];
            
        }
            break;
        case 1100:
        {
            LineViewController*line=[LineViewController new];

            [self.navigationController pushViewController:line animated:NO];
            
        }
            break;
        case 1101:
        {
            EntertainListViewController*line=[EntertainListViewController new];
            line.navName=@"景点列表";
            line.typeId=5;
            [self.navigationController pushViewController:line animated:NO];
            
        }
            break;

            
        case 1102:
        {
            EntertainListViewController*line=[EntertainListViewController new];
            line.navName=@"圣彼得堡住宿";
            line.typeId=1;
            [self.navigationController pushViewController:line animated:NO];
            
        }
            break;
        case 1103:
        {
            EntertainListViewController*line=[EntertainListViewController new];
            line.navName=@"圣彼得堡餐厅";
            line.typeId=3;
            [self.navigationController pushViewController:line animated:NO];
            
        }
            break;
        case 1104:
        {
            EntertainListViewController*line=[EntertainListViewController new];
            line.navName=@"圣彼得堡购物";
            line.typeId=4;
            [self.navigationController pushViewController:line animated:NO];
            
        }
            break;

        case 1105:
        {
            EntertainListViewController*line=[EntertainListViewController new];
            line.navName=@"圣彼得堡娱乐";
            line.tag=1;
             line.typeId=2;
            [self.navigationController pushViewController:line animated:NO];
            
        }
            break;
        case 1106:
        {
            EntertainListViewController *gv = [EntertainListViewController new];
            gv.navName=@"圣彼得堡导游";
            [self.navigationController pushViewController:gv animated:NO];
            
        }
            break;
        case 1107:
        {
            EntertainListViewController *gv = [EntertainListViewController new];
            gv.navName=@"圣彼得堡租车";
            [self.navigationController pushViewController:gv animated:NO];
            
        }
            break;


        default:
            break;
    }


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
