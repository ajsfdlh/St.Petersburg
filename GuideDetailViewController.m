//
//  GuideDetailViewController.m
//  St.Petersburg
//
//  Created by li on 14-4-29.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "GuideDetailViewController.h"
#import "GDataXMLNode.h"
#include "JSON.h"
#import "CarAndGuideReseverViewController.h"
@interface GuideDetailViewController ()

@end

@implementation GuideDetailViewController
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
    postRequestTongBu(argumentStr, urlStr, received)
    dicResultTongbu(received, result, dic)
    
    dic2=[[dic objectForKey:@"ds"] lastObject];
    NSLog(@"dic2  %@",dic2);
    _nameLab.text = [NSString stringWithFormat:@"<font  size=16 color=black><b>姓名</b></font> <font size=16 color=gray>%@</font>",[dic2 objectForKey:@"UName"]];
    _sexLab.text = [NSString stringWithFormat:@"<font size=16 color=black><b>性别</b></font> <font size=16 color=gray>%@</font>",[[dic2 objectForKey:@"Sex"] intValue]==1?@"男":@"女"];
    _typeLab.text = [NSString stringWithFormat:@"<font size=16 color=black><b>类型</b></font> <font size=16>%@</font>",[dic2 objectForKey:@"GuideClass"]];
    _countryLab.text = [NSString stringWithFormat:@"<font size=16 color=black><b>国籍</b></font> <font size=16 color=gray>%@</font>",[[dic2 objectForKey:@"Country"] intValue]==1?@"中国籍":@"俄罗斯籍"];
    _dayLab.text = [NSString stringWithFormat:@"$<font  size=18 color=orange>%@</font>/天",[dic2 objectForKey:@"UPrice"]];
    
    [textArr addObject:[dic2 objectForKey:@"Language"]];
    [textArr addObject:[NSString stringWithFormat:@"%@人座 %@ %@",[dic2 objectForKey:@"SeatCount"],[dic2 objectForKey:@"CarType"],[dic2 objectForKey:@"JiCheng"]]];
    [textArr addObject:[dic2 objectForKey:@"JiangJie"]];
    [textArr addObject:[dic2 objectForKey:@"FanYi"]];
    [textArr addObject:[NSString stringWithFormat:@"每天工作%@小时",[dic2 objectForKey:@"Hour"]]];
    [textArr addObject:[dic2 objectForKey:@"ZongZhi"]];
    
    [textArr addObject:[NSString stringWithFormat:@"%@",[[dic2 objectForKey:@"Other"] intValue]==0?@"":@"愿意跟随客人到其他城市"]];
 

    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
    UIImageView *_link = [[UIImageView alloc]init];
    _link.image = [UIImage imageNamed:@"entainmentLink"];
    _link.frame = CGRectMake( 10, 0, 300, 2);
    [footView addSubview:_link];
    footLab = [[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    footLab.text = [NSString stringWithFormat:@"<font size=15 color=black><b>个人介绍\n</b></font><font size=12 color=gray>    %@</font>",[dic2 objectForKey:@"Note"]];
    footLab.frame = CGRectMake(10, 20, 300, footLab.optimumSize.height);
    footView.frame = CGRectMake(0, 0, 320, footLab.frame.size.height+40);
    [footView addSubview:footLab];
    myTableView.tableFooterView = footView;
    myTableView.tableHeaderView = headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [textArr[indexPath.row]isEqualToString:@""]||[textArr[indexPath.row]isEqualToString:@"0人座  "])
    {
    
        return 0;
    }
    
    
    if ([titleArr[indexPath.row]isEqualToString:@"服务宗旨"]||[titleArr[indexPath.row]isEqualToString:@"擅长翻译"])
    {
        RTLabel*lable;
        lable = [[RTLabel alloc]initWithFrame:CGRectMake(0, 0, 190, 0)];
        lable.text=textArr[indexPath.row];
        lable.font = [UIFont boldSystemFontOfSize:16];
       
        CGSize size = [lable optimumSize];
         NSLog(@"擅长翻译  %f",size.height);
        if (size.height>40)
        {
            return size.height+20;
        }
    }
    
    return 44;
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
    {
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
    tableArr = [NSMutableArray array];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-56) style:UITableViewStylePlain];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.dataSource =self;
    myTableView.delegate = self;
    myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:myTableView];
    
    headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 205)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _iv = [[UIImageView alloc]init];
   // _iv.image = [UIImage imageNamed:@"blueBackGround"];
    _iv.image = self.picImage;
    _iv.frame = CGRectMake(10, 10, 100, 130);
    [headView addSubview:_iv];
    
    _nameLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 10, 200, 20)];
    _nameLab.backgroundColor = [UIColor clearColor];
   //  _nameLab.text = [NSString stringWithFormat:@"<font  size=13 color=black>姓名</font> <font size=13 color=gray>张三</font>"];
    [headView addSubview:_nameLab];

    _sexLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 35, 200, 20)];
    _sexLab.backgroundColor = [UIColor clearColor];
    //_sexLab.text = [NSString stringWithFormat:@"<font size=13 color=black>性别</font> <font size=13 color=gray>男</font>"];
    [headView addSubview:_sexLab];

    _typeLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 60, 200, 20)];
    _typeLab.backgroundColor = [UIColor clearColor];
    _typeLab.textColor = [UIColor  colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
     //_typeLab.text = [NSString stringWithFormat:@"<font  size=13 color=black>类型</font> <font size=13 color=blue>导游</font>"];
    [headView addSubview:_typeLab];

    _countryLab = [[RTLabel alloc]initWithFrame:CGRectMake(115, 85, 200, 20)];
    _countryLab.backgroundColor = [UIColor clearColor];
     //_countryLab.text = [NSString stringWithFormat:@"<font  size=13 color=black>国籍</font> <font size=13 color=gray>民族/艺术,历史/文化,宗教/人文</font>"];
    [headView addSubview:_countryLab];

//    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(115, 110, 20, 20)];
//    iv.image = [UIImage imageNamed:@"position1"];
//    [headView addSubview:iv];
//    _positionLab = [[RTLabel alloc]initWithFrame:CGRectMake(135, 110, 180, 20)];
//    _positionLab.backgroundColor = [UIColor clearColor];
//    _positionLab.textColor = [UIColor  colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
   
    //_serviceLab.frame = CGRectMake(115, 90, 200, _serviceLab.optimumSize.height);
//    [headView addSubview:_positionLab];
    
    for (int i = 0; i<2; i++) {
        UIImageView *_link = [[UIImageView alloc]init];
        _link.image = [UIImage imageNamed:@"entainmentLink"];
        _link.frame = CGRectMake(0, 160-2+44*i, 320, 2);
        [headView addSubview:_link];
    }
    _dayLab = [[RTLabel alloc]initWithFrame:CGRectMake(10, 170, 100, 30)];
    _dayLab.backgroundColor = [UIColor clearColor];
    //_dayLab.textAlignment = kCTCenterTextAlignment;
    //_dayLab.text = [NSString stringWithFormat:@"$<font  size=18 color=orange>520</font>/天"];
    [headView addSubview:_dayLab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(240, 168, 59, 25);
    btn.layer.cornerRadius=4;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LineDetail_reserve.png"]];
    [btn setTitle:@"预订" forState:UIControlStateNormal];
     [btn addTarget:self action:@selector(goBug:) forControlEvents:UIControlEventTouchUpInside];
    //[btn addTarget:self action:@selector(touchBuy) forControlEvents:UIControlEventTouchUpInside];

    [headView addSubview:btn];
    picArr = @[@"language1",@"car1",@"transition1",@"jiangejie1",@"theater_times",@"severive1",@"other1"];
    titleArr = @[@"语言",@"车况",@"擅长讲解",@"擅长翻译",@"工作时间",@"服务宗旨",@"其他"];
    textArr = [NSMutableArray array];
    
    
    //下bar
    [self creatbottomBar];
}
- (void)goBug:(UIButton *)btn{

    
    if (GET_USER_DEFAUT(USER_NAME))
    {
        CarAndGuideReseverViewController * rrc = [CarAndGuideReseverViewController new];
        rrc.ID=[dic2 objectForKey:@"GuideID"];
        
        rrc.ProdType = [dic2 valueForKey:@"GuideType"];//1个人2供应商
        if (_tag==3)
        {
            rrc.tag= 3;
            rrc.title = @"租车预订";
            rrc.peopleCountStr = [NSString stringWithFormat:@"%@人座",[dic2 objectForKey:@"SeatCount"]];
            rrc.jichengStr = [dic2 objectForKey:@"JiCheng"];
            rrc.carTypeStr = [dic2 objectForKey:@"CarType"];
        }else
        {
            rrc.title = @"导游预订";
            rrc.peopleCountStr = @"50";
            rrc.tag=2;
        }
       // rrc.GuideTypeStr = [dic2 valueForKey:@"GuideType"];
        rrc.payWay = [dic2 valueForKey:@"OrderType"];
        rrc.startDate2Str = [dic2 valueForKey:@"StartDate2"];//系统时间
        rrc.payWay =[dic2 valueForKey:@"OrderType"];
        rrc.nameStr = [dic2 valueForKey:@"UName"];
        rrc.carAndGuideTypeStr = [dic2 valueForKey:@"GuideClass"];
        rrc.countryStr = [[dic2 objectForKey:@"Country"] intValue]==2?@"俄籍":@"";
        //        if ([[dic2 valueForKey:@"GuideType"] integerValue]==1) {
        //人物
        NSString *sexStr_;
        if ([[dic2 objectForKey:@"Country"] intValue]==1) {
            sexStr_ = @"男";
        }else sexStr_ = @"女";
        rrc.sexStr=sexStr_;
        rrc.reseverKnowStr = [dic2 objectForKey:@"OrderNote"];
        rrc.roomFacilityStr = [dic2 valueForKey:@"Other"];
        rrc.RMB = [dic2 valueForKey:@"CNPrice"];
        rrc.dollar = [dic2 objectForKey:@"LOPrice"];
        rrc.startDate2Str = [dic2 valueForKey:@"StartDate2"];
        
        [self.navigationController pushViewController:rrc animated:NO];
    } else {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请登陆" message:@"您还没登陆，您确定要登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.tag=10;
                [alertView show];
            }
}
- (void)creatbottomBar{
    UIView*guding=[[UIView alloc]initWithFrame:CGRectMake(0,  DeviceHeight-64-50, 320, 50)];
    guding.backgroundColor=[UIColor grayColor];
    [self.view addSubview:guding];
    NSArray*tabfootImage=@[@"hotel_write.png",@"hotel_ like.png",@"hotel_ collect.png",@"hotel_ transmit.png"];
    NSArray*tabfootImagehight=@[@"hotel_write_h.png",@"hotel_ like_h.png",@"hotel_ collect_h.png",@"hotel_ transmit_h.png"];
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
        imageView.highlightedImage = [UIImage imageNamed:[tabfootImagehight objectAtIndex:i]];
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
                
            }else  if (alertView.tag==21)
            {
                NSString*ID=[NSString stringWithFormat:@"%@",[dic2 objectForKey:@"GuideID"]];
                NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&typeid=%d&classid=%d",ID,f,2,8];
                NSMutableString*urlDomain=RussiaUrl2
                NSString *urlMethod=@"UnColloLike";
                [urlDomain appendString:urlMethod];
                postRequestYiBu(canshu, urlDomain)
                
                
            }else if (alertView.tag==10) {//预订
                if (buttonIndex==1) {
                    MineViewController *mvc = [MineViewController new];
                    mvc.tabBarController.tabBar.hidden=YES;
                    mvc.tag=1;
                    [self.navigationController pushViewController:mvc animated:YES];
                    
                }
            }
            
            
        }
            break;
            
        default:
            break;
    }
    
    
}

