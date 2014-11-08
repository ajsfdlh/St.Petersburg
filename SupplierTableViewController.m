//
//  SupplierTableViewController.m
//  St.Petersburg
//
//  Created by li on 14-4-30.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SupplierTableViewController.h"
#import "GDataXMLNode.h"
#include "JSON.h"
#import "CarAndGuideReseverViewController.h"
@interface SupplierTableViewController ()

@end

@implementation SupplierTableViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
backButton
- (void)viewWillAppear:(BOOL)animated{
    
    [self request1];
    
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int f=[defaults integerForKey:@"QuseID"];
    if (f)
    {
        [self request2];
        
    }
    
    
}
- (void)request2{
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int f=[defaults integerForKey:@"QuseID"];
    NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&typeid=%d&classid=%d",_gudieID,f,1,8];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"CheckColloLike";
    [urlDomain appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomain)
    checkLike=YES;
    [self performSelector:@selector(checkLike:) withObject:[NSNumber numberWithInt:f] afterDelay:0.5];
}
- (void)request1{
    NSMutableString *urlStr = RussiaUrl4;
    [urlStr appendString:@"getGuideDetail"];
    NSString *argumentStr = [NSString stringWithFormat:@"ID=%@",_gudieID];
    //    postRequestYiBu(argumentStr, urlStr)
    postRequestTongBu(argumentStr, urlStr, received)
    dicResultTongbu(received, result, dic)
    //NSLog(@"dic==%@",[[[dic objectForKey:@"ds"] lastObject] objectForKey:@"GuideCount"]);
    //NSDictionary *dic3= [[dic objectForKey:@"ds"] lastObject];
    dic2=[[dic objectForKey:@"ds"] lastObject];
    NSLog(@"dic2   %@",dic2);
    _nameLab.text = [NSString stringWithFormat:@"<font size=16 color=red>%@</font>",[dic2 objectForKey:@"UName"]];
    if (_tag==2) {
        _sexLab.text = [NSString stringWithFormat:@"<font size=16 color=gray>导游(</font>%@人<font size=16 color=gray>)翻译(</font>%@人<font size=16 color=gray>)</font>",[dic2 objectForKey:@"GuideCount"],[dic2 objectForKey:@"FanYiCount"]];
        
        _typeLab.text = [NSString stringWithFormat:@"<font size=16 color=gray>年龄 :</font> <font size=16 color=gray>%@</font>",[dic2 objectForKey:@"AgeList"]];
    }else _sexLab.text = [NSString stringWithFormat:@"<font size=16 color=gray>租车(</font><font size=16 color='#006db8'>%@辆</font><font size=16 color=gray>)</font>",[dic2 objectForKey:@"GuideCount"]];
   // _positionLab.text = [NSString stringWithFormat:@" <font size=12>%@</font>",[dic2 objectForKey:@"Country"]];

    
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    footLab = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    if (_tag==2) {
        footLab.text = [NSString stringWithFormat:@"<font size=16 color=black><b>个人介绍\n</b></font><font size=16 color=gray>    %@</font>",[dic2 objectForKey:@"Note"]];
    }else footLab.text = [NSString stringWithFormat:@"<font size=16 color=black><b>导游/翻译团队介绍\n</b></font><font size=16 color=gray>    %@</font>",[dic2 objectForKey:@"Note"]];
    footLab.frame = CGRectMake(10, 20, 300, footLab.optimumSize.height);
    footView.frame = CGRectMake(0, 0, 320, footLab.frame.size.height+40);
    [footView addSubview:footLab];
    myTableView.tableFooterView = footView;
    myTableView.tableHeaderView = headView;
}

