//
//  MineViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MineViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
#import "AppDelegate.h"
#import "MineDetailViewController.h"
#import "MyTravelingViewController.h"
#import "MyCollectViewController.h"
#import "MyHoltelOredrViewController.h"
#import "calendarViewController.h"

#define SEVERICE_IMAGE @"serviceHeardImage"

@interface MineViewController ()
{
    CLLocationManager *locationManager;
}

@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated
{
   
    if (self.tag==1)
    {
        hideTabbar
    }
    else
    {
        appearTabbar
    }
    
    [self.navigationItem setNewTitle:@"我的"];
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int a=[defaults integerForKey:QUSE_ID];
    if (a)
    {
        logView.hidden=YES;
        
        NSLog(@"TYPE_ID %@",[defaults objectForKey:TYPE_ID]);
        NSLog(@"userid %@",GET_USER_DEFAUT(QUSE_ID));
        if ([[defaults objectForKey:TYPE_ID] intValue]==2) {
            _memberCenter_name.hidden=NO;
            memberCenter2.hidden=NO;
            memberCenter3.hidden=YES;
            memberCenter.hidden=YES;
            name_style.text=@"客服";
            name_string.text=[defaults valueForKey:USER_NAME];
         
        }else{
            _memberCenter_name.hidden=NO;
            memberCenter2.hidden=YES;

            switch ([GET_USER_DEFAUT(GUIDE_ID) intValue])
            {
                case 0:{
                    name_style.text=@"普通会员";
                    memberCenter.hidden=NO;
                    memberCenter3.hidden=YES;
                }
                    break;
                case 1:{
                    name_style.text=@"导游会员";
                    memberCenter.hidden=YES;
                    memberCenter3.hidden=NO;
                }
                    break;
                case 2:{
                    name_style.text=@"司兼导(租车)会员";
                    memberCenter.hidden=YES;
                    memberCenter3.hidden=NO;
                }
                    break;
                case 3:{
                    name_style.text=@"导游兼翻译会员";
                    memberCenter.hidden=YES;
                    memberCenter3.hidden=NO;
                }
                    break;
                case 4:{
                    name_style.text=@"导游兼翻译(带车)会员";
                    memberCenter.hidden=YES;
                    memberCenter3.hidden=NO;
                }
                    break;
                default:
                    break;
            }
            name_string.text=[defaults valueForKey:USER_NAME];
        }
        if ([GET_USER_DEFAUT(TYPE_ID) intValue]>0) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSMutableString *UrlStr = RussiaUrl4;
                [UrlStr appendString:@"GetMyorderCount"];
                NSString *argumentStr = [NSString stringWithFormat:@"userid=%@",GET_USER_DEFAUT(QUSE_ID)];
                postRequestTongBu(argumentStr, UrlStr, received)
                dicResultTongbuNoDic(received, result)
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (result.intValue>0) {
                        myNum.text = [NSString stringWithFormat:@"(%@)",result];
                    }else myNum.text=@"";
                });
            });
        }
        NSLog(@"USER_NAME %@",name_string.text);
        NSLog(@"[GET_USER_DEFAUT(name_string.text) length]  %@",GET_USER_DEFAUT(name_string.text) );
        if ([GET_USER_DEFAUT(name_string.text) length]>4) {
           [self loadPic_tableViewIndexPath:nil headLabName:GET_USER_DEFAUT(name_string.text) headView:name_image];
        }else name_image.image= [UIImage imageNamed:@"defaultSmall.gif"];
        
    
    }
    else
    {
        _memberCenter_name.hidden=YES;
        logView.hidden=NO;
        memberCenter.hidden=YES;
        memberCenter2.hidden=YES;
        memberCenter3.hidden=YES;
        name_image.image= [UIImage imageNamed:@"defaultSmall.gif"];
    }
    if ([defaults valueForKey:@"currentArray"]) {
        NSArray*array1=[defaults valueForKey:@"currentArray"];
        NSLog(@"array1=%@",array1);
        if ([[[array1 lastObject]valueForKey:@"Summary"]length]>0)
        {
            
            
            int aa=0;
            for (int i=0; i<array1.count; i++)
            {
                NSString*ID1=[[[array1 objectAtIndex:i]valueForKey:@"ID"]stringValue];
                
                BOOL is=[defaults boolForKey:ID1];
                if (is==NO)
                {
                    aa++;
                }
            }
            
            if (aa==0)
            {
                num.text=@"";
                num2.text=@"";
                
            }
            else
            {
                num.text=[NSString stringWithFormat:@"(%d)",aa];
                num2.text=[NSString stringWithFormat:@"(%d)",aa];
            }
            
        }

    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
   }


