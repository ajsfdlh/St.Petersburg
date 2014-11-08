//
//  IntroduceViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-4-18.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "IntroduceViewController.h"
#import "SynopsisViewController.h"
#import "lishiViewController.h"
#import "jianZhuViewController.h"
#import "BestViewController.h"
#import "BaLIViewController.h"
#import "GeJuViewController.h"
#import "HuaJuViewController.h"
#import "MusicPartyViewController.h"
#import "ShipViewController.h"
#import "MaXiViewController.h"
@interface IntroduceViewController ()

@end

@implementation IntroduceViewController

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
    hideTabbar
    [self setTitle:self.navibarName];
    self.view.backgroundColor=GroupColor;
    
    {
        float buttonY=6;
        float buttonX=6;
        //    float buttonImageFram=35;
        //    float buttonImagey=15;
        //    float labley=52;
        //    float fontSize=12;
        float distance=4;
        int count=4;
        float buttomFram=(320-2*buttonX-(count-1)*distance)/4;
        //    NSArray*image=[NSArray arrayWithObjects:@"tool_sign.png",@"tool_traffic.png",@"tool_embassy.png",@"tool_phone.png",@"tool_weather.png",@"tool_money.png",@"tool_time.png",@"tool_advice.png",@"tool_information.png",@"tool_emergency.png",@"tool_question.png", nil];
        //    NSArray*title=[NSArray arrayWithObjects:@"签证",@"交通",@"领事馆",@"常用电话",@"天气",@"货币",@"时间",@"意见反馈",@"在线咨询",@"紧急救援",@"常见问题", nil];
        
        NSMutableArray*buttonImage=[NSMutableArray new];
        for (int i=0; i<10; i++)
        {
            [buttonImage addObject:[NSString stringWithFormat:@"introduce_0%d.png",i+1]];
        }
        
        
        for (int i=0; i<buttonImage.count; i++)
        {
            
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(buttonX+(buttomFram+distance)*(i%count), buttonY+(i/count)*(buttomFram+distance), buttomFram, buttomFram);
            [button setBackgroundImage:[UIImage imageNamed:[buttonImage objectAtIndex:i]] forState:UIControlStateNormal];
            button.tag=1100+i;
            [self.view addSubview:button];
            if (i == 13) {
                NumberView *NV = [[NumberView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
                NV.center = CGPointMake(button.frame.size.width-10, 10);
                if ([NV.numberLabel.text isEqualToString:@"0"]) {
                    NV.hidden = YES;
                }else NV.hidden = NO;
                [button addSubview:NV];
            }
            
            [button addTarget:self action:@selector(tool:) forControlEvents:UIControlEventTouchUpInside];
            
        }
    }
	// Do any additional setup after loading the view.
}
- (void)tool:(UIButton *)btn{
    switch (btn.tag) {
        case 1100:{
            SynopsisViewController *svc = [SynopsisViewController new];
            svc.title = @"简介";
            [self.navigationController pushViewController:svc animated:NO];
            
        }
            break;
        case 1101:{
            lishiViewController *lishi = [[lishiViewController alloc]init];
            lishi.title = @"历史";
            [self.navigationController pushViewController:lishi animated:NO];
        }
            
            break;
        case 1102:{
            jianZhuViewController *jianZhu = [[jianZhuViewController alloc]init];
            jianZhu.title = @"建筑";
            [self.navigationController pushViewController:jianZhu animated:NO];
        }
            
            break;
        case 1103:
        {
            BestViewController *best = [[BestViewController alloc]init];
            best.title = @"最佳出游时间";
            [self.navigationController pushViewController:best animated:NO];
        }
            break;
        case 1104:
        {
            BaLIViewController *blc = [[BaLIViewController alloc]init];
            blc.title = @"芭蕾舞剧";
            [self.navigationController pushViewController:blc animated:NO];
        }
            break;
        case 1105:
        {
            HuaJuViewController *hjvc = [[HuaJuViewController alloc]init];
            hjvc.title = @"话剧";
            [self.navigationController pushViewController:hjvc animated:NO];
        }
            break;
        case 1106:
        {
            GeJuViewController *gjvc = [[GeJuViewController alloc]init];
            gjvc.title = @"歌剧";
            [self.navigationController pushViewController:gjvc animated:NO];
        }
            break;
        case 1107:
        {
            MusicPartyViewController *mpvc = [[MusicPartyViewController alloc]init];
            mpvc.title = @"音乐会";
            [self.navigationController pushViewController:mpvc animated:NO];
        }
            break;
        case 1108:
        {
            ShipViewController *svc = [[ShipViewController alloc]init];
            svc.title = @"游船";
            [self.navigationController pushViewController:svc animated:NO];
        }
            break;
        case 1109:
        {
            MaXiViewController *mxvc = [[MaXiViewController alloc]init];
            mxvc.title = @"大马戏";
            [self.navigationController pushViewController:mxvc animated:NO];
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