-(void)checkLike:(id)f
{
    
    NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&typeid=%d&classid=%d",_gudieID,[f intValue],2,8];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"CheckColloLike";
    [urlDomain appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomain)
    checkCollect=YES;
    
    
    
    
}
postRequestAgency(_datas)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    dicResultYiBu(_datas, result, dic)
    NSLog(@"dic==%@",dic);
    //dic2=[[dic objectForKey:@"ds"] lastObject];
    
    NSLog(@" HotelRUName  %@",[[[dic valueForKey:@"ds"]lastObject]valueForKey:@"HotelRUName"]);
    
    if (isLike==YES||isCollect==YES)
    {
        
        if (isLike==YES)
        {
            if ([result intValue])
            {
                
                if ([result intValue]==-1)
                {
                    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"操作失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    
                }
                else
                {
                    
                    if ([checkLikeNum isEqualToString:@"已经喜欢"])
                    {
                        NSLog(@"checkLikeNum==%@",checkLikeNum);
                        checkLikeNum=@"没有喜欢";
                        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:411];
                        imageView.image=[UIImage imageNamed:@"hotel_ like.png"];
                        //              UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"取消喜欢成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        //              [alertView show];
                        
                        
                        NSLog(@"checkLikeNum==%@",checkLikeNum);
                        
                    }
                    else
                    {
                        NSLog(@"checkLikeNum==%@",checkLikeNum);
                        checkLikeNum=@"已经喜欢";
                        NSLog(@"checkLikeNum==%@",checkLikeNum);
                        UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"喜欢成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                        
                        UIImageView*_imageView=(UIImageView*)[self.view viewWithTag:411];
                        _imageView.image=[UIImage imageNamed:@"hotel_ like_h.png"];
                    }
                    
                }
                
            }
            else
            {
                
                if ([checkLikeNum isEqualToString:@"已经喜欢"])
                {
                    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"操作失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    
                }
                else
                {
                    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"已喜欢过" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                
                
                
            }
            isLike=NO;
        }
        
        
        
        if (isCollect==YES)
        {NSLog(@"isCollect----------");
            if ([result intValue])
            {
                
                if ([result intValue]==-1)
                {
                    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"收藏失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    
                }
                else
                {
                    if ([checkCollectNum isEqualToString:@"已经收藏"])
                    {
                        checkCollectNum=@"没有收藏";
                        
                        UIImageView*_imageView=(UIImageView*)[self.view viewWithTag:412];
                        _imageView.image=[UIImage imageNamed:@"hotel_ collect.png"];
                        
                        
                    }
                    else
                    {
                        UIImageView*_imageView=(UIImageView*)[self.view viewWithTag:412];
                        _imageView.image=[UIImage imageNamed:@"hotel_ collect_h.png"];
                        checkCollectNum=@"已经收藏";
                        UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                    
                    
                }
                
                
                
            }
            else
            {
                
                UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"已收藏过" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
                
                
            }
            
            isCollect=NO;
        }
        
    }
    
    else if(checkLike==YES)
    { NSLog(@"checkLike----------");
        if ([result intValue])
        {
            
            if ([result intValue]==-1)
            {
                UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"参数错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
            }
            else
            {
                
                checkLikeNum=@"没有喜欢";
                UIImageView*imageView=(UIImageView*)[self.view viewWithTag:411];
                imageView.image=[UIImage imageNamed:@"hotel_ like.png"];
                
            }
            
            
            
        }
        else
        {
            
            checkLikeNum=@"已经喜欢";
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:411];
            imageView.image=[UIImage imageNamed:@"hotel_ like_h.png"];
            
            
            
        }
        
        checkLike=NO;
    }
    else if (checkCollect==YES)
    {
        NSLog(@"checkCollect----------");
        if ([result intValue])
        {
            
            if ([result intValue]==-1)
            {
                UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"参数错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
            }
            else
            {
                
                checkCollectNum=@"没有收藏";
                UIImageView*imageView=(UIImageView*)[self.view viewWithTag:412];
                imageView.image=[UIImage imageNamed:@"hotel_ collect.png"];
            }
            
            
            
        }
        else
        {
            
            checkCollectNum=@"已经收藏";
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:412];
            imageView.image=[UIImage imageNamed:@"hotel_ collect_h.png"];
            
            
            
        }
        
        checkCollect=NO;
        
        
    }
    
    [myTableView reloadData];
    [remindAlert dismissWithClickedButtonIndex:0 animated:YES];//取消
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    remindAlert=[[UIAlertView alloc]initWithTitle:@"正在加载..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    act=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    act.frame=CGRectMake(120, 48, 37, 37);
    [remindAlert addSubview:act];
    [act startAnimating];
    queue = [[NSOperationQueue alloc]init];
    
    isLike=NO;
    isCollect=NO;
    checkCollect=NO;
    checkLike=NO;
    checkLikeNum=@"没有喜欢";
    checkCollectNum=@"没有收藏";
    //NSLog(@"%@",_gudieID);
   // _tableArr = [NSMutableArray array];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-56) style:UITableViewStylePlain];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.dataSource =self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:myTableView];
    
    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _iv = [[UIImageView alloc]init];
     //_iv.image = [UIImage imageNamed:@"blueBackGround"];
    _iv.image = self.picImage;
    _iv.frame = CGRectMake(10, 10, 100, 70);
    [headView addSubview:_iv];
    
    
    _nameLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 10, 200, 20)];
    _nameLab.backgroundColor = [UIColor clearColor];
    //  _nameLab.text = [NSString stringWithFormat:@"<font  size=13 color=black>姓名</font> <font size=13 color=gray>张三</font>"];
    [headView addSubview:_nameLab];
    
    _sexLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 30, 200, 20)];
    _sexLab.backgroundColor = [UIColor clearColor];
    //_sexLab.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
    //_sexLab.text = [NSString stringWithFormat:@"<font size=13 color=black>性别</font> <font size=13 color=gray>男</font>"];
    [headView addSubview:_sexLab];
    
    if (_tag==2) {
        _typeLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 50, 200, 20)];
        _typeLab.backgroundColor = [UIColor clearColor];
        _typeLab.textColor = [UIColor  colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
        [headView addSubview:_typeLab];
    }
    