- (void)viewDidLoad
{
    [super viewDidLoad];
    
        NSString*canshu2=[NSString stringWithFormat:@"cityid=%d",2];
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getNoticeList";
        [urlDomain appendString:urlMethod];
        postRequestYiBu(canshu2, urlDomain)
        sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    

    sv.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:sv];
    //登录前
    {
        array=[NSMutableArray new];
        logView=[[UIView alloc]init];
        logView.frame=self.view.frame;
        [sv addSubview:logView];
        isLogin=NO;
        
        float logInX=10;
        float logInY=10;
        float height=40;
        textFieldPasscode.delegate=self;
        float width=DeviceWidth;
        UIImageView*logIn=[[UIImageView alloc]initWithFrame:CGRectMake(0, logInY, width, height)];
        logIn.userInteractionEnabled=YES;
        logIn.image=[UIImage imageNamed:@"MyDownCell"];
        [logView addSubview:logIn];
        UIImageView *name = [[UIImageView alloc]initWithFrame:CGRectMake(10, (height-23)/2, 21, 21)];
        name.image = [UIImage imageNamed:@"login_name"];
        [logIn addSubview:name];
        textFieldName=[[UITextField alloc]initWithFrame:CGRectMake(40, 0, 220, 40)];
        textFieldName.delegate=self;
        textFieldName.placeholder=@"用户名/邮箱/手机号码";

        textFieldName.font = [UIFont systemFontOfSize:14];
        [logIn addSubview:textFieldName];
        
        
        UIImageView*passWord=[[UIImageView alloc]initWithFrame:CGRectMake(0, logIn.frame.origin.y+logIn.frame.size.height, width, height)];
        passWord.userInteractionEnabled=YES;
        passWord.image=[UIImage imageNamed:@"MyUpCell"];
        [logView addSubview:passWord];
        UIImageView *password = [[UIImageView alloc]initWithFrame:CGRectMake(10, (height-23)/2, 21, 21)];
        password.image = [UIImage imageNamed:@"password"];
        [passWord addSubview:password];
        textFieldPasscode=[[UITextField alloc]initWithFrame:CGRectMake(40, 0, 220, 40)];
        textFieldPasscode.secureTextEntry = YES;
        textFieldPasscode.delegate=self;
        textFieldPasscode.placeholder=@"6~20位密码";
        textFieldPasscode.font = [UIFont systemFontOfSize:14];
        [passWord addSubview:textFieldPasscode];
        
        UIButton*logButton=[UIButton buttonWithType:UIButtonTypeCustom];
        logButton.frame=CGRectMake(logInX, 100, width-20, 40);
        [logButton setBackgroundImage:[UIImage imageNamed:@"mine_log.png"] forState:UIControlStateNormal];
        [logButton setTitle:@"登录" forState:UIControlStateNormal];
        [logButton addTarget:self action:@selector(logIn:) forControlEvents:UIControlEventTouchUpInside];
        
        [logView addSubview:logButton];
        NSArray*title=[NSArray arrayWithObjects:@"忘记密码?",@"注册新账号", nil];
        for (int i=0; i<2; i++)
        {
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(i*(225)+10, 146, 75, 30);
            //[button setBackgroundImage:[UIImage imageNamed:@"toolButton.png"] forState:UIControlStateNormal];
            button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            button.tag=20+i;
            [button setTitle:[title objectAtIndex:i] forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize: 15.0];
            [button setTitleColor:[UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchUpInside];
            [logView addSubview:button];
        }
        
        UIButton*Button1=[UIButton buttonWithType:UIButtonTypeCustom];
        UILabel*new=[[UILabel alloc]initWithFrame:CGRectMake(40, (height-20)/2, 51, 20)];
        new.text=@"消息";
        new.font = [UIFont systemFontOfSize:15.5];
        UIImageView *news = [[UIImageView alloc]initWithFrame:CGRectMake(10, (height-21)/2, 21, 21)];
        news.image = [UIImage imageNamed:@"news"];
        [Button1 addSubview:news];
        num=[[UILabel alloc]initWithFrame:CGRectMake(250, (height-20)/2, 40, 20)];
        num.textAlignment=NSTextAlignmentCenter;
        num.textColor=[UIColor grayColor];
        num.backgroundColor=[UIColor clearColor];
        num.tag=30;
        [Button1 addSubview:num];
        
        Button1.tag=18;
        new.userInteractionEnabled=YES;
        [Button1 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        
        
        new.textAlignment=NSTextAlignmentLeft;
        [Button1 addSubview:new];
        Button1.frame=CGRectMake(0, 210, width, 40);
        [Button1 setImage:[UIImage imageNamed:@"MyBG"] forState:UIControlStateNormal];
        [Button1 setImage:[UIImage imageNamed:@"mine_newsAndSet_h.png"] forState:UIControlStateHighlighted];
        
        [logView addSubview:Button1];
        
        UIButton*Button2=[UIButton buttonWithType:UIButtonTypeCustom];
        Button2.frame=CGRectMake(0, 268, width, 40);
        UILabel*set=[[UILabel alloc]initWithFrame:CGRectMake(40, (height-20)/2, 51, 20)];
        Button2.tag=19;
        [Button2 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        set.text=@"设置";
        set.font = [UIFont systemFontOfSize:15.5];
        set.textAlignment=NSTextAlignmentLeft;
        [Button2 addSubview:set];
        [Button2 setImage:[UIImage imageNamed:@"mine_newsAndSet.png"] forState:UIControlStateNormal];
        [Button2 setImage:[UIImage imageNamed:@"mine_newsAndSet_h.png"] forState:UIControlStateHighlighted];
        [logView addSubview:Button2];
        UIImageView *set2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, (height-21)/2, 21, 21)];
        set2.image = [UIImage imageNamed:@"set"];
        [Button2 addSubview:set2];
        
        
    }
    array=[NSMutableArray new];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
   // float logInX=5;
    float logInY=10;
    float height=40;
    float width=DeviceWidth;
    
    memberCenter=[[UIView alloc]init];
    memberCenter.frame=CGRectMake(0, 90, 320, self.view.frame.size.height-100);
    [sv addSubview:memberCenter];
    memberCenter.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    
    memberCenter3=[[UIView alloc]init];
    memberCenter3.frame=CGRectMake(0, 90, 320, 600);
    [sv addSubview:memberCenter3];
    memberCenter3.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    _memberCenter_name=[UIButton buttonWithType:UIButtonTypeCustom];
    [_memberCenter_name addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    _memberCenter_name.tag=7;
    _memberCenter_name.frame=CGRectMake(0, logInY, width, 70);
    
    UIImage *image2 = [[UIImage imageNamed:@"MyNameBG"] stretchableImageWithLeftCapWidth:160 topCapHeight:5];
    [_memberCenter_name setImage:image2 forState:UIControlStateNormal];
    [_memberCenter_name setImage:[UIImage imageNamed:@"memeber_headBackground_h.png"] forState:UIControlStateHighlighted];
    [sv addSubview:_memberCenter_name
     ];
    
    
    name_image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
   // name_image.backgroundColor=[UIColor blueColor];
    name_image.image=[UIImage imageNamed:@"defaultSmall.gif"];
    [_memberCenter_name addSubview:name_image];
  
    
    name_string=[[UILabel alloc]initWithFrame:CGRectMake(55, 15, 250, 16)];
    name_string.text=textFieldName.text;
    name_string.font = [UIFont systemFontOfSize:15.5];
    name_string.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
    name_string.userInteractionEnabled=NO;
    [_memberCenter_name addSubview:name_string];
    
    name_style=[[UILabel alloc]initWithFrame:CGRectMake(55, 35, 200, 16)];
    name_style.textColor = [UIColor grayColor];
    name_style.userInteractionEnabled=NO;
    name_style.font = [UIFont systemFontOfSize:14];
    [_memberCenter_name addSubview:name_style];
    //member  1
    {
        
        NSArray *titleArr = @[@"线路订单",@"景点门票订单",@"酒店订单",@"娱乐门票订单",@"导游/租车订单"];
        NSArray *imageNameArr = @[@"user4",@"user5",@"user6",@"user7",@"user8"];
        for (int i=0; i<5; i++) {
            UIButton*orderManagementBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            orderManagementBtn.tag=11+i;
            [orderManagementBtn addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            UILabel*orderManagementLab=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 100, 20)];
            orderManagementLab.text=titleArr[i];
            orderManagementLab.font = [UIFont systemFontOfSize:15.5];
            orderManagementLab.textAlignment=NSTextAlignmentLeft;
            [orderManagementBtn addSubview:orderManagementLab];
            orderManagementBtn.frame=CGRectMake(0, 40*i, width, 40);
            [orderManagementBtn setImage:[UIImage imageNamed:@"member_centerCenter"] forState:UIControlStateNormal];
            [orderManagementBtn setImage:[UIImage imageNamed:@"member_centerCenter_h.png"] forState:UIControlStateHighlighted];
            [memberCenter addSubview:orderManagementBtn];
            
            UIImage *image = [UIImage imageNamed:imageNameArr[i]];
            UIImageView *oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
            oneIV.image = image;
            [orderManagementBtn addSubview:oneIV];
        }

        
        //我的游记
        UIButton*memberCenter_nameButton3=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton3.tag=16;
        [memberCenter_nameButton3 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        UILabel*memberCenter_namenew3=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 100, 20)];
        memberCenter_namenew3.text=@"游记";
        memberCenter_namenew3.font = [UIFont systemFontOfSize:15.5];
        memberCenter_namenew3.textAlignment=NSTextAlignmentLeft;
        [memberCenter_nameButton3 addSubview:memberCenter_namenew3];
        memberCenter_nameButton3.frame=CGRectMake(0, 210, width, 40);
        [memberCenter_nameButton3 setImage:[UIImage imageNamed:@"member_centerCenter"] forState:UIControlStateNormal];
        [memberCenter_nameButton3 setImage:[UIImage imageNamed:@"member_centerCenter_h.png"] forState:UIControlStateHighlighted];
        
        [memberCenter addSubview:memberCenter_nameButton3];
        UIImage *image4 = [UIImage imageNamed:@"travel"];
        UIImageView *fourIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        fourIV.image = image4;
        [memberCenter_nameButton3 addSubview:fourIV];
        //收藏
        UIButton*memberCenter_nameButton4=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton4.tag=17;
        [memberCenter_nameButton4 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        memberCenter_nameButton4.frame=CGRectMake(0, 250, width, 40);
        UILabel*memberCenter_nameset4=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 100, 20)];
        memberCenter_nameset4.text=@"收藏";
        memberCenter_nameset4.font = [UIFont systemFontOfSize:15.5];
        memberCenter_nameset4.textAlignment=NSTextAlignmentLeft;
        [memberCenter_nameButton4 addSubview:memberCenter_nameset4];
        [memberCenter_nameButton4 setImage:[UIImage imageNamed:@"member_centerDown.png"] forState:UIControlStateNormal];
        [memberCenter_nameButton4 setImage:[UIImage imageNamed:@"member_centerDown_h.png"] forState:UIControlStateHighlighted];
        [memberCenter addSubview:memberCenter_nameButton4];
        
        
        UIImage *image5 = [UIImage imageNamed:@"222login_collect"];
        UIImageView *fiveIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        fiveIV.image = image5;
        [memberCenter_nameButton4 addSubview:fiveIV];
        
        
        
        
        
        
        
        //消息
        UIButton*memberCenter_nameButton5=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton5.frame=CGRectMake(0, 300, width, 40);
        
        UILabel*memberCenter_nameset3=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 51, 20)];
        memberCenter_nameButton5.tag=18;
        [memberCenter_nameButton5 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        memberCenter_nameset3.text=@"消息";
        memberCenter_nameset3.font = [UIFont systemFontOfSize:15.5];
        memberCenter_nameset3.textAlignment=NSTextAlignmentLeft;
        [memberCenter_nameButton5 addSubview:memberCenter_nameset3];
        [memberCenter_nameButton5 setImage:[UIImage imageNamed:@"member_centerUp.png"] forState:UIControlStateNormal];
        [memberCenter_nameButton5 setImage:[UIImage imageNamed:@"member_centerUp_h.png"] forState:UIControlStateHighlighted];
        [memberCenter addSubview:memberCenter_nameButton5];
        
        num2=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 40, 20)];
        num2.textAlignment=NSTextAlignmentCenter;
        num2.textColor=[UIColor grayColor];
        num2.backgroundColor=[UIColor clearColor];
        
        [memberCenter_nameButton5 addSubview:num2];
        
        
        UIImage *image6 = [UIImage imageNamed:@"news"];
        UIImageView *sixIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        sixIV.image = image6;
        [memberCenter_nameButton5 addSubview:sixIV];
        //设置
        UIButton*memberCenter_nameButton7=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton7.tag=19;
        [memberCenter_nameButton7 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        UILabel*memberCenter_namenew4=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 51, 20)];
        memberCenter_namenew4.text=@"设置";
        memberCenter_namenew4.font = [UIFont systemFontOfSize:15.5];
        memberCenter_namenew4.textAlignment=NSTextAlignmentLeft;
        [memberCenter_nameButton7 addSubview:memberCenter_namenew4];
        memberCenter_nameButton7.frame=CGRectMake(0, 350, width, 40);
        [memberCenter_nameButton7 setImage:[UIImage imageNamed:@"member_centerUp.png"] forState:UIControlStateNormal];
        [memberCenter_nameButton7 setImage:[UIImage imageNamed:@"member_centerUp_h.png"] forState:UIControlStateHighlighted];
        
        [memberCenter addSubview:memberCenter_nameButton7];
        memberCenter.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        UIImage *image7 = [UIImage imageNamed:@"set"];
        UIImageView *sevenIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        sevenIV.image = image7;
        [memberCenter_nameButton7 addSubview:sevenIV];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:GUIDE_ID]intValue] == 0)
        {
            [sv setContentSize:CGSizeMake(320, 568)];
        }
    }
    //member  3
    {
        
        NSArray *titleArr = @[@"获取我的位置",@"设置可服务日期",@"我的订单",@"线路订单",@"景点门票订单",@"酒店订单",@"娱乐门票订单",@"导游/租车订单"];
        NSArray *imageNameArr = @[@"user1",@"user2",@"user3",@"user4",@"user5",@"user6",@"user7",@"user8"];
        for (int i=0; i<8; i++) {
            UIButton*orderManagementBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            orderManagementBtn.tag=8+i;
            [orderManagementBtn addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            UILabel*orderManagementLab=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 130, 20)];
            orderManagementLab.text=titleArr[i];
            orderManagementLab.tag = 100 + i;
            orderManagementLab.font = [UIFont systemFontOfSize:15.5];
            orderManagementLab.textAlignment=NSTextAlignmentLeft;
            [orderManagementBtn addSubview:orderManagementLab];
            if (i==0|i==1|i==2)
            {
              orderManagementBtn.frame=CGRectMake(0, 50*i, width, 40);
                if (i==2)
                {
                    orderManagementLab.textColor = [UIColor redColor];
                    myNum=[[UILabel alloc]initWithFrame:CGRectMake(260, (height-20)/2, 40, 17)];////270, 10, 15, 17
                    myNum.textAlignment=NSTextAlignmentCenter;
                    myNum.textColor=[UIColor grayColor];
                    myNum.backgroundColor=[UIColor clearColor];
                    myNum.font = [UIFont systemFontOfSize:11];
                    [orderManagementBtn addSubview:myNum];
                }
            }
            else orderManagementBtn.frame=CGRectMake(0, 40*i+30, width, 40);
            
            [orderManagementBtn setImage:[UIImage imageNamed:@"member_centerCenter"] forState:UIControlStateNormal];
            [orderManagementBtn setImage:[UIImage imageNamed:@"member_centerCenter_h.png"] forState:UIControlStateHighlighted];
            [memberCenter3 addSubview:orderManagementBtn];
            
            UIImage *image = [UIImage imageNamed:imageNameArr[i]];
            UIImageView *oneIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
            oneIV.image = image;
            [orderManagementBtn addSubview:oneIV];
            
        }
        
        
        //我的游记
        UIButton*memberCenter_nameButton3=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton3.tag=16;
        [memberCenter_nameButton3 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        UILabel*memberCenter_namenew3=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 100, 20)];
        memberCenter_namenew3.text=@"游记";
        memberCenter_namenew3.font = [UIFont systemFontOfSize:15.5];
        memberCenter_namenew3.textAlignment=NSTextAlignmentLeft;
        [memberCenter_nameButton3 addSubview:memberCenter_namenew3];
        memberCenter_nameButton3.frame=CGRectMake(0, 360, width, 40);
        [memberCenter_nameButton3 setImage:[UIImage imageNamed:@"member_centerCenter"] forState:UIControlStateNormal];
        [memberCenter_nameButton3 setImage:[UIImage imageNamed:@"member_centerCenter_h.png"] forState:UIControlStateHighlighted];
        
        [memberCenter3 addSubview:memberCenter_nameButton3];
        UIImage *image4 = [UIImage imageNamed:@"travel"];
        UIImageView *fourIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        fourIV.image = image4;
        [memberCenter_nameButton3 addSubview:fourIV];
        //收藏
        UIButton*memberCenter_nameButton4=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton4.tag=17;
        [memberCenter_nameButton4 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        memberCenter_nameButton4.frame=CGRectMake(0, 400, width, 40);
        UILabel*memberCenter_nameset4=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 100, 20)];
        memberCenter_nameset4.text=@"收藏";
        memberCenter_nameset4.font = [UIFont systemFontOfSize:15.5];
        memberCenter_nameset4.textAlignment=NSTextAlignmentLeft;
        [memberCenter_nameButton4 addSubview:memberCenter_nameset4];
        [memberCenter_nameButton4 setImage:[UIImage imageNamed:@"member_centerDown.png"] forState:UIControlStateNormal];
        [memberCenter_nameButton4 setImage:[UIImage imageNamed:@"member_centerDown_h.png"] forState:UIControlStateHighlighted];
        [memberCenter3 addSubview:memberCenter_nameButton4];
        
        
        UIImage *image5 = [UIImage imageNamed:@"222login_collect"];
        UIImageView *fiveIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        fiveIV.image = image5;
        [memberCenter_nameButton4 addSubview:fiveIV];
        
        
        
        
        
        
        
        //消息
        UIButton*memberCenter_nameButton5=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton5.frame=CGRectMake(0, 450, width, 40);
        
        UILabel*memberCenter_nameset3=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 51, 20)];
        memberCenter_nameButton5.tag=18;
        [memberCenter_nameButton5 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        memberCenter_nameset3.text=@"消息";
        memberCenter_nameset3.font = [UIFont systemFontOfSize:15.5];
        memberCenter_nameset3.textAlignment=NSTextAlignmentLeft;
        [memberCenter_nameButton5 addSubview:memberCenter_nameset3];
        [memberCenter_nameButton5 setImage:[UIImage imageNamed:@"member_centerUp.png"] forState:UIControlStateNormal];
        [memberCenter_nameButton5 setImage:[UIImage imageNamed:@"member_centerUp_h.png"] forState:UIControlStateHighlighted];
        [memberCenter3 addSubview:memberCenter_nameButton5];
        
        num2=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 40, 20)];
        num2.textAlignment=NSTextAlignmentCenter;
        num2.textColor=[UIColor grayColor];
        num2.backgroundColor=[UIColor clearColor];
        
        [memberCenter_nameButton5 addSubview:num2];
        
        
        UIImage *image6 = [UIImage imageNamed:@"news"];
        UIImageView *sixIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        sixIV.image = image6;
        [memberCenter_nameButton5 addSubview:sixIV];
        //设置
        UIButton*memberCenter_nameButton8=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton8.tag=19;
        [memberCenter_nameButton8 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        UILabel*memberCenter_namenew4=[[UILabel alloc]initWithFrame:CGRectMake(35, (height-20)/2, 51, 20)];
        memberCenter_namenew4.text=@"设置";
        memberCenter_namenew4.font = [UIFont systemFontOfSize:15.5];
        memberCenter_namenew4.textAlignment=NSTextAlignmentLeft;
        [memberCenter_nameButton8 addSubview:memberCenter_namenew4];
        memberCenter_nameButton8.frame=CGRectMake(0, 500, width, 40);
        [memberCenter_nameButton8 setImage:[UIImage imageNamed:@"member_centerUp.png"] forState:UIControlStateNormal];
        [memberCenter_nameButton8 setImage:[UIImage imageNamed:@"member_centerUp_h.png"] forState:UIControlStateHighlighted];
        [memberCenter3 addSubview:memberCenter_nameButton8];
        memberCenter3.backgroundColor=[UIColor groupTableViewBackgroundColor];
        
        UIImage *image7 = [UIImage imageNamed:@"set"];
        UIImageView *sevenIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        sevenIV.image = image7;
        [memberCenter_nameButton8 addSubview:sevenIV];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:GUIDE_ID]intValue] != 0)
        {
            [sv setContentSize:CGSizeMake(320, 718)];
        }

        
    }
    //servic 2
    {
        memberCenter2 = [[UIView alloc]initWithFrame:CGRectMake(0, 90, 320, self.view.frame.size.height-100)];

        //消息
        UIButton*memberCenter_nameButton3=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton3.frame=CGRectMake(0, 0, width, 40);
        UILabel*memberCenter_nameset3=[[UILabel alloc]initWithFrame:CGRectMake(40, (height-20)/2, 51, 20)];
        memberCenter_nameButton3.tag=18;
        memberCenter_nameset3.font = [UIFont systemFontOfSize:15.5];
        [memberCenter_nameButton3 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        memberCenter_nameset3.text=@"消息";
        memberCenter_nameset3.textAlignment=NSTextAlignmentLeft;
        [memberCenter_nameButton3 addSubview:memberCenter_nameset3];
        [memberCenter_nameButton3 setImage:[UIImage imageNamed:@"MyBG"] forState:UIControlStateNormal];
        [memberCenter_nameButton3 setImage:[UIImage imageNamed:@"member_centerUp_h.png"] forState:UIControlStateHighlighted];
        [memberCenter2 addSubview:memberCenter_nameButton3];
        
        num2=[[UILabel alloc]initWithFrame:CGRectMake(250, (height-20)/2, 40, 20)];
        num2.textAlignment=NSTextAlignmentCenter;
        num2.textColor=[UIColor grayColor];
        num2.backgroundColor=[UIColor clearColor];
        
        [memberCenter_nameButton3 addSubview:num2];
        
        
        UIImage *image4 = [UIImage imageNamed:@"news"];
        UIImageView *fourIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        fourIV.image = image4;
        [memberCenter_nameButton3 addSubview:fourIV];
        //设置
        UIButton*memberCenter_nameButton4=[UIButton buttonWithType:UIButtonTypeCustom];
        memberCenter_nameButton4.tag=19;
        [memberCenter_nameButton4 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        UILabel*memberCenter_namenew4=[[UILabel alloc]initWithFrame:CGRectMake(40, (height-20)/2, 51, 20)];
        memberCenter_namenew4.text=@"设置";
        memberCenter_namenew4.textAlignment=NSTextAlignmentLeft;
        memberCenter_namenew4.font = [UIFont systemFontOfSize:15.5];
        [memberCenter_nameButton4 addSubview:memberCenter_namenew4];
        memberCenter_nameButton4.frame=CGRectMake(0, 50, width, 40);
        [memberCenter_nameButton4 setImage:[UIImage imageNamed:@"MyBG"] forState:UIControlStateNormal];
        [memberCenter_nameButton4 setImage:[UIImage imageNamed:@"member_centerUp_h.png"] forState:UIControlStateHighlighted];
        
        [memberCenter2 addSubview:memberCenter_nameButton4];
        
        
        UIImage *image5 = [UIImage imageNamed:@"set"];
        UIImageView *fiveIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
        fiveIV.image = image5;
        [memberCenter_nameButton4 addSubview:fiveIV];
        [sv addSubview:memberCenter2];
    }
    noNetButton=NoNetButton(noNetButton);
    
    Reachability*rea2 =[Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([rea2  currentReachabilityStatus]==NotReachable)
    {
        noNetButton.hidden=NO;
    }
    else
    {
        noNetButton.hidden=YES;
    }
    
    //获取我的位置
    locationManager=[[CLLocationManager alloc]init];
    if ([CLLocationManager locationServicesEnabled]==YES)
    {
        //                NSLog(@"ok");
    }
    else
    {
        //                NSLog(@"创造一个警告框,告诉用户去设置里面开启定位服务");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您好，请先打开位置定位！" delegate:self cancelButtonTitle:@"好的，谢谢" otherButtonTitles: nil];
        [alert show];
    }
    //精确度
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //更新位置的范围
    [locationManager setDistanceFilter:100.f];
    
    locationManager.delegate=self;
 
}
NetChange(noNetButton)
GO_NET
-(void)touch:(UIButton*)sender
{
    NSLog(@"%d",sender.tag);
    switch (sender.tag)
    {
      
        case 7:
        {
            MineDetailViewController*detail=[MineDetailViewController new];
            [self.navigationController pushViewController:detail animated:NO];
            detail.severiceImage=name_image.image;
            detail.pageTitle=@"我的账号";
        }
            break;
        case 8:
        {
            //开始更新范围
            [locationManager startUpdatingLocation];
            
        }
            break;
        case 9:
        {
            //设置客服务日期
            calendarViewController *calender = [[calendarViewController alloc]init];
            [self.navigationController pushViewController:calender animated:NO];
        }
            break;
        case 10:
        {
            //我的订单
//            MineDetailViewController*detail=[MineDetailViewController new];
//            [self.navigationController pushViewController:detail animated:NO];
//            detail.severiceImage=name_image.image;
//            detail.pageTitle=@"我的账号";
        }
            break;
        case 11:
        {
            //线路订单
            MyHoltelOredrViewController* myLineOrderVC = [MyHoltelOredrViewController new];
            [self.navigationController pushViewController:myLineOrderVC animated:YES];
            myLineOrderVC.title = @"线路订单";
        }
            break;
        case 12:
        {
            //景点门票订单
            MyHoltelOredrViewController* myViewOrderVC = [MyHoltelOredrViewController new];
            [self.navigationController pushViewController:myViewOrderVC animated:YES];
            myViewOrderVC.title = @"景点订单";
        }
            break;
        case 13:{
            //酒店订单
            MyHoltelOredrViewController* myHotelOrderVC = [MyHoltelOredrViewController new];
            [self.navigationController pushViewController:myHotelOrderVC animated:YES];
            myHotelOrderVC.title = @"酒店订单";
        }
            break;
        case 14:{
            //娱乐门票订单
            MyHoltelOredrViewController* myTicketOrderVC = [MyHoltelOredrViewController new];
            [self.navigationController pushViewController:myTicketOrderVC animated:YES];
            myTicketOrderVC.title = @"娱乐订单";
        }
            break;
        case 15:{
            //导游/租车订单
            MyHoltelOredrViewController* myGuideOrderVC = [MyHoltelOredrViewController new];
            [self.navigationController pushViewController:myGuideOrderVC animated:YES];
            myGuideOrderVC.title = @"导游/租车订单";
        }
            break;
        case 16:
        {
            //游记
            [self.navigationController pushViewController:[MyTravelingViewController new] animated:YES];            
        }
            break;
        case 17:
        {
            //收藏
            [self.navigationController pushViewController:[MyCollectViewController new] animated:YES];
        }
            break;
        case 18:
        {
            //消息
            NewsViewController*detail=[NewsViewController new];
            [self.navigationController pushViewController:detail animated:YES];
            
            UILabel*lable=(UILabel*)[self.view viewWithTag:30];
            lable.text=@"";
        }
            break;
        case 19:
        {
            //设置
            SetViewController*set=[SetViewController new];
            [self.navigationController pushViewController:set animated:NO];
        }
            break;
   
        default:
            break;
    }
    
    
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location=[locations lastObject];
    
    //位置反编码
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for (CLPlacemark *placemake in placemarks)
         {
             UILabel *label = (UILabel *)[self.view viewWithTag:100];
             label.frame = CGRectMake(35, 0, 260, 40);
             label.font = [UIFont systemFontOfSize:15.5];
             label.text = placemake.name;
             if (placemake.name.length > 16)
             {
                 label.frame = CGRectMake(35, 0, 200, 40);
                 label.font = [UIFont systemFontOfSize:13];
                 label.text = placemake.name;
             }
             if (placemake.name.length >= 30)
             {
                 label.frame = CGRectMake(35, 0, 250, 40);
                 label.font = [UIFont systemFontOfSize:13];
                 label.text = placemake.name;
             }
             label.numberOfLines = 0;
         }
     }];
    [locationManager stopUpdatingLocation];
}


