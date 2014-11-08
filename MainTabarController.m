//
//  MainTabarController.m
//  Russia Online
//
//  Created by 刘 吕琴 on 13-12-19.
//  Copyright (c) 2013年 Jiayi. All rights reserved.
//

#import "NumberView.h"
@interface MainTabarController ()

@end

@implementation MainTabarController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCustomTabBar];
    
    
    
}
- (void)initCustomTabBar
{

    [self.tabBar setHidden:YES];
    self.customizedBar = [[UIView alloc]initWithFrame:CGRectMake(0, DeviceHeight-49,DeviceWidth ,49)];
//    highlightImageNames=[[NSArray alloc]initWithObjects:@"home_h.png",@"tool_h.png",@"neighbo_h.png",@"mine_h.png",@"more_h.png", nil];
//     normalImageNames=[[NSArray alloc]initWithObjects:@"home.png",@"tool.png",@"neighbo.png",@"mine.png",@"more.png", nil];
    
    
    self.tittleArray=[NSArray arrayWithObjects:@"首页",@"工具箱",@"我的",@"更多",nil];
    [self.view addSubview:self.customizedBar];
    highbuttonArray=[NSArray arrayWithObjects:@"_home_11.png",@"tool_11.png",@"mine_11.png",@"more_11.png", nil];
    //用一个for循环生成button

    buttonArray=[NSArray arrayWithObjects:@"home_h_11.png",@"tool_h_11.png",@"mine_h_11.png",@"more_h_11.png", nil];
//    buttonArray=[NSArray arrayWithObjects:@"_home_1.png",@"tool_1.png",@"neighbo_1.png",@"mine_1.png",@"more_1.png", nil];
//    highbuttonArray=[NSArray arrayWithObjects:@"home_h_1.png",@"tool_h_1.png",@"neighbo_h_1.png",@"mine_h_1.png",@"more_h_1.png", nil];
    
    count=4;
    for (int i = 0; i<count; i++)
    {
        
        _tabbarItem=[UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat tabBarItemWidth =(float)320/count;
        //22为图片的宽度
        [_tabbarItem setFrame:CGRectMake(i*tabBarItemWidth, 0, tabBarItemWidth, 49)];
        
        if (i==1) {
            NumberView *NV = [[NumberView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            NV.center = CGPointMake(_tabbarItem.frame.size.width-10, 10);
            if ([NV.numberLabel.text isEqualToString:@"0"])
            {
                NV.hidden = YES;
            }else
            {
                 NV.center = CGPointMake(_tabbarItem.frame.size.width-10, 10);
                NV.hidden = NO;
            }
            
            [_tabbarItem addSubview:NV];
        }

        [_tabbarItem setImage:[UIImage imageNamed:[buttonArray objectAtIndex:i]] forState:UIControlStateNormal];

        if (i==0)
        {
               [_tabbarItem setImage:[UIImage imageNamed:[highbuttonArray objectAtIndex:0]]forState:UIControlStateNormal];
        }
        
        _tabbarItem.showsTouchWhenHighlighted = NO;
      
        
//        UILabel* lable = [[UILabel alloc]init];
//        lable.textAlignment=NSTextAlignmentCenter;
//        lable.frame=CGRectMake(0, 24, tabBarItemWidth, 25);
//        lable.tag=i+300;
//        lable.font = [UIFont fontWithName:@"Microsoft YaHei" size:12.0];
//        lable.font=[UIFont systemFontOfSize:12];
//        lable.textColor = [UIColor grayColor];
//        lable.text=[self.tittleArray objectAtIndex:i];
//        lable.backgroundColor=[UIColor clearColor];
//        
//        UIImage*image=[UIImage imageNamed:[normalImageNames objectAtIndex:i] ];
//        UIImageView*imageView=[[UIImageView alloc]initWithImage:image];
//        imageView.tag=i+200;
//        CGFloat imageScale=image.size.width/image.size.height;
//        imageView.frame=CGRectMake((tabBarItemWidth-20*imageScale)/2,8, 20*imageScale, 20);
//        [_tabbarItem addSubview:imageView];
//        self.customizedBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabBackground.gif"]];
//        if (i==0)
//        {
//            lable.textColor=[UIColor whiteColor];
//            imageView.image=[UIImage imageNamed:[highlightImageNames objectAtIndex:i]];
//            _tabbarItem.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabBackground_h.gif"]];
//            //
//            
//        }
//        [_tabbarItem addSubview:lable];
        
        //设置tag值用于过后与selectedindex同步匹配
        _tabbarItem.tag =i+700;
        
        //添加点击事件
        [_tabbarItem addTarget:self action:@selector(tabbarItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.customizedBar addSubview:_tabbarItem];
    }
    
    [self.customizedBar setHidden:NO];
    
}



-(void)tabbarItemDidClick:(UIButton*)tabbarItem
{
    
    
    
    
    UIButton*button=(UIButton*)tabbarItem;
    [button setImage:[UIImage imageNamed:[highbuttonArray objectAtIndex:button.tag-700]] forState:UIControlStateNormal];
//    UILabel*lable=(UILabel*)[self.view viewWithTag:tabbarItem.tag+200];
//    lable.textColor=[UIColor whiteColor];
//    
//    UIImageView*imageView=(UIImageView*)[self.view viewWithTag:tabbarItem.tag+100];
//    imageView.image=[UIImage imageNamed:[highlightImageNames objectAtIndex:tabbarItem.tag-100]];
    
    for (int i=1; i<count; i++)
    {
//        UILabel*lable0=(UILabel*)[self.view viewWithTag:(tabbarItem.tag+i)%count+300];
//        lable0.textColor=[UIColor grayColor];
//        
//        UIImageView*image=(UIImageView*)[self.view viewWithTag:(tabbarItem.tag+i)%count+200];
//        image.image=[UIImage  imageNamed:[normalImageNames objectAtIndex:(tabbarItem.tag+i)%count]];
        UIButton*bu=(UIButton*)[self.view viewWithTag:(tabbarItem.tag+i)%count+700];
      [bu setImage:[UIImage imageNamed:[buttonArray objectAtIndex:bu.tag-700]] forState:UIControlStateNormal];
        
        
        
    }
    
    self.selectedIndex = tabbarItem.tag-700;//控制试图切换的关键语句
    
  
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