//    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(115, 70, 20, 20)];
//    iv.image = [UIImage imageNamed:@"position1"];
//    [headView addSubview:iv];
//    _positionLab = [[RTLabel alloc]initWithFrame:CGRectMake(135, 70, 180, 20)];
//    _positionLab.backgroundColor = [UIColor clearColor];
//    _positionLab.textColor = [UIColor  colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
//    //_serviceLab.frame = CGRectMake(115, 90, 200, _serviceLab.optimumSize.height);
//    [headView addSubview:_positionLab];
    

    UIImageView *_link = [[UIImageView alloc]init];
    _link.image = [UIImage imageNamed:@"entainmentLink"];
    _link.frame = CGRectMake(0, 100-2, 320, 2);
    [headView addSubview:_link];

    _dayLab = [[RTLabel alloc]initWithFrame:CGRectMake(40, 170, 100, 30)];
    _dayLab.backgroundColor = [UIColor clearColor];
    //_dayLab.textAlignment = kCTCenterTextAlignment;
    //_dayLab.text = [NSString stringWithFormat:@"$<font  size=18 color=orange>520</font>/天"];
    [headView addSubview:_dayLab];
    
    
    
    //下bar
    [self creatbottomBar];
}
- (void)creatbottomBar{
    UIView*guding=[[UIView alloc]initWithFrame:CGRectMake(0,  DeviceHeight-64-50, 320, 50)];
    guding.backgroundColor=[UIColor grayColor];
    [self.view addSubview:guding];
    NSArray*tabfootImage=@[@"hotel_write.png",@"hotel_ like.png",@"hotel_ collect.png",@"hotel_ transmit.png"];
   // NSArray*tabfootImagehight=@[@"hotel_write_h.png",@"hotel_ like_h.png",@"hotel_ collect_h.png",@"hotel_ transmit_h.png"];
    NSArray*titleArray=@[@"点评",@"喜欢",@"收藏",@"分享"];
    for (int i=0; i<4; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=400+i;
        button.frame=CGRectMake(0+80*i, 0, 80, 50);
        [button addTarget:self action:@selector(touch2:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(55.0/2, 5, 25, 25)];
        imageView.tag=410+i;
        imageView.image=[UIImage imageNamed:[tabfootImage objectAtIndex:i]];
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 80, 20)];
        lable.textColor=[UIColor whiteColor];
        lable.font=[UIFont systemFontOfSize:10];
        lable.textAlignment=NSTextAlignmentCenter;
        lable.text=[titleArray objectAtIndex:i];
        [button addSubview:imageView];
        [button addSubview:lable];
        [guding addSubview:button];
    }
    
    
    
    //    UIView*guding=[[UIView alloc]initWithFrame:CGRectMake(0,  DeviceHeight-64-50, 320, 50)];
    //    guding.backgroundColor=[UIColor grayColor];
    //    [self.view addSubview:guding];
    //    NSArray*tabfootImage=@[@"Coment.png",@"Like.png",@"Collect.png",@"Share.png"];
    //    NSArray*tabfootImagehight=@[@"Coment_h.png",@"Like_h.png",@"Collect_h.png",@"Share_h.png"];
    //    //    NSArray*titleArray=@[@"点评",@"喜欢",@"收藏",@"分享"];
    //    for (int i=0; i<4; i++)
    //    {
    //        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    //        button.tag=400+i;
    //        button.frame=CGRectMake(12+80*i, 11, 56, 28);
    //        [button setImage:[UIImage imageNamed:[tabfootImage objectAtIndex:i]] forState:UIControlStateNormal];
    //        [button setImage:[UIImage imageNamed:[tabfootImagehight objectAtIndex:i]] forState:UIControlStateHighlighted];
    //        [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    //        [guding addSubview:button];
    //    }
    
    
    
    
}
-(void)touch2:(UIButton*)sender
{
    
    //    NSArray*tabfootImagehight=@[@"hotel_write_h.png",@"hotel_ like_h.png",@"hotel_ collect_h.png",@"hotel_ transmit_h.png"];
    //
    //    NSArray*arrary=[sender subviews];
    //    for (int i=0; i<arrary.count; i++)
    //    {
    //        if ([[arrary objectAtIndex:i]isMemberOfClass:[UIImageView class]])
    //        {
    //            UIImageView*imageView=[arrary objectAtIndex:i];
    //            imageView.image=[UIImage imageNamed:[tabfootImagehight objectAtIndex:sender.tag-400]];
    //        }
    //    }
    
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    switch (sender.tag)
    {
            
            
        case 400:
        {
            
            int f=[defaults integerForKey:@"QuseID"];
            if (f)
            {
                
                ComentViewController*text=[ComentViewController new];
                text.pageName=@"导游评论";
                text.head=[dic2 valueForKey:@"UName"];
               // text.eTittle=[dic2 valueForKey:@"DianpCount"];
                text.ID=[[dic2 valueForKey:@"GuideID"] intValue];
                text.type=6;
                [self.navigationController pushViewController:text animated:NO];
                
            }
            else
            {
                
                
                MineViewController*mine=[MineViewController new];
                mine.tag=1;
                [self.navigationController pushViewController:mine animated:NO];
                
                
            }
            
            
            
            
            
            
        }
            break;
            
        case 401:
        {
            
            int f=[defaults integerForKey:@"QuseID"];
            if (f)
            {
                
                if ([checkLikeNum isEqualToString:@"没有喜欢"])
                {
                    NSString*ID=[NSString stringWithFormat:@"%@",[dic2 objectForKey:@"GuideID"]];
                    NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&username=%@&typeid=%d&classid=%d",ID,f,[defaults valueForKey:USER_NAME],1,8];
                    NSLog(@"%@",canshu);
                    NSMutableString*urlDomain=RussiaUrl2
                    NSString *urlMethod=@"getTravelColloLike";
                    [urlDomain appendString:urlMethod];
                    postRequestYiBu(canshu, urlDomain)
                    isLike=YES;
                    
                }
                else
                {
                    
                    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"是不小心吗？" delegate:self cancelButtonTitle:@"是的" otherButtonTitles:@"不是", nil];
                    alertView.tag=20;
                    [alertView show];
                    
                    
                    
                    
                    
                }
                
                
            }
            else
            {
                
                
                MineViewController*mine=[MineViewController new];
                mine.tag=1;
                [self.navigationController pushViewController:mine animated:NO];
                
                
            }
            
            
            
            
            
            
        }
            break;
        case 402:
        {
            
            int f=[defaults integerForKey:@"QuseID"];
            if (f)
            {
                
                
                if ([checkCollectNum isEqualToString:@"没有收藏"])
                {
                    NSString*ID=[NSString stringWithFormat:@"%@",[dic2 objectForKey:@"GuideID"]];
                    NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&username=%@&typeid=%d&classid=%d",ID,f,[defaults valueForKey:USER_NAME],2,8];
                    NSMutableString*urlDomain=RussiaUrl2
                    NSString *urlMethod=@"getTravelColloLike";
                    [urlDomain appendString:urlMethod];
                    postRequestYiBu(canshu, urlDomain)
                }
                else
                {
                    
                    
                    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"是不小心吗？" delegate:self cancelButtonTitle:@"是的" otherButtonTitles:@"不是", nil];
                    alertView.tag=21;
                    [alertView show];
                    
                    
                    
                    
                    
                }
                
                isCollect=YES;
            }
            else
            {
                
                
                MineViewController*mine=[MineViewController new];
                mine.tag=1;
                [self.navigationController pushViewController:mine animated:NO];
                
                
            }
            
            
            
            
            
            
        }
            break;
        case 403:
        {
            
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
            
            //构造分享内容
            id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                               defaultContent:@"默认分享内容，没内容时显示"
                                                        image:[ShareSDK imageWithPath:imagePath]
                                                        title:@"ShareSDK"
                                                          url:@"http://www.sharesdk.cn"
                                                  description:@"这是一条测试信息"
                                                    mediaType:SSPublishContentMediaTypeNews];
            
            [ShareSDK showShareActionSheet:nil
                                 shareList:nil
                                   content:publishContent
                             statusBarTips:YES
                               authOptions:nil
                              shareOptions: nil
                                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                        if (state == SSResponseStateSuccess)
                                        {
                                            NSLog(@"分享成功");
                                        }
                                        else if (state == SSResponseStateFail)
                                        {
                                            NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                        }
                                    }];
            
            
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}
#pragma mark--喜欢和收藏的代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int f=[defaults integerForKey:@"QuseID"];
    switch (buttonIndex)
    {
        case 1:
        {
            if (alertView.tag==20)
            {
                
                
                NSString*ID=[NSString stringWithFormat:@"%@",[dic2 objectForKey:@"GuideID"]];
                NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&typeid=%d&classid=%d",ID,f,1,8];
                NSMutableString*urlDomain=RussiaUrl2
                NSString *urlMethod=@"UnColloLike";
                [urlDomain appendString:urlMethod];
                postRequestYiBu(canshu, urlDomain)
                isLike=YES;
                
            }
            
            if (alertView.tag==21)
            {
                NSString*ID=[NSString stringWithFormat:@"%@",[dic2 objectForKey:@"GuideID"]];
                NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&typeid=%d&classid=%d",ID,f,2,8];
                NSMutableString*urlDomain=RussiaUrl2
                NSString *urlMethod=@"UnColloLike";
                [urlDomain appendString:urlMethod];
                postRequestYiBu(canshu, urlDomain)
                
                
            }
            
            
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)touchBuy:(UIButton*)btn{
    CarAndGuideReseverViewController * rrc = [CarAndGuideReseverViewController new];
    rrc.ID=[dic2 objectForKey:@"GuideID"];
    
    rrc.ProdType = [dic2 valueForKey:@"GuideType"];
    rrc.title = @"导游兼翻译预订";
    rrc.nameStr = [dic2 valueForKey:@"UName"];
    rrc.CNUStudentStr =[[_tableArr[btn.tag] componentsSeparatedByString:@"$"] firstObject];
    rrc.reseverKnowStr = [dic2 objectForKey:@"OrderNote"];
    rrc.roomFacilityStr = [dic2 valueForKey:@"Other"];
    rrc.RMB = [dic2 valueForKey:@"CNPrice"];
    rrc.dollar = [dic2 objectForKey:@"LOPrice"];
    rrc.startDate2Str = [dic2 valueForKey:@"StartDate2"];
    rrc.tag=2;
    [self.navigationController pushViewController:rrc animated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    for (UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIImageView *_link = [[UIImageView alloc]init];
    _link.image = [UIImage imageNamed:@"entainmentLink"];
    _link.frame = CGRectMake(10, cell.frame.size.height-2, 300, 2);
    [cell.contentView addSubview:_link];
    
    RTLabel *lab = [[RTLabel alloc]initWithFrame:CGRectMake(10, 12, 200, 30)];
    lab.text = _tableArr[indexPath.row];
    lab.font = [UIFont systemFontOfSize:16];
    [cell.contentView addSubview:lab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(240, 9, 59, 25);
    btn.layer.cornerRadius=4;
    btn.tag=indexPath.row;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"预订" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchBuy:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"LineDetail_reserve.png"] forState:UIControlStateNormal];
    [cell.contentView addSubview:btn];
    
    
    return cell;
}

@end