-(void)regist:(UIButton*)sender
{
    
    switch (sender.tag)
    {
        case 20:
        {
            
            
        }
            break;
        case 21:
        {
            ModificViewController*mo=[ModificViewController new];
            mo.tag=self.tag;
            mo.pageTitle=@"注册";
            [self.navigationController pushViewController:mo animated:NO];
            
        }
            break;
            
        default:
            break;
    }
    
    
}
-(void)logIn:(UIButton*)sender
{
    
    [self.navigationItem setNewTitle:@"会员中心"];
    [textFieldPasscode resignFirstResponder];
    [textFieldName resignFirstResponder];
    
    if([textFieldName.text isEqual:@""])
        
    {
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"请输入用户名" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([textFieldPasscode.text isEqual:@""])
    {
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"请输入密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else
    {
        
        
        NSString *argumentStr=[NSString stringWithFormat:@"UserName=%@&PassWord=%@",textFieldName.text,textFieldPasscode.text];
        //NSMutableString*urlDomain=RussiaUrl
        NSMutableString*urlDomain=RussiaUrl;
        NSString *urlMethod=@"UserLogin";
        [urlDomain appendString:urlMethod];
        postRequestYiBu(argumentStr, urlDomain)
        isLogin=YES;
    }
    
    
    
}
postRequestAgency(datas)
- (void)loadPic_tableViewIndexPath:(NSIndexPath*)indexPath headLabName:(NSString*)name headView:(UIImageView *)headView{
    //NSLog(@"picid %@",picID);
    if (name.length>4) {
       // NSLog(@"[[_dataArr objectAtIndex:indexPath.row] objectForKey:Pic]   %@",[[dataArr objectAtIndex:indexPath.row] objectForKey:picID]);
        NSData *pathData = [NSData dataWithContentsOfFile:PathOfFile(name)];
        
        if (pathData.length==0) {
            //[headAiv  startAnimating];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
               picPath = [GET_USER_DEFAUT(TYPE_ID) intValue]==2?@"service":@"Personal";
                NSString *picUrl=[GET_USER_DEFAUT(TYPE_ID) intValue]==2?PicUrl:PicUrlWWW;
                NSString *urlStr = [NSString stringWithFormat:@"%@%@/%@",picUrl,picPath,name];
                NSLog(@"picurl %@",urlStr);
                NSURL *url = [NSURL URLWithString:urlStr];
                NSLog(@"url %@",url);
                NSData *data = [NSData dataWithContentsOfURL:url];
               // NSLog(@"data  %@",data);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data) {
                        
                        [data writeToFile:PathOfFile(name) atomically:YES];
                        
                        headView.image = [UIImage imageWithData:data];
                        [NSThread sleepForTimeInterval:1];
                        NSLog(@"data is yes");
                        
                    }
                    
                });
            });
        }else headView.image = [UIImage imageWithData:pathData];
        
    }//else  return [UIImage imageNamed:@"lack.jpg"];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    dicResultYiBu(datas, result, dic)
    NSLog(@"result=%@",result);
        dataArray=[dic valueForKey:@"ds"];
    //    NSLog(@"dataArray=%@",dataArray);
        if(isLogin==NO)
    {
         if ([[[dataArray lastObject]valueForKey:@"Summary"]length]>0)
         {
         NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
         
         NSMutableArray*weidu=[defaults valueForKey:@"dataArray"];
         NSMutableArray*current=[defaults valueForKey:@"currentArray"];
         
         int a=weidu.count;
         NSLog(@"a=%d",a);
         int b=0;
         
         if (weidu==nil||current==nil)
         {
         
         
         [defaults setObject:dataArray forKey:@"dataArray"];

         [defaults setObject:dataArray forKey:@"currentArray"];
         [defaults synchronize];
         
         
         }
         
         
         else
         {
         
         
         for (int i = 0; i<[dataArray count]; i++)
         {
         NSString*ii=[[[dataArray objectAtIndex:i]valueForKey:@"ID"]stringValue];
         int k=0;
         for (int m=0;m<weidu.count; m++)
         {
         
         NSString*mm=[[[weidu objectAtIndex:m]valueForKey:@"ID"]stringValue];
         if ([mm isEqualToString:ii])
         {
         
         
         k++;

         }

         }
         
         if (k==0)
         {
         [weidu insertObject:[dataArray objectAtIndex:i] atIndex:0];
         [current insertObject:[dataArray objectAtIndex:i] atIndex:0];
         b++;
         }
         k=0;
         }
         
         NSLog(@"b=%d",b);
         if (b)
         {
         
         
         [defaults removeObjectForKey:@"dataArray"];
         [defaults setObject:weidu forKey:@"dataArray"];
         
         [defaults removeObjectForKey:@"currentArray"];
         [defaults setObject:current forKey:@"currentArray"];
         [defaults synchronize];
         
         }
         
         
         }
         
         }
         
       /*  else
         {
             int a=[result intValue];
             NSLog(@"a ==%d",a);

        ID=a;
        if (a==-1)
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"仅限个人用户登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
        else if (a>0)
        {
            
            if (self.tag==1)
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                memberCenter.hidden=NO;
                logView.hidden=YES;
            }
            NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
            [defaults setInteger:a forKey:QUSE_ID];
            
            //返回值为0无此用户，1为个人用户，2为客服，-1为登录失败，-2为用户账号未激活
            [defaults setInteger:[[[result componentsSeparatedByString:@","] lastObject] intValue] forKey:TYPE_ID];
            
            [defaults setObject:textFieldName.text forKey:USER_NAME];
            NSLog(@"name--%@",[defaults objectForKey:USER_NAME]);
            NSLog(@"QUSE_ID------------%@",[defaults objectForKey:QUSE_ID]);
            NSLog(@"TYPE_ID--%@",[defaults objectForKey:TYPE_ID]);
            [defaults synchronize];
            if ([[defaults objectForKey:TYPE_ID] intValue]==2) {
                name_style.text=@"客服";
                name_string.text=[defaults valueForKey:USER_NAME];

            }else{
                NSString *str=[NSString stringWithFormat:@"uid=%d",a];//设置
                NSMutableString*urlDomain=RussiaUrl
                NSString*urlMethod=@"getUserInfo";
                [urlDomain appendString:urlMethod];
                postRequestTongBu(str, urlDomain, received)
                dicResultTongbu(received, result, dic2)
                

                NSDictionary*dic4=[[dic2 valueForKey:@"ds"]lastObject];
                //  NSLog(@"dic2 %@",dic2);
                
                
                switch ([[dic4 valueForKey:GUIDE_ID]intValue])
                {
                    case 0:
                        name_style.text=@"普通会员";
                        name_string.text=[dic4 valueForKey:@"UserName"];
                        [defaults setValue:name_style.text forKey:GUIDE_ID];
                        [defaults synchronize];
                        break;
                        //                case 1:
                        //                    name_style.text=@"导游认证";
                        //                    name_string.text=[dic4 valueForKey:@"UserName"];
                        //                    [defaults setValue:name_style.text forKey:@"IsGuide"];
                        //                    [defaults synchronize];
                        //                    break;
                    case 1:
                        name_style.text=@"代理商";
                        name_string.text=[dic4 valueForKey:@"UserName"];
                        [defaults setValue:name_style.text forKey:GUIDE_ID];
                        [defaults synchronize];
                        break;
                    case 2:
                        name_style.text=@"翻译认证";
                        name_string.text=[dic4 valueForKey:@"UserName"];
                        [defaults setValue:name_style.text forKey:GUIDE_ID];
                        [defaults synchronize];
                        break;
                    case 3:
                        name_style.text=@"导游兼翻译认证";
                        name_string.text=[dic4 valueForKey:@"UserName"];
                        [defaults setValue:name_style.text forKey:GUIDE_ID];
                        [defaults synchronize];
                        break;
                        
                    default:
                        break;
                        
                }
            }
            
            
            
            
        }
        else if ([[e stringValue]intValue]==-2)
        {
            
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"账号未激活" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
        
        else
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"您输入的用户或密码不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
         }*/
        
    }else {
        int a=[result intValue];


        if (a==0) {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"登陆失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
        [defaults setInteger:[result intValue] forKey:QUSE_ID];
        
        //返回值为0无此用户，1为个人用户，2为客服，-1为登录失败，-2为用户账号未激活
        NSArray *useArr = [result componentsSeparatedByString:@","];
        NSLog(@"useARR %@",useArr);
        [defaults setInteger:[useArr[2] intValue] forKey:TYPE_ID];
        
        [defaults setObject:useArr[1] forKey:USER_NAME];

        [defaults setObject:useArr[3] forKey:GUIDE_ID];
        NSLog(@"name--%@",[defaults objectForKey:USER_NAME]);
        NSLog(@"QUSE_ID------------%@",[defaults objectForKey:QUSE_ID]);
        NSLog(@"TYPE_ID--%@",[defaults objectForKey:TYPE_ID]);
        [defaults synchronize];

        logView.hidden=YES;
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] numberGo];
        NSLog(@"useArr.count %d",useArr.count);
        NSLog(@"%@",name_string.text);
        if ([[useArr lastObject] length]>4) {
            SET_USER_DEFAUT([useArr lastObject],name_string.text);
            NSLog(@"%@ %@",name_string.text,GET_USER_DEFAUT(name_string.text));
        [defaults synchronize];
            [self loadPic_tableViewIndexPath:nil headLabName:[useArr lastObject] headView:name_image];
        }
        if ([[defaults objectForKey:TYPE_ID] intValue]==2) {
            _memberCenter_name.hidden=NO;
            memberCenter2.hidden=NO;
            memberCenter.hidden=YES;
            name_style.text=@"客服";
            name_string.text=[defaults valueForKey:USER_NAME];
            
   

        }else{
            //result=104,Cocochen,1,1,201405130844197850.jpg
            _memberCenter_name.hidden=NO;
            memberCenter2.hidden=YES;
            memberCenter.hidden=NO;
            name_string.text=[defaults valueForKey:USER_NAME];
            //name_style.text=@"普通会员";
            //name_image.image=nil;
            switch ([[defaults valueForKey:GUIDE_ID]intValue])
            {
                case 0:
                    name_style.text=@"普通会员";
                    memberCenter.hidden=NO;
                    memberCenter3.hidden=YES;
                    [sv setContentSize:CGSizeMake(320, 568)];
                    break;
                case 1:
                    name_style.text=@"导游会员";
                    memberCenter.hidden=YES;
                    memberCenter3.hidden=NO;
                    [sv setContentSize:CGSizeMake(320, 718)];
                    break;
                case 2:
                    name_style.text=@"司兼导(租车)会员";
                    memberCenter.hidden=YES;
                    memberCenter3.hidden=NO;
                    [sv setContentSize:CGSizeMake(320, 718)];
                    break;
                case 3:
                    name_style.text=@"导游兼翻译会员";
                    memberCenter.hidden=YES;
                    memberCenter3.hidden=NO;
                    [sv setContentSize:CGSizeMake(320, 718)];
                    break;
                case 4:
                    name_style.text=@"导游兼翻译(带车)会员";
                    memberCenter.hidden=YES;
                    memberCenter3.hidden=NO;
                    [sv setContentSize:CGSizeMake(320, 718)];
                    break;
                    
                default:
                    break;
            }
        }
        
       
        

    }
}
-(void)viewDidAppear:(BOOL)animated
{
    if (self.tag==1)
    {
        UIButton *backbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 37.0/1.5/1.2, 28.0/1.2)] ;[backbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIImage *imgSelected = [UIImage imageNamed:@"back.png"];[backbutton setBackgroundImage:[imgSelected stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backbutton] ;self.navigationItem.leftBarButtonItem =backItem;
    }
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