//- (void)touchBuy{
//    NSLog(@"showhand");
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
   else
   {
       while([cell.contentView.subviews lastObject] != nil)
       {
           [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
       }

   
   }
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    UIImageView *iv= [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
    iv.image = [UIImage imageNamed:picArr[indexPath.row]];
    [cell.contentView addSubview:iv];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(40, 7, 75, 30)];
    // title.backgroundColor = [UIColor redColor];
    title.font = [UIFont boldSystemFontOfSize:16];
    title.text = titleArr[indexPath.row];
    [cell.contentView addSubview:title];
    CGSize size;
    if (textArr.count>0) {
        RTLabel *text1 = [[RTLabel alloc]initWithFrame:CGRectMake(115, 12, 195, 44)];
        text1.text = [NSString stringWithFormat:@"%@",textArr[indexPath.row]];
        text1.font = [UIFont systemFontOfSize:16];
        text1.textColor = [UIColor grayColor];
        text1.lineSpacing= 3;
        size=[text1 optimumSize];

//        NSLog(@"size========%f",size.height);
//        NSLog(@"title==========%@",textArr[indexPath.row]);
        if (size.height>=40.0)
        {
            iv.frame = CGRectMake(10, 9, 21, 21);
            title.frame = CGRectMake(40, 5, 75, 30);
            text1.frame=CGRectMake(115, 10, 195, size.height);
            NSLog(@"title==========%@",textArr[indexPath.row]);
            
        }
        // NSLog(@"textArr  %@",textArr[indexPath.row]);
        [cell.contentView addSubview:text1];
    }
    if (indexPath.row!=0) {
        UIImageView *_link = [[UIImageView alloc]init];
        _link.image = [UIImage imageNamed:@"entainmentLink"];
        _link.frame = CGRectMake(10, 0, 300, 2);
        [cell.contentView addSubview:_link];
    }
    
    if ([[textArr objectAtIndex:indexPath.row] length]==0) {
        for (UIView *v in cell.subviews) {
            [v removeFromSuperview];
        }
    }
    return cell;
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
