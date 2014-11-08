//
//  EntainDetailViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-25.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "EntainDetailViewController.h"
#import "ImageScrollView.h"
#import "JSON.h"
#import "GDataXMLNode.h"
#import "HotelRoomCell.h"
#import "SceneryTicketCell.h"
#import "SeceneryComentCell.h"
#import "surnameCustomCell.h"
#import "SeceneryCommentView.h"
#import "RoomReseverClass.h"
#import "SceneryReceverClass.h"
#import "EntainReseverClass.h"
#import "LineReseverClass.h"
#import "hotelCarenderViewController.h"

@interface EntainDetailViewController ()
{
    hotelCarenderViewController *hotelCarender;
}
@end

@implementation EntainDetailViewController

backButton
-(void)viewWillAppear:(BOOL)animated
{
    _picPath2 = @"hotel";
    hideTabbar;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];

}
NetChange(noNetButton)
-(void)viewDidDisappear:(BOOL)animated
{
    [navActivity removeFromSuperview];
}

-(void)checkLike:(id)_f
{
    
    NSString*canshu=[NSString stringWithFormat:@"ID=%d&userid=%d&typeid=%d&classid=%d",self.hotelID,[_f intValue],1,self.classID];
    
    NSString *urlMethod=@"CheckColloLike";
    NSMutableString*urlDomain2=RussiaUrl2
    [urlDomain2 appendString:urlMethod];
    postRequestYiBu(canshu, urlDomain2)
    checkLike=YES;
    
}
postRequestAgencyAndRefeshAndAlert(datas, refresh, remindAlert,navActivity)

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    [navActivity stopAnimating];
    [remindAlert dismissWithClickedButtonIndex:0 animated:YES];//取消
    dicResultYiBu(datas, result, dic)
    
    [[LineViewController new]endRefresh:refresh];
    NSDictionary*_dic=[[dic valueForKey:@"ds"]lastObject];
   // NSLog(@"result %@",result);
    NSLog(@"_dic=========%@",_dic);
   // NSLog(@"result=========%@",result);
    
    if ([_dic  valueForKey:@"RoomName"]||[_dic valueForKey:@"LineDay"]||[_dic  valueForKey:@"ViewName"]||isGetComment==YES)
    {
        isGetComment=NO;
        [dataArray removeAllObjects];
       // dataDic = [NSArray arrayWithArray:[dic valueForKey:@"ds"]];
        
        dataArray=[dic valueForKey:@"ds"];
        [_tableView reloadData];
        
        WriteToFile(dataArray, arrayPath);
        if ([self.navName isEqualToString:@"景点介绍"])
        {
            [self getComment];
        }

    }
    
   if ([_dic valueForKey:@"LineType"]||[_dic valueForKey:@"HotelRUName"]||[_dic valueForKey:@"TicketRName"]||[_dic valueForKey:@"RestRName"]||[_dic valueForKey:@"ShopCName"]||[_dic valueForKey:@"ViewRUName"])
    {
        dataDic=nil;
        dataDic=[[dic valueForKey:@"ds"]lastObject];
        if (![self.navName isEqualToString:@"线路介绍"])
        {
            [self getPicUrl:picMethod];
            
        }
        else
        {
            
            _tableView.tableHeaderView=[self creatHeadView];
            [_tableView reloadData];
            [remindAlert dismissWithClickedButtonIndex:0 animated:YES];//取消
            
            [self getDetailList:arrayMethod];
            
        }
        
        
        WriteToFile(dataDic, dicPath);
        
        
        
        return;
    }
    if ([_dic valueForKey:@"UserName"])
    {
        
        [commentArray removeAllObjects];
        commentArray=[dic valueForKey:@"ds"];
        [_tableView reloadData];
        
        return;
        
    }
    
    if ([_dic valueForKey:@"PicName"])
    {
        picUrlArray=[dic valueForKey:@"ds"];
        NSLog(@"picUrlArray  %@",picUrlArray);
        WriteToFile(picUrlArray, picPath);
        _tableView.tableHeaderView=[self creatHeadView];
        [_tableView reloadData];
        
        if ([self.navName isEqualToString:@"酒店介绍"]||[self.navName isEqualToString:@"线路介绍"]||[self.navName isEqualToString:@"景点介绍"])
        {
            [self getDetailList:arrayMethod];
        }
        if ([self.navName isEqualToString:@"景点介绍"])
        {
            isGetComment=YES;
            
        }
    }
    
  
    
    
    

    
    
    
    
    
    if (checkCollect==YES)
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
                UIButton*imageView=(UIButton*)[self.view viewWithTag:402];
                [imageView setImage:[UIImage imageNamed:@"Collect.png"] forState:UIControlStateNormal];
                
            }
            
            
            
        }
        else
        {
            
            checkCollectNum=@"已经收藏";
            UIButton*imageView=(UIButton*)[self.view viewWithTag:402];
            [imageView setImage:[UIImage imageNamed:@"Collect_h.png"] forState:UIControlStateNormal];
            
            
            
        }
        
        checkCollect=NO;
        
        
        
    }
    if (checkLike==YES)
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
                UIButton*imageView=(UIButton*)[self.view viewWithTag:401];
                [imageView setImage:[UIImage imageNamed:@"Like.png"] forState:UIControlStateNormal];
                
            }
            
            
            
        }
        else
        {
            
            checkLikeNum=@"已经喜欢";
            UIButton*imageView=(UIButton*)[self.view viewWithTag:401];
            [imageView setImage:[UIImage imageNamed:@"Like_h.png"] forState:UIControlStateNormal];
            
            
            
            
            
        }
        
        checkLike=NO;
        [_tableView reloadData];
        
    }
    
    
    if (isCollect==YES)
    {
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
                    
                    
                    UIButton*imageView=(UIButton*)[self.view viewWithTag:402];
                    [imageView setImage:[UIImage imageNamed:@"Collect.png"] forState:UIControlStateNormal];
                    
                    
                    
                    
                }
                else
                {
                    UIButton*imageView=(UIButton*)[self.view viewWithTag:402];
                    [imageView setImage:[UIImage imageNamed:@"Collect_h.png"] forState:UIControlStateNormal];
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
                    UIButton*imageView=(UIButton*)[self.view viewWithTag:401];
                    [imageView setImage:[UIImage imageNamed:@"Like.png"] forState:UIControlStateNormal];
                    NSLog(@"checkLikeNum==%@",checkLikeNum);
                    
                }
                else
                {
                    
                    NSLog(@"checkLikeNum==%@",checkLikeNum);
                    checkLikeNum=@"已经喜欢";
                    NSLog(@"checkLikeNum==%@",checkLikeNum);
                    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"喜欢成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    
                    
                    UIButton*imageView=(UIButton*)[self.view viewWithTag:401];
                    [imageView setImage:[UIImage imageNamed:@"Like_h.png"] forState:UIControlStateNormal];
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
    
    
}


GO_NET
- (void)viewDidLoad
{
    [super viewDidLoad];
    queue = [[NSOperationQueue alloc]init];
    navActivity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    navActivity.frame=CGRectMake(65+(8-[self.navName length])*10, (44- navActivity.frame.size.height)/2, navActivity.frame.size.width,  navActivity.frame.size.height);
    [self.navigationController.navigationBar addSubview:navActivity];
    
    
    [self setTitle:self.navName];
    isGetPic=NO;
    isGetProduct=NO;
    isGetComment=NO;
    moreComment=0;
    

    
    
    
    [commentArray2 removeAllObjects];
    dataArray=[NSMutableArray new];
    dataDic=[NSDictionary new];
    picUrlArray=[NSMutableArray new];
    commentArray=[NSMutableArray new];
    commentPic=[NSMutableArray new];
    
    
    isTime=NO;
    checkCollect=NO;
    checkLike=NO;
    checkLikeNum=@"没有喜欢";
    checkCollectNum=@"没有收藏";
    isLike=NO;
    isCollect=NO;
    
    remindAlert=[[UIAlertView alloc]initWithTitle:@"正在加载..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    act=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    act.frame=CGRectMake(120, 48, 37, 37);
    [remindAlert addSubview:act];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.backgroundColor=GroupColor;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    noNetButton=NoNetButton(noNetButton);
    
    
    noNetButton=NoNetButton(noNetButton);
    self.editing=YES;
    refresh=[[UIRefreshControl alloc] init];
    refresh.tintColor=[UIColor clearColor];
    refresh.attributedTitle=[[NSAttributedString alloc] initWithString:@""];
    
    [refresh addTarget:self action:@selector(refreshing) forControlEvents:UIControlEventValueChanged];
    if (self.tag!=2&&self.tag!=3)
    {
        [_tableView addSubview:refresh];
    }
    
    
    
    UIView*CommentView=[[UIView alloc]initWithFrame:CGRectMake(0,DeviceHeight-64-50-50, 320, 50)];
    CommentView.backgroundColor=[UIColor grayColor];
    CommentView.tag=10;
    CommentView.hidden=YES;
    [self.view addSubview:CommentView];
    
    arr=[NSArray arrayWithObjects:@"wenzi.png",@"yuyin.png",@"tupian.png", nil];
    for (int i=0; i<3; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
        button.frame=CGRectMake(0+i*320.0/3, 0, 320.0/3, 50);
        button.backgroundColor=[UIColor greenColor];
        [CommentView addSubview:button];
        
    }
    
    
    
    //下bar
    {   UIImageView*guding=[[UIImageView alloc]initWithFrame:CGRectMake(0,  DeviceHeight-64-45, 320, 45)];
        //    guding.alpha=0.8;
        guding.userInteractionEnabled=YES;
        guding.image=[UIImage imageNamed:@"guding.png"];
        
        [self.view addSubview:guding];
        NSArray*tabfootImage=@[@"Coment.png",@"Like.png",@"Collect.png",@"Share.png"];
        NSArray*tabfootImagehight=@[@"Coment_h.png",@"Like_h.png",@"Collect_h.png",@"Share_h.png"];
        // NSArray*titleArray=@[@"点评",@"喜欢",@"收藏",@"分享"];
        for (int i=0; i<4; i++)
        {
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.tag=400+i;
            button.frame=CGRectMake(12+80*i, 11, 56, 28);
            [button setImage:[UIImage imageNamed:[tabfootImage objectAtIndex:i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:[tabfootImagehight objectAtIndex:i]] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            [guding addSubview:button];
        }}
    
    
        [self refreshDataIndex:0 andIsRefreshBody:YES andIsRefreshHead:NO andAnimal:NO];

    
    
    
    [self performSelector:@selector(checkCollect) withObject:nil afterDelay:0.2];
    
}

-(void)refreshing
{
    
    
    [self refreshDataIndex:0 andIsRefreshBody:YES andIsRefreshHead:YES andAnimal:NO];
    
    
}
#pragma mark --获取数据--
-(void)refreshDataIndex:(int)_index andIsRefreshBody:(BOOL)body andIsRefreshHead:(BOOL)head andAnimal:(BOOL)animal
{
    [navActivity startAnimating];
    arrayPath=@"1234";
    NSString*canshu=[NSString stringWithFormat:@"ID=%d",self.hotelID];
    
    if (![self.navName isEqualToString:@"线路介绍"]&&![[NSString stringWithFormat:@"%@租车",[_dataDic2 valueForKey:@"UName"]] isEqualToString:self.title])
    {
        urlDomain=RussiaUrl3;
    }
//    else if ([[NSString stringWithFormat:@"%@租车",[_dataDic2 valueForKey:@"UName"]] isEqualToString:self.title]){
//        urlDomain = RussiaUrl4
//    }
    else
    {
        
        urlDomain=RussiaUrl2
    }
    
    if ([self.navName isEqualToString:@"酒店介绍"])
    {
        
        
        
        dicPath=[NSString stringWithFormat:@"getHotelDetail%d",self.hotelID];
        dicMethod=@"getHotelDetail";
        arrayPath=[NSString stringWithFormat:@"getHotelRoomList%d",self.hotelID];
        arrayMethod=@"getHotelRoomList";
        picMethod=@"getHotelPicsList";
        picPath=[NSString stringWithFormat:@"%@%d",picMethod,self.hotelID];
        
    }
    if ([self.navName isEqualToString:@"线路介绍"])
    {
        
        
        dicPath=[NSString stringWithFormat:@"getTourLineDetail%d",self.hotelID];
        arrayPath=[NSString stringWithFormat:@"getTourLineDetail2%d",self.hotelID];
        dicMethod=@"getTourLineDetail";
        arrayMethod=@"getTourLineDetail2";
        picMethod=@"sdsdsdsd";
        picPath=@"sdsdsdsd";
        
        
        
    }
    
    
    
    if (self.tag==1)
    {
        dicPath=[NSString stringWithFormat:@"getTicketDetail%d",self.hotelID];
        
        dicMethod=@"getTicketDetail";
        
        picMethod=@"getTicketPicsList";
        
        picPath=[NSString stringWithFormat:@"%@%d",picMethod,self.hotelID];
    }
    if ([self.navName isEqualToString:@"餐厅介绍"])
    { 
        dicPath=[NSString stringWithFormat:@"getRestDetail%d",self.hotelID];
        dicMethod=@"getRestDetail";
        picMethod=@"getRestPicsList";
        picPath=[NSString stringWithFormat:@"%@%d",picMethod,self.hotelID];
        
    }
    if ([self.navName isEqualToString:@"购物介绍"])
    {
        
        dicPath=[NSString stringWithFormat:@"getShopDetail%d",self.hotelID];
        dicMethod=@"getShopDetail";
        picMethod=@"getShopPicsList";
        picPath=[NSString stringWithFormat:@"%@%d",picMethod,self.hotelID];
        
        
    }
    
    if ([self.navName isEqualToString:@"景点介绍"])
    {
        
        dicPath=[NSString stringWithFormat:@"getViewDetail%d",self.hotelID];
        dicMethod=@"getViewDetail";
        
        
        arrayPath=[NSString stringWithFormat:@"getViewProdList%d",self.hotelID];
        arrayMethod=@"getViewProdList";
        
        picMethod=@"getViewPicsList";
        picPath=[NSString stringWithFormat:@"%@%d",picMethod,self.hotelID];
    }
    
    
    if (FileExists(dicPath))
    {
        dataDic=[NSDictionary dictionaryWithContentsOfFile:PathOfFile(dicPath)];
        if (FileExists(arrayPath))
        {
            dataArray=[NSMutableArray arrayWithContentsOfFile:PathOfFile(arrayPath)];
        }
        if (FileExists(picPath))
        {
            picUrlArray=[NSMutableArray arrayWithContentsOfFile:PathOfFile(picPath)];
        }
        
        _tableView.tableHeaderView=[self creatHeadView];
        
        
    }
    if(body==YES)
    {
        
       // if (![[NSString stringWithFormat:@"%@租车",[_dataDic2 valueForKey:@"UName"]] isEqualToString:self.title]){
        
       // NSLog(@"urlDomain  %@ dicMethod  %@  tittle  %@",urlDomain,dicMethod,self.title);
            [urlDomain appendString:dicMethod];
            
            postRequestYiBu(canshu, urlDomain)
       // }
        
        Reachability*rea2 =[Reachability reachabilityWithHostName:@"www.baidu.com"];if ([rea2  currentReachabilityStatus]==NotReachable){noNetButton.hidden=NO;}else{noNetButton.hidden=YES;}
        
        
        if (animal==YES)
        {
            [act startAnimating];
            
            [remindAlert show];
        }
        
        
        
    }
    
    
    
}
-(void)getComment
{
    
    urlDomain=RussiaUrl3;
    NSString*canshu=[NSString stringWithFormat:@"ID=%d&typeid=%d&orderby=%d&pagesize=%d&pageindex=%d",self.hotelID,0,0,10,0];
    NSString *urlMethod=@"getViewInterpretationList";
    [urlDomain appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomain)
    
    
    
    
    
}
-(void)getDetailList:(NSString*)method
{
    if (![self.navName isEqualToString:@"线路介绍"])
    {
        urlDomain=RussiaUrl3;
    }
    else
    {
        
        urlDomain=RussiaUrl2
    }
    
    NSString*canshu=[NSString stringWithFormat:@"ID=%d",self.hotelID];
    NSString *urlMethod=method;
    [urlDomain appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomain)
    
    
}
#pragma mark --获取多图数据--
-(void)getPicUrl:(NSString*)method
{
    if (![self.navName isEqualToString:@"线路介绍"])
    {
        urlDomain=RussiaUrl3;
    }
    else
    {
        
        urlDomain=RussiaUrl2
    }
    
    NSString* canshu=[NSString stringWithFormat:@"ID=%d&cityid=%d",self.hotelID,2];
    NSString* urlMethod=method;
    [urlDomain appendString:urlMethod];
    postRequestYiBu(canshu, urlDomain)

    
    
}
-(void)getTourLineDetail2
{
    NSString*canshu=[NSString stringWithFormat:@"ID=%d",self.hotelID];
    NSMutableString*urlDomain2=RussiaUrl2
    NSString *urlMethod=@"getTourLineDetail2";
    [urlDomain2 appendString:urlMethod];
    postRequestYiBu(canshu, urlDomain2)
 
}
-(void)getHotelRoomList
{
    NSString*canshu=[NSString stringWithFormat:@"ID=%d",self.hotelID];
    NSMutableString*urlDomain2=RussiaUrl3;
    NSString *urlMethod=@"getHotelRoomList";
    [urlDomain2 appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomain2)
}
-(void)checkCollect
{
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int _f = [defaults integerForKey:@"QuseID"];
    if (_f)
    {
        {
            NSString*canshu=[NSString stringWithFormat:@"ID=%d&userid=%d&typeid=%d&classid=%d",self.hotelID,_f,2,self.classID];
            NSMutableString*urlDomain2=RussiaUrl2
            NSString *urlMethod=@"CheckColloLike";
            [urlDomain2 appendString:urlMethod];
            postRequestYiBu(canshu, urlDomain2)
            checkCollect=YES;
            
        }
        [self performSelector:@selector(checkLike:) withObject:[NSNumber numberWithInt:_f] afterDelay:0.2];
        
    }
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if ([self.navName isEqualToString:@"景点介绍"])
    {
        if ([[dataArray lastObject]valueForKey:@"ViewName"])
        {
            return dataArray.count;
        }
        else
        {
            return 0;
            
        }
    }
    if ([self.navName isEqualToString:@"线路介绍"])
    {
        return ceilf(((float)dataArray.count)/2);
    }
    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.navName isEqualToString:@"线路介绍"]||[self.navName isEqualToString:@"景点介绍"])
    {
        if (indexPath.section==0)
        {
            return 85;
        }
    }
    return 100;
}
#pragma mark--讲解的评论
/*-(void)changeCommentFram:(id)sener andIndexPath:(NSIndexPath*)indexPath
{
    surnameCustomCell*cell=(surnameCustomCell*)sener;
    
    CGSize size=[cell.userName sizeThatFits:CGSizeMake(0, 15)];
    
    cell.userName.frame=CGRectMake( cell.userImage.frame.origin.x+cell.userImage.frame.size.width+5, 15, size.width, 15);
    cell.comentDate.frame=CGRectMake(cell.userName.frame.origin.x+cell.userName.frame.size.width+5, 15, 200, 15);
    
    
//    int a=  [[[[[allCommentArray2 objectAtIndex:indexPath.section-2] valueForKey:@"arry"] objectAtIndex:indexPath.row-1] valueForKey:@"FenCount"] integerValue];
//    cell._imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%dxing.png",a]];
//    
//    cell._imageView.frame=CGRectMake(cell.userName.frame.origin.x, 35, a*10, 10);
//    if (a!=0)
//    {
        cell._imageViewTitle.frame=CGRectMake(cell._imageView.frame.origin.x+cell._imageView.frame.size.width, 35, 20, 10);
//    }
    
    
    CGSize size5=[cell.title optimumSize];
    cell.title.frame=CGRectMake(cell.userName.frame.origin.x, 50, 240, size5.height);
    
    cell.link.frame=CGRectMake(10,cell.title.frame.origin.y+cell.title.frame.size.height+18, 300, 2);
}*/

-(void)jiangjie:(UIButton*)sender
{
    
    
    [self.navigationController pushViewController:[SeceneryCommentView new] animated:NO];
    
    
    
}
-(void)comment
{
    
    UIView*CommentView=(UIView*)[self.view viewWithTag:9];
    
    
    if ( CommentView.hidden)
    {
        CommentView.hidden=NO;
    }
    else
    {
        CommentView.hidden=YES;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"cell";
    
    if ([self.navName isEqualToString:@"酒店介绍"])
    {
        HotelRoomCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (cell==nil)
        {
            cell=[[HotelRoomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        NSString *Ftitle=@"";
        
        if ([[[dataArray objectAtIndex:indexPath.row]valueForKey:@"Ftitle"] length]>0) {
            Ftitle = [NSString stringWithFormat:@"-%@",[[dataArray objectAtIndex:indexPath.row]valueForKey:@"Ftitle"]];
        }
        NSLog(@"Ftitle %@",[NSString stringWithFormat:@"%@%@",[[dataArray objectAtIndex:indexPath.row]valueForKey:@"RoomName"],Ftitle]);
        
       NSString *head = [NSString stringWithFormat:@"%@%@",[[dataArray objectAtIndex:indexPath.row]valueForKey:@"RoomName"],Ftitle];
        cell.head.text=[NSString stringWithString:head];
        cell.head.frame = CGRectMake(115, 10, 140, cell.head.optimumSize.height);
        
        [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath.row objectForKey:@"RoomPic" picHeadUrlStr:PicUrl picUrlPathStr:@"Hotel" PicLoadName:cell.head.text headView:cell._imageView];
        cell.title.text=[[dataArray objectAtIndex:indexPath.row]valueForKey:@"Other"];
        cell.title.frame = CGRectMake(115, cell.head.frame.origin.y+cell.head.frame.size.height+5, 140, cell.title.optimumSize.height);
        cell.price.text=[NSString stringWithFormat:@"$<font size=16 color=orange>%@</font>起",[[dataArray objectAtIndex:indexPath.row]valueForKey:@"USPrice"]];
        
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.cornerRadius=4;
        button.tag = indexPath.row;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame=CGRectMake(250, 50, 59, 25);
        //LineDetail_reserve.png
        button.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LineDetail_reserve.png"]];
        [button setTitle:@"预订" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goReserveHotel:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        
        return cell;
        
    }
    
    if ([self.navName isEqualToString:@"景点介绍"])
    {
        
        SceneryTicketCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (cell==nil)
        {
            cell=[[SceneryTicketCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.head.text=[[dataArray objectAtIndex:indexPath.row] valueForKey:@"ViewName"];
        
        NSString*start=[[[[[dataArray objectAtIndex:indexPath.row] valueForKey:@"StarTime"] componentsSeparatedByString:@" "] firstObject] stringByReplacingOccurrencesOfString:@"/" withString:@"."];
        NSString*end=[[[[[dataArray objectAtIndex:indexPath.row] valueForKey:@"EndTime"] componentsSeparatedByString:@" "] firstObject] stringByReplacingOccurrencesOfString:@"/" withString:@"."];
        
        //            @"有效期:2014.03.21-2014.04.01";
        
        cell.validData.text=[NSString stringWithFormat:@"有效期:%@~%@",start,end];
        cell.price.text=[NSString stringWithFormat:@"$<font size=20 color=orange>%@</font>",[[dataArray objectAtIndex:indexPath.row] valueForKey:@"UPrice"]];
        cell.button.tag = indexPath.row;
        [cell.button addTarget:self action:@selector(goReserveHotel:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }

    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    else
    {
        //删除cell的所有子视图
        while([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        
        
        
        
        
    }
    
    
    cell.backgroundColor=GroupColor;
    UIButton*view1=[self creatCellIndex:0 andArray:dataArray andIndexPath:indexPath.row*2];
    [cell addSubview:view1];
    
    int q=dataArray.count;
    float m=(float)q/2;
    int l=ceilf(m);
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (dataArray.count%2!=1||indexPath.row!=l-1)
    {
        
        UIButton*view2=[self creatCellIndex:1 andArray:dataArray andIndexPath:2*indexPath.row+1];;
        [cell.contentView addSubview:view2];
        
    }

    return cell;
}
#pragma mark --酒店房间预订--
- (void)goReserveHotel:(UIButton *)btn{
     NSIndexPath *indexPath = [_tableView indexPathForSelectedRow];
    if ([self.navName isEqualToString:@"酒店介绍"])
    {
        NSLog(@"%@",dataArray);

        NSString*str2=[[dataArray objectAtIndex:btn.tag]valueForKey:@"ToDate"];
//        str2=[[str2 componentsSeparatedByString:@" "] objectAtIndex:0];
//        str2=[str2 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
//        NSLog(@"indexPath.row  %d",btn.tag);
        [self roomDetailValidData:[[dataArray objectAtIndex:btn.tag]valueForKey:@"ProdType"] andApartment:[[dataArray objectAtIndex:btn.tag]valueForKey:@"Other"] andValid:[NSString stringWithFormat:@"%@",str2] andRemarkt:[[dataArray objectAtIndex:btn.tag]valueForKey:@"Note"] andName:[[dataArray objectAtIndex:btn.tag]valueForKey:@"RoomName"] andPrice:[[dataArray objectAtIndex:btn.tag]valueForKey:@"USPrice"]  andIndex:btn.tag];
    }else if ([self.title isEqualToString:@"景点介绍"]) {
//        NSLog(@"%@",dataArray);
        NSString*str2=[[dataArray objectAtIndex:btn.tag]valueForKey:@"ToDate"];
        [self sceneryDetailValidData:@"3" andApartment:[[dataArray objectAtIndex:btn.tag]valueForKey:@"OrderNote"] andValid:[NSString stringWithFormat:@"%@",str2] andRemarkt:[[dataArray objectAtIndex:btn.tag]valueForKey:@"Note"] andName:[[dataArray objectAtIndex:btn.tag]valueForKey:@"ViewName"] andPrice:[[dataArray objectAtIndex:btn.tag]valueForKey:@"UPrice"]  andIndex:btn.tag];
    }

    indexPath2 = indexPath;
}
#pragma mark--景点门票的详细内容
-(UIView*)sceneryDetailValidData:(NSString*)validData andApartment:(NSString*)Apartment andValid:(NSString*)Valid andRemarkt:(NSString*)remarkt andName:(NSString*)_name  andPrice:(NSString*)_price andIndex:(int)index
{
    
   // NSLog(@"dataarr  %@",dataArray);
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    view.tag=5;
    //view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"home_LineBack.png"]];
    view.backgroundColor = [UIColor colorWithRed:122.0/255 green:122.0/255 blue:122.0/255 alpha:.5];
    //基本视图
    UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(20, 20, 280, DeviceHeight-40-64)];
    view1.tag = 6;
    UITapGestureRecognizer * tapOnView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tapOnView.delegate = self;
    [view1 addGestureRecognizer:tapOnView];
    
    [view addSubview:view1];
    UITapGestureRecognizer * tapGrayView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tapGrayView.delegate = self;
    [view addGestureRecognizer:tapGrayView];
    // [tapGrayView requireGestureRecognizerToFail:tapOnView];
    view1.backgroundColor=[UIColor whiteColor];
    CALayer*layer=[view1 layer];
    [layer setCornerRadius:3.14];
    
    //房间类型
    NSString *Ftitle=@"";
    
    if ([[[dataArray objectAtIndex:index]valueForKey:@"Ftitle"] length]>0) {
        Ftitle = [NSString stringWithFormat:@"-%@",[[dataArray objectAtIndex:index]valueForKey:@"Ftitle"]];
    }
    // NSLog(@"Ftitle %@",[NSString stringWithFormat:@"%@%@",_name,Ftitle]);
    
    NSString *head = [NSString stringWithFormat:@"%@%@",_name,Ftitle];
    UILabel*name=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 230, 30)];
    name.text=[NSString stringWithFormat:@"%@",head];
    name.font=[UIFont boldSystemFontOfSize:17];
    [view1 addSubview:name];
    //关闭按钮
    UIButton*cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame=CGRectMake(255, 5, 20, 20);
    [cancel  addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setImage:[UIImage imageNamed:@"room_close.png"] forState:UIControlStateNormal];
    [view1 addSubview:cancel];
    

    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, cancel.frame.origin.y+cancel.frame.size.height+5, 280,  DeviceHeight-40-64-70)];
    scrollView.backgroundColor=BLACK_VIEW_COLOR;
    [view1 addSubview:scrollView];
    
    
    float svHeight = 0;
    //有效期
    UIImageView*validityImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15.5,15.5)];
    validityImage.image=[UIImage imageNamed:@"room_roomday.png"];
    [scrollView addSubview:validityImage];
    
    UILabel*validityLable1=[[UILabel alloc]initWithFrame:CGRectMake(33, 10, 70, 13)];
    validityLable1.text=@"有效期";
    validityLable1.font=[UIFont boldSystemFontOfSize:13];
    [scrollView addSubview:validityLable1];
    
    //预订按钮////////////////////////////////////
    UIButton*orderButton=[UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.layer.cornerRadius=4;
    orderButton.titleLabel.font = [UIFont systemFontOfSize:13];
    orderButton.frame=CGRectMake(210,scrollView.frame.origin.y+scrollView.frame.size.height+10, 59, 25);
    orderButton.tag = index;
    orderButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LineDetail_reserve.png"]];
    [orderButton addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
    [orderButton setTitle:@"预订" forState:UIControlStateNormal];
    ////////////////////////////////////////////////
    validityLable2=[[RTLabel alloc]initWithFrame:CGRectMake(103, 10, 280-103-5, 13)];
    validityLable2.textColor=[UIColor grayColor];
    validityLable2.font=[UIFont systemFontOfSize:13];
    //validityLable2.backgroundColor = [UIColor redColor];
    NSLog(@"Valid=======%@",validData);
    
    
    
    if ([validData integerValue]==1)
    {
        validityLable2.text=@"长期有效";

    } else if ([validData integerValue]==3)
    {
        
        NSString*str1=[[dataArray objectAtIndex:index]valueForKey:@"StarTime"];
        NSString*str2=[[dataArray objectAtIndex:index]valueForKey:@"EndTime"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
        [formatter2 setDateFormat:@"yyyy-MM-dd"];
        [formatter2 setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        validityLable2.text=[NSString stringWithFormat:@"%@~%@",[formatter stringFromDate:[formatter2 dateFromString:str1]],[formatter stringFromDate:[formatter2 dateFromString:str2]]];
        validityLable2.frame = CGRectMake(103, validityLable1.frame.origin.y, 280-103-5, validityLable2.optimumSize.height);
       // NSLog(@"%@",validityLable2.text);
    }

    [scrollView addSubview:validityLable2];
    
    //跳转日历
    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateBtn setTitle:@"查看日历模式>>" forState:UIControlStateNormal];
    [dateBtn setTitleColor:BLUE_SKY_COLOR forState:UIControlStateNormal];
    [dateBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [dateBtn addTarget:self action:@selector(gotoCalendar:) forControlEvents:UIControlEventTouchUpInside];
    dateBtn.tag =index;
    dateBtn.frame = CGRectMake(83, validityLable2.frame.origin.y+validityLable2.frame.size.height+10, 130, 13);
    [scrollView addSubview:dateBtn];
    svHeight = dateBtn.frame.origin.y+dateBtn.frame.size.height;
    
//    RTLabel *redLab = [[RTLabel alloc]initWithFrame:CGRectMake(103, svHeight+10, 280-103-5, 0)];
//    redLab.text = @"fajfjfal";
//    redLab.textColor = [UIColor redColor];
//    redLab.frame = CGRectMake(103, svHeight+10, 280-103-5, redLab.optimumSize.height);
//    [scrollView addSubview:redLab];
//    svHeight = redLab.frame.origin.y+redLab.frame.size.height;
    UIImageView*linek1=[[UIImageView alloc]init];
    linek1.frame=CGRectMake(10, svHeight+10, 260, 2);
    linek1.image=[UIImage imageNamed:@"entainmentLink.png"];
    [scrollView addSubview:linek1];
 
    
    
    svHeight = linek1.frame.origin.y+linek1.frame.size.height;
  
    
    
    //支付
    UIImageView*roomOrderImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, svHeight+10, 15.5,15.5)];
    roomOrderImage.image=[UIImage imageNamed:@"resever.png"];
    [scrollView addSubview:roomOrderImage];
    
    UILabel*roomOrederLable1=[[UILabel alloc]initWithFrame:CGRectMake(33, roomOrderImage.frame.origin.y, 60, 15)];
    roomOrederLable1.text=@"支付方式";
    roomOrederLable1.font=[UIFont boldSystemFontOfSize:13];
    [scrollView addSubview:roomOrederLable1];
    
    
    
    int oredrTypeCount = [[[dataArray objectAtIndex:index] objectForKey:@"OrderType"] intValue];
    NSArray *orderNameArr = @[@"在线支付",@"当面支付"];
    for (int i = 0; i<oredrTypeCount; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(103, roomOrderImage.frame.origin.y+i*25, 15.5, 15.5)];
        iv.image = [UIImage imageNamed:@"greenGou"];
        [scrollView addSubview:iv];
        
        RTLabel*roomOrederLable2=[[RTLabel alloc]initWithFrame:CGRectMake(118.5, roomOrderImage.frame.origin.y+i*25+3, 60, 15)];
        roomOrederLable2.text = orderNameArr[i];
        roomOrederLable2.font=[UIFont systemFontOfSize:13];
        roomOrederLable2.textColor=[UIColor grayColor];
        [scrollView addSubview:roomOrederLable2];
        
        if (i==1) {
            RTLabel*roomOrederLable3=[[RTLabel alloc]initWithFrame:CGRectMake(108.5, roomOrderImage.frame.origin.y+i*25, 157, 15)];
            
            roomOrederLable3.text = [NSString stringWithFormat:@"               %@",[dataArray[index] objectForKey:@"OrderMark"]];
            roomOrederLable3.font=[UIFont systemFontOfSize:13];
            roomOrederLable3.textColor=[UIColor grayColor];
            roomOrederLable3.frame = CGRectMake(118.5, roomOrderImage.frame.origin.y+25, 157, roomOrederLable3.optimumSize.height);
            // NSLog(@"[dataArray[index] objectForKey:OrderMark] %f",roomOrederLable3.optimumSize.height);
            [scrollView addSubview:roomOrederLable3];
            svHeight = roomOrederLable3.frame.origin.y+roomOrederLable3.frame.size.height;
            
        }else svHeight = roomOrederLable2.frame.origin.y+roomOrederLable2.frame.size.height;
    }
    
    UIImageView*linek2=[[UIImageView alloc]init];
    linek2.frame=CGRectMake(10, svHeight+10, 260, 2);
    linek2.image=[UIImage imageNamed:@"entainmentLink.png"];
    [scrollView addSubview:linek2];
    
    //前预订
    if (Valid.length)
    {
        UIImageView*validityImage2=[[UIImageView alloc]initWithFrame:CGRectMake(10, svHeight+20, 15.5,15.5)];
        validityImage2.image=[UIImage imageNamed:@"room_orderday.png"];
        [scrollView addSubview:validityImage2];
        UILabel*validityLable3=[[UILabel alloc]initWithFrame:CGRectMake(33, validityImage2.frame.origin.y, 280-33, 15)];
        validityLable3.textColor=[UIColor redColor];
        validityLable3.text=[NSString stringWithFormat:@"游玩当日%@前预订有效",Valid];
        
        validityLable3.font=[UIFont systemFontOfSize:13];
        [scrollView addSubview:validityLable3];
        
        svHeight = validityLable3.frame.origin.y+validityLable3.frame.size.height;
        UIImageView*linek1=[[UIImageView alloc]init];
        linek1.frame=CGRectMake(10, svHeight+10, 260, 2);
        linek1.image=[UIImage imageNamed:@"entainmentLink.png"];
        [scrollView addSubview:linek1];
    }
    
    
    if (remarkt.length) {
        //备注
        UIImageView*remarkImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, svHeight+20, 15.5,15.5)];
        remarkImage.image=[UIImage imageNamed:@"room_remarks.png"];
        [scrollView addSubview:remarkImage];
        UILabel*remarkLable1=[[UILabel alloc]initWithFrame:CGRectMake(33, remarkImage.frame.origin.y, 60, 15)];
        remarkLable1.text=@"备注";
        remarkLable1.font=[UIFont boldSystemFontOfSize:13];
        [scrollView addSubview:remarkLable1];
        
        
        RTLabel*remarkLable2=[[RTLabel alloc]initWithFrame:CGRectMake(33, remarkLable1.frame.origin.y+5, 280-33-20, 0)];
        remarkLable2.text=remarkt;
        remarkLable2.font=[UIFont systemFontOfSize:13];
        remarkLable2.textColor=[UIColor grayColor];
        CGSize remarksize=[remarkLable2 optimumSize];
        remarkLable2.frame=CGRectMake(33, remarkLable1.frame.origin.y+5+remarkLable1.frame.size.height, 280-33-20, remarksize.height);
        
        [scrollView addSubview:remarkLable2];
        svHeight=remarkLable2.frame.origin.y+remarkLable2.frame.size.height;
        scrollView.contentSize=CGSizeMake(280, svHeight+20);
        
    }else scrollView.contentSize=CGSizeMake(280, svHeight+20);
    
    UIImageView*linek3=[[UIImageView alloc]init];
    linek3.frame=CGRectMake(10, svHeight+10, 260, 2);
    linek3.image=[UIImage imageNamed:@"entainmentLink.png"];
    [scrollView addSubview:linek3];
    [self.view addSubview:view];
    
    if ([[dataArray[index] objectForKey:@"OrderNote"] length]) {
        //预订须知
        UIImageView*remarkImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, svHeight+20, 15.5,15.5)];
        remarkImage.image=[UIImage imageNamed:@"预订须知"];
        [scrollView addSubview:remarkImage];
        UILabel*remarkLable1=[[UILabel alloc]initWithFrame:CGRectMake(33, remarkImage.frame.origin.y, 60, 15)];
        remarkLable1.text=@"预订须知";
        remarkLable1.font=[UIFont boldSystemFontOfSize:13];
        [scrollView addSubview:remarkLable1];
        
        
        RTLabel*remarkLable2=[[RTLabel alloc]initWithFrame:CGRectMake(33, remarkLable1.frame.origin.y+5, 280-33-20, 0)];
        remarkLable2.text=[dataArray[index] objectForKey:@"OrderNote"];
        remarkLable2.font=[UIFont systemFontOfSize:11];
        remarkLable2.textColor=[UIColor grayColor];
        CGSize remarksize=[remarkLable2 optimumSize];
        remarkLable2.frame=CGRectMake(33, remarkLable1.frame.origin.y+5+remarkLable1.frame.size.height, 280-33-20, remarksize.height);
        
        [scrollView addSubview:remarkLable2];
        svHeight=remarkLable2.frame.origin.y+remarkLable2.frame.size.height;
        scrollView.contentSize=CGSizeMake(280, svHeight+20);
        
    }else scrollView.contentSize=CGSizeMake(280, svHeight+20);
    
    
    
    //价格和预订
    RTLabel*price=[[RTLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 0)];
    price.text=[NSString stringWithFormat: @"$<font size=20 color=orange >%@</font>起",_price];
    price.font = [UIFont systemFontOfSize:14];
    CGSize priceSize=[price optimumSize];
    price.frame=CGRectMake(10, (40.0-priceSize.height)/2+scrollView.frame.origin.y+scrollView.frame.size.height, 100, priceSize.height);
    [view1 addSubview:price];
    
    
    
    [view1 addSubview:orderButton];
    
    
    return view;
}
#pragma mark--房间的详细内容
-(UIView*)roomDetailValidData:(NSString*)validData andApartment:(NSString*)Apartment andValid:(NSString*)Valid andRemarkt:(NSString*)remarkt andName:(NSString*)_name  andPrice:(NSString*)_price andIndex:(int)index
{
    
    NSLog(@"dataarr  %@",dataArray);
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    view.tag=5;
    //view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"home_LineBack.png"]];
    view.backgroundColor = [UIColor colorWithRed:122.0/255 green:122.0/255 blue:122.0/255 alpha:.5];
    //基本视图
    UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(20, 20, 280, DeviceHeight-40-64)];
    view1.tag = 6;
    UITapGestureRecognizer * tapOnView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tapOnView.delegate = self;
    [view1 addGestureRecognizer:tapOnView];
    
    [view addSubview:view1];
    UITapGestureRecognizer * tapGrayView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tapGrayView.delegate = self;
    [view addGestureRecognizer:tapGrayView];
    // [tapGrayView requireGestureRecognizerToFail:tapOnView];
    view1.backgroundColor=[UIColor whiteColor];
    CALayer*layer=[view1 layer];
    [layer setCornerRadius:3.14];
    
    //房间类型
    NSString *Ftitle=@"";
    
    if ([[[dataArray objectAtIndex:index]valueForKey:@"Ftitle"] length]>0) {
        Ftitle = [NSString stringWithFormat:@"-%@",[[dataArray objectAtIndex:index]valueForKey:@"Ftitle"]];
    }
   // NSLog(@"Ftitle %@",[NSString stringWithFormat:@"%@%@",_name,Ftitle]);
    
    NSString *head = [NSString stringWithFormat:@"%@%@",_name,Ftitle];
    UILabel*name=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 230, 30)];
    name.text=[NSString stringWithFormat:@"%@",head];
    name.font=[UIFont boldSystemFontOfSize:17];
    [view1 addSubview:name];
    //关闭按钮
    UIButton*cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame=CGRectMake(255, 5, 20, 20);
    [cancel  addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [cancel setImage:[UIImage imageNamed:@"room_close.png"] forState:UIControlStateNormal];
    [view1 addSubview:cancel];
    
    
    
    
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, cancel.frame.origin.y+cancel.frame.size.height+5, 280,  DeviceHeight-40-64-70)];
    scrollView.backgroundColor=BLACK_VIEW_COLOR;
    [view1 addSubview:scrollView];
    
    //大图
    UIImageView*_imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 280, 193)];
    _imageView.image=BACK_IMAGE;
    [LINE_VIEW_C loadPic_tableViewDataArray:dataArray objectAtIndex:indexPath2.row objectForKey:@"RoomPic" picHeadUrlStr:PicUrl picUrlPathStr:@"Hotel" PicLoadName:_name headView:_imageView];
    [scrollView addSubview:_imageView];
    
    
    float svHeight = 0;
    //有效期
    UIImageView*validityImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, _imageView.frame.origin.y+_imageView.frame.size.height+10, 15.5,15.5)];
    validityImage.image=[UIImage imageNamed:@"room_roomday.png"];
    [scrollView addSubview:validityImage];
    
    UILabel*validityLable1=[[UILabel alloc]initWithFrame:CGRectMake(33, _imageView.frame.origin.y+_imageView.frame.size.height+13, 70, 13)];
    validityLable1.text=@"可入住日期";
    validityLable1.font=[UIFont boldSystemFontOfSize:13];
    [scrollView addSubview:validityLable1];
    
    //预订按钮////////////////////////////////////
    UIButton*orderButton=[UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.layer.cornerRadius=4;
    orderButton.titleLabel.font = [UIFont systemFontOfSize:13];
    orderButton.frame=CGRectMake(210,scrollView.frame.origin.y+scrollView.frame.size.height+10, 59, 25);
    orderButton.tag = index;
    orderButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LineDetail_reserve.png"]];
    [orderButton addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
    [orderButton setTitle:@"预订" forState:UIControlStateNormal];
    ////////////////////////////////////////////////
    validityLable2=[[RTLabel alloc]initWithFrame:CGRectMake(103, validityLable1.frame.origin.y, 280-103-5, 13)];
    validityLable2.textColor=[UIColor grayColor];
    validityLable2.font=[UIFont systemFontOfSize:13];
    //validityLable2.backgroundColor = [UIColor redColor];
     NSLog(@"Valid=======%@",validData);
    
    //跳转日历
    UIButton *dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateBtn setTitle:@"查看日历模式>>" forState:UIControlStateNormal];
    [dateBtn setTitleColor:BLUE_SKY_COLOR forState:UIControlStateNormal];
    [dateBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [dateBtn addTarget:self action:@selector(gotoCalendar:) forControlEvents:UIControlEventTouchUpInside];
    dateBtn.tag =index;
    dateBtn.frame = CGRectMake(83, validityLable2.frame.origin.y+validityLable2.frame.size.height+10, 130, 13);
    
    svHeight = dateBtn.frame.origin.y+dateBtn.frame.size.height;
    
    if ([validData integerValue]==1)
    {
        validityLable2.text=@"长期有效";
        [scrollView addSubview:dateBtn];
    } else if ([validData integerValue]==3)
    {
        
        NSString*str1=[[dataArray objectAtIndex:index]valueForKey:@"StartDate"];
        NSString*str2=[[dataArray objectAtIndex:index]valueForKey:@"EndDate"];
        validityLable2.text=[NSString stringWithFormat:@"%@至%@",str1,str2];
        validityLable2.frame = CGRectMake(103, validityLable1.frame.origin.y, 280-103-5, validityLable2.optimumSize.height);
        //NSLog(@"%@",validityLable2.text);
        dateBtn.frame = CGRectMake(103, validityLable2.frame.origin.y+validityLable2.frame.size.height+10, 130, 13);
        svHeight = dateBtn.frame.origin.y+dateBtn.frame.size.height;
        [scrollView addSubview:dateBtn];
    }
    //指定日期
   else if ([validData integerValue]==2)
    {
        
        NSMutableString*str=RussiaUrl3;
        NSURL*url=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@?ID=%@",str,@"getHotelprodatelist",[dataArray[index] objectForKey:@"ID"]]];
          NSData *data=[NSData dataWithContentsOfURL:url];
            dicResultTongbuNoDic(data, result);
        NSLog(@"result  %@",result);
                if ([result intValue]==0) {
                    
                    orderButton.backgroundColor=[UIColor grayColor];
                    orderButton.enabled=NO;
                    validityLable2.text = @"无可入住日期";
                   // [dateBtn removeFromSuperview];
                    svHeight = validityLable2.frame.origin.y+validityLable2.frame.size.height;

                }else{
                    
                    validityLable2.text=result;
                    validityLable2.frame = CGRectMake(103, validityLable1.frame.origin.y, 280-103-5, validityLable2.optimumSize.height);
                    dateBtn.frame = CGRectMake(103, validityLable2.frame.origin.y+validityLable2.frame.size.height+10, 130, 13);
                    svHeight = dateBtn.frame.origin.y+dateBtn.frame.size.height;
                    [scrollView addSubview:dateBtn];
                    
                }
    }
    
    
    [scrollView addSubview:validityLable2];
    UIImageView*linek1=[[UIImageView alloc]init];
    linek1.frame=CGRectMake(10, svHeight+10, 260, 2);
    linek1.image=[UIImage imageNamed:@"entainmentLink.png"];
    [scrollView addSubview:linek1];
    //入住人数
    UIImageView *peopleImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, svHeight+20, 15.5, 15.5)];
    peopleImage.image = [UIImage imageNamed:@"住宿预订第1步_03-09"];
    [scrollView addSubview:peopleImage];
    UILabel*peopleName=[[UILabel alloc]initWithFrame:CGRectMake(33, peopleImage.frame.origin.y, 70, 15)];
    peopleName.text=@"最多可入住";
    peopleName.font=[UIFont boldSystemFontOfSize:13];
    [scrollView addSubview:peopleName];
    
    UILabel*peopleCount=[[UILabel alloc]initWithFrame:CGRectMake(103, peopleImage.frame.origin.y, 60, 15)];
    peopleCount.text=[NSString stringWithFormat:@"%@人",[dataArray[index]  objectForKey:@"MoneyType"]];
    peopleCount.textColor = [UIColor grayColor];
    peopleCount.font=[UIFont boldSystemFontOfSize:13];
    [scrollView addSubview:peopleCount];
    
    svHeight = peopleCount.frame.origin.y+peopleCount.frame.size.height;
    UIImageView*linek=[[UIImageView alloc]init];
    linek.frame=CGRectMake(10, svHeight+10, 260, 2);
    linek.image=[UIImage imageNamed:@"entainmentLink.png"];
    [scrollView addSubview:linek];
    
    //房间设施
    UIImageView *roomApartmentImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, svHeight+20, 15.5,15.5)];
    roomApartmentImage.image=[UIImage imageNamed:@"room_room.png"];
    [scrollView addSubview:roomApartmentImage];
    
    UILabel*roomApartmentLable1=[[UILabel alloc]initWithFrame:CGRectMake(33, roomApartmentImage.frame.origin.y, 60, 15)];
    roomApartmentLable1.text=@"房间设施";
    roomApartmentLable1.font=[UIFont boldSystemFontOfSize:13];
    [scrollView addSubview:roomApartmentLable1];
    
    
    RTLabel*roomApartmentLable2=[[RTLabel alloc]initWithFrame:CGRectMake(33, roomApartmentLable1.frame.origin.y+15, 280-33-20, 0)];
    roomApartmentLable2.text=Apartment;
    roomApartmentLable2.font=[UIFont systemFontOfSize:13];
    roomApartmentLable2.textColor=[UIColor grayColor];
    CGSize size=[roomApartmentLable2 optimumSize];
    roomApartmentLable2.frame=CGRectMake(33, roomApartmentLable1.frame.origin.y+5+roomApartmentLable1.frame.size.height, 280-33-20, size.height);
    
    [scrollView addSubview:roomApartmentLable2];
    
    //支付
    UIImageView*roomOrderImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, roomApartmentLable2.frame.origin.y+roomApartmentLable2.frame.size.height+20, 15.5,15.5)];
    roomOrderImage.image=[UIImage imageNamed:@"resever.png"];
    [scrollView addSubview:roomOrderImage];
    
    UILabel*roomOrederLable1=[[UILabel alloc]initWithFrame:CGRectMake(33, roomOrderImage.frame.origin.y, 60, 15)];
    roomOrederLable1.text=@"支付方式";
    roomOrederLable1.font=[UIFont boldSystemFontOfSize:13];
    [scrollView addSubview:roomOrederLable1];
    
    
    
    int oredrTypeCount = [[[dataArray objectAtIndex:index] objectForKey:@"OrderType"] intValue];
    NSArray *orderNameArr = @[@"在线支付",@"当面支付"];
    for (int i = 0; i<oredrTypeCount; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(103, roomOrderImage.frame.origin.y+i*25, 15.5, 15.5)];
        iv.image = [UIImage imageNamed:@"greenGou"];
        [scrollView addSubview:iv];
        
        RTLabel*roomOrederLable2=[[RTLabel alloc]initWithFrame:CGRectMake(118.5, roomOrderImage.frame.origin.y+i*25+3, 60, 15)];
        roomOrederLable2.text = orderNameArr[i];
        roomOrederLable2.font=[UIFont systemFontOfSize:13];
        roomOrederLable2.textColor=[UIColor grayColor];
        [scrollView addSubview:roomOrederLable2];
        
        if (i==1) {
            RTLabel*roomOrederLable3=[[RTLabel alloc]initWithFrame:CGRectMake(108.5, roomOrderImage.frame.origin.y+i*25, 157, 15)];
            
            roomOrederLable3.text = [NSString stringWithFormat:@"               %@",[dataArray[index] objectForKey:@"OrderMark"]];
            roomOrederLable3.font=[UIFont systemFontOfSize:13];
            roomOrederLable3.textColor=[UIColor grayColor];
            roomOrederLable3.frame = CGRectMake(118.5, roomOrderImage.frame.origin.y+25, 157, roomOrederLable3.optimumSize.height);
           // NSLog(@"[dataArray[index] objectForKey:OrderMark] %f",roomOrederLable3.optimumSize.height);
            [scrollView addSubview:roomOrederLable3];
            svHeight = roomOrederLable3.frame.origin.y+roomOrederLable3.frame.size.height;
            
        }else svHeight = roomOrederLable2.frame.origin.y+roomOrederLable2.frame.size.height;
    }
    
    UIImageView*linek2=[[UIImageView alloc]init];
    linek2.frame=CGRectMake(10, svHeight+10, 260, 2);
    linek2.image=[UIImage imageNamed:@"entainmentLink.png"];
    [scrollView addSubview:linek2];

    //前预订
        if (Valid.length)
    {
        UIImageView*validityImage2=[[UIImageView alloc]initWithFrame:CGRectMake(10, svHeight+20, 15.5,15.5)];
        validityImage2.image=[UIImage imageNamed:@"room_orderday.png"];
        [scrollView addSubview:validityImage2];
        UILabel*validityLable3=[[UILabel alloc]initWithFrame:CGRectMake(33, validityImage2.frame.origin.y, 280-33, 15)];
        validityLable3.textColor=[UIColor redColor];
        validityLable3.text=[NSString stringWithFormat:@"入住当日%@前预订有效",Valid];

        validityLable3.font=[UIFont systemFontOfSize:13];
        [scrollView addSubview:validityLable3];
        
        svHeight = validityLable3.frame.origin.y+validityLable3.frame.size.height;
        UIImageView*linek1=[[UIImageView alloc]init];
        linek1.frame=CGRectMake(10, svHeight+10, 260, 2);
        linek1.image=[UIImage imageNamed:@"entainmentLink.png"];
        [scrollView addSubview:linek1];
    }

    
    if (remarkt.length) {
        //备注
        UIImageView*remarkImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, svHeight+20, 15.5,15.5)];
        remarkImage.image=[UIImage imageNamed:@"room_remarks.png"];
        [scrollView addSubview:remarkImage];
        UILabel*remarkLable1=[[UILabel alloc]initWithFrame:CGRectMake(33, remarkImage.frame.origin.y, 60, 15)];
        remarkLable1.text=@"备注";
        remarkLable1.font=[UIFont boldSystemFontOfSize:13];
        [scrollView addSubview:remarkLable1];
        
        
        RTLabel*remarkLable2=[[RTLabel alloc]initWithFrame:CGRectMake(33, remarkLable1.frame.origin.y+5, 280-33-20, 0)];
        remarkLable2.text=remarkt;
        remarkLable2.font=[UIFont systemFontOfSize:13];
        remarkLable2.textColor=[UIColor grayColor];
        CGSize remarksize=[remarkLable2 optimumSize];
        remarkLable2.frame=CGRectMake(33, remarkLable1.frame.origin.y+5+remarkLable1.frame.size.height, 280-33-20, remarksize.height);
        
        [scrollView addSubview:remarkLable2];
        svHeight=remarkLable2.frame.origin.y+remarkLable2.frame.size.height;
        scrollView.contentSize=CGSizeMake(280, svHeight+20);
        
    }else scrollView.contentSize=CGSizeMake(280, svHeight+20);
   
    UIImageView*linek3=[[UIImageView alloc]init];
    linek3.frame=CGRectMake(10, svHeight+10, 260, 2);
    linek3.image=[UIImage imageNamed:@"entainmentLink.png"];
    [scrollView addSubview:linek3];
    [self.view addSubview:view];
    
    if ([[dataArray[index] objectForKey:@"OrderNote"] length]) {
        //备注
        UIImageView*remarkImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, svHeight+20, 15.5,15.5)];
        remarkImage.image=[UIImage imageNamed:@"预订须知"];
        [scrollView addSubview:remarkImage];
        UILabel*remarkLable1=[[UILabel alloc]initWithFrame:CGRectMake(33, remarkImage.frame.origin.y, 60, 15)];
        remarkLable1.text=@"预订须知";
        remarkLable1.font=[UIFont boldSystemFontOfSize:13];
        [scrollView addSubview:remarkLable1];
        
        
        RTLabel*remarkLable2=[[RTLabel alloc]initWithFrame:CGRectMake(33, remarkLable1.frame.origin.y+5, 280-33-20, 0)];
        remarkLable2.text=[dataArray[index] objectForKey:@"OrderNote"];
        remarkLable2.font=[UIFont systemFontOfSize:11];
        remarkLable2.textColor=[UIColor grayColor];
        CGSize remarksize=[remarkLable2 optimumSize];
        remarkLable2.frame=CGRectMake(33, remarkLable1.frame.origin.y+5+remarkLable1.frame.size.height, 280-33-20, remarksize.height);
        
        [scrollView addSubview:remarkLable2];
        svHeight=remarkLable2.frame.origin.y+remarkLable2.frame.size.height;
        scrollView.contentSize=CGSizeMake(280, svHeight+20);
        
    }else scrollView.contentSize=CGSizeMake(280, svHeight+20);
    
    
    
    //价格和预订
    RTLabel*price=[[RTLabel alloc]initWithFrame:CGRectMake(10, 0, 100, 0)];
    price.text=[NSString stringWithFormat: @"$<font size=20 color=orange >%@</font>起",_price];
    price.font = [UIFont systemFontOfSize:14];
    CGSize priceSize=[price optimumSize];
    price.frame=CGRectMake(10, (40.0-priceSize.height)/2+scrollView.frame.origin.y+scrollView.frame.size.height, 100, priceSize.height);
    [view1 addSubview:price];
    
    
    
    [view1 addSubview:orderButton];
    
    
    //加线
    UIImageView*linek4=[[UIImageView alloc]init];
    linek4.frame=CGRectMake(10, roomApartmentLable2.frame.size.height+roomApartmentLable2.frame.origin.y+10, 260, 2);
    linek4.image=[UIImage imageNamed:@"entainmentLink.png"];
    [scrollView addSubview:linek4];
    return view;
}
#pragma mark --进入可入住日期日历--
- (void)gotoCalendar:(UIButton*)btn
{
    hotelCarender = [[hotelCarenderViewController alloc]init];
    if ([self.title isEqual:@"酒店介绍"])
    {
        hotelCarender.prodType = [dataArray[btn.tag] objectForKey:@"ProdType"];
        hotelCarender.title = @"可入住日期";
        hotelCarender.HotelRUName = [dataDic valueForKey:@"HotelRUName"];
        hotelCarender.HotelCNName  = [dataDic valueForKey:@"HotelCNName"];
    }
    else if([self.title isEqual:@"景点介绍"])
    {
        hotelCarender.prodType = @"1";
        hotelCarender.title = @"游玩日期";
        hotelCarender.HotelRUName = [dataDic valueForKey:@"ViewRUName"];
        hotelCarender.HotelCNName  = [dataDic valueForKey:@"ViewCNName"];
        hotelCarender.showTime = [dataDic valueForKey:@"ShowTime"];
    }
    hotelCarender.ID = [dataArray[btn.tag] objectForKey:@"ID"];
    hotelCarender.dataDic = dataArray[btn.tag];
    [self.navigationController pushViewController:hotelCarender animated:NO];
}
-(void)lookMoreComment:(UIButton*)sender
{
    
    SeceneryComentCell *cell = (SeceneryComentCell *)[sender superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSLog(@"indexPath is = %i",indexPath.row);
    
    [commentArray removeAllObjects];
    NSDictionary*dic1=[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"tag",@"有两个地方要改的有两个地方要改的有两个地方要改的",@"text", nil];
    [commentArray addObject:dic1];
    [commentArray addObject:dic1];
    [commentArray addObject:dic1];
    
    for (int i=0; i<10; i++)
    {
        NSDictionary*dic;
        if (i==10)
        {
            dic=[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"tag",@"有两个地方要改的有两个地方要改的有两个地方要改的",@"text",@"1",@"tag2", nil];
        }
        else
        {
            dic=[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"tag",@"有两个地方要改的有两个地方要改的有两个地方要改的",@"text",@"0",@"tag2", nil];
            
        }
        [commentArray addObject:dic];
    }
    [commentArray addObject:dic1];
    
    [_tableView reloadData];
    
}
//下bar按钮
-(void)touch:(UIButton*)sender
{
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    switch (sender.tag)
    {
            
            
        case 400:
        {
            
     
                ComentViewController*text=[ComentViewController new];
                if ([self.navName isEqualToString:@"酒店介绍"])
                {
                    text.pageName=@"酒店评论";
                    NSLog(@"dataDic == %@",dataDic);
                    NSLog(@"%@  \n%@",[dataDic valueForKey:@"HotelCNName"] ,[dataDic valueForKey:@"HotelRUName"] );
                    text.head = [dataDic valueForKey:@"HotelCNName"];
                    text.eTittle = [dataDic valueForKey:@"HotelRUName"];
                    text.type=2;
                    
                    
                }
                if (self.tag==1)
                {
                    text.pageName=@"娱乐评论";
                    text.head=[dataDic valueForKey:@"TicketCName"];
                    text.eTittle=[dataDic valueForKey:@"TicketRName"];
                    text.type=3;
                }
                if ([self.navName isEqualToString:@"线路介绍"])
                {
                    text.pageName=@"线路评论";
                    text.head=[dataDic valueForKey:@"Title"];
                    text.type=1;
                }
                
                if ([self.navName isEqualToString:@"餐厅介绍"])
                {
                    text.pageName=@"餐厅评论";
                    text.head=[dataDic valueForKey:@"RestCName"];
                    text.eTittle=[dataDic valueForKey:@"RestRName"];
                    text.type=4;
                }
                if ([self.navName isEqualToString:@"购物介绍"])
                {
                    text.pageName=@"购物评论";
                    text.head=[dataDic valueForKey:@"ShopCName"];
                    text.eTittle=[dataDic valueForKey:@"ShopRName"];
                    text.type=5;
                }
                if ([self.navName isEqualToString:@"景点介绍"])
                {
                    text.pageName=@"景点评论";
                    text.head=[dataDic valueForKey:@"ViewCNName"];
                    text.eTittle=[dataDic valueForKey:@"ViewRUName"];
                    text.type=8;
                }
                if ([self.navName isEqualToString:[NSString stringWithFormat:@"%@租车",[_dataDic2 valueForKey:@"UName"]]])
                {
                    text.pageName=@"租车评论";
                    text.head=[_dataDic2 valueForKey:@"UName"];
                  //  text.eTittle=[dataDic valueForKey:@"ViewRUName"];
                    text.type=7;
                }
                
                
                text.ID=self.hotelID;
                [self.navigationController pushViewController:text animated:NO];
                
                
            
            
            
            
            
            
        }
            break;
            
        case 401:
        {
            
            int ss=[defaults integerForKey:@"QuseID"];
            if (ss)
            {
                
                
                if ([checkLikeNum isEqualToString:@"没有喜欢"])
                {
                    NSString*ID=[NSString stringWithFormat:@"%d",self.hotelID];
                    NSString*canshu=[NSString stringWithFormat:@"cityid=%d&ID=%@&userid=%d&username=%@&typeid=%d&classid=%d",2,ID,ss,[defaults valueForKey:@"useName"],1,self.classID];
                    
                    NSString *urlMethod=@"getTravelColloLike";
                    NSMutableString*urlDomain2=RussiaUrl2
                    [urlDomain2 appendString:urlMethod];
                    postRequestYiBu(canshu, urlDomain2)
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
            
            
            
            int ss=[defaults integerForKey:@"QuseID"];
            if (ss)
            {
                
                
                if ([checkCollectNum isEqualToString:@"没有收藏"])
                {
                    
                    
                    NSString*ID=[NSString stringWithFormat:@"%d",self.hotelID];
                    NSString*canshu=[NSString stringWithFormat:@"cityid=%d&ID=%@&userid=%d&username=%@&typeid=%d&classid=%d",2,ID,ss,[defaults valueForKey:@"useName"],2,self.classID];
                    
                    NSString *urlMethod=@"getTravelColloLike";
                    NSMutableString*urlDomain2=RussiaUrl2
                    [urlDomain2 appendString:urlMethod];
                    postRequestYiBu(canshu, urlDomain2)
                    
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
    if (alertView.tag==10) {//预订
        if (buttonIndex==1) {
            MineViewController *mvc = [MineViewController new];
            mvc.tabBarController.tabBar.hidden=YES;
            mvc.tag=1;
            [self.navigationController pushViewController:mvc animated:YES];
        }
    }else{
        int _f=[DEFAUT integerForKey:@"QuseID"];
        switch (buttonIndex)
        {
            case 1:
            {
                if (alertView.tag==20)
                {
                    
                    
                    NSString*ID=[NSString stringWithFormat:@"%d",self.hotelID];
                    NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&typeid=%d&classid=%d",ID,_f,1,self.classID];
                    NSMutableString*urlDomain2=RussiaUrl2
                    NSString *urlMethod=@"UnColloLike";
                    [urlDomain2 appendString:urlMethod];
                    postRequestYiBu(canshu, urlDomain2)
                    isLike=YES;
                    
                }
                
                if (alertView.tag==21)
                {
                    NSString*ID=[NSString stringWithFormat:@"%d",self.hotelID];
                    NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&typeid=%d&classid=%d",ID,_f,2,self.classID];
                    NSMutableString*urlDomain2=RussiaUrl2
                    NSString *urlMethod=@"UnColloLike";
                    [urlDomain2 appendString:urlMethod];
                    postRequestYiBu(canshu, urlDomain2)
                    
                    
                }
                
                
            }
                break;
                
            default:
                break;
        }
    }
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
-(void)line:(UIButton*)sender
{
    
    if ([self.navName isEqualToString:@"线路介绍"])
    {
        
        EveryDayViewController*every=[EveryDayViewController new];
        every.ID=self.hotelID;
        every.Lineday=[[[dataArray objectAtIndex:sender.tag-20000]valueForKey:@"LineDay"] intValue];
        [self.navigationController pushViewController:every animated:NO];
        
    }
    
    
}
#pragma mark--线路详细行程
-(UIButton*)creatCellIndex:(int)index andArray:(NSArray*)_dataArray andIndexPath:(int)indexPath
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.tag=20000+indexPath;
    [button addTarget:self action:@selector(line:) forControlEvents:UIControlEventTouchUpInside];
    button.frame=CGRectMake(10+index*155, 10, 146.5, 71.5);
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"day%d.png",indexPath%6+1]] forState:UIControlStateNormal];
    
    
    UILabel*head=[[UILabel alloc]initWithFrame:CGRectMake(23, 5, 80, 30)];
    head.textColor=[UIColor whiteColor];
    head.font=[UIFont boldSystemFontOfSize:18];
    head.text=[NSString stringWithFormat:@"第%@天",[[_dataArray objectAtIndex:indexPath]valueForKey:@"LineDay"]];
    [button addSubview:head];
    
    UILabel*title=[[UILabel alloc]initWithFrame:CGRectMake(23, 30, 115, 40)];
    title.numberOfLines=2;
    title.font=[UIFont systemFontOfSize:15];
    title.textColor=[UIColor whiteColor];
    title.text=[[_dataArray objectAtIndex:indexPath]valueForKey:@"Title"];
    CGSize size=[title sizeThatFits:CGSizeMake(115, 0)];
    title.frame=CGRectMake(23, 30, 115, size.height);
    [button addSubview:title];
    return button;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
#pragma mark---预订/酒店 景点
-(void)order:(UIButton*)btn
{
    NSLog(@"dataDic  %@",dataDic);
    if (GET_USER_DEFAUT(USER_NAME)) {

        if ([self.title isEqualToString:@"景点介绍"]) {
            NSString *ID = [dataArray[btn.tag] objectForKey:@"ID"];
            
            NSString *Ftitle=@"";
            
            if ([[[dataArray objectAtIndex:btn.tag]valueForKey:@"Ftitle"] length]>0) {
                Ftitle = [NSString stringWithFormat:@"-%@",[[dataArray objectAtIndex:btn.tag]valueForKey:@"Ftitle"]];
            }
            SceneryReceverClass * rrc = [SceneryReceverClass new];
            rrc.ID=[NSString stringWithFormat:@"%@",ID];
            rrc.title = @"景点门票预订";
            NSString *head = [NSString stringWithFormat:@"%@%@",[[dataArray objectAtIndex:btn.tag]valueForKey:@"ViewName"],Ftitle];
            rrc.roomTypeStr = head;
            rrc.russianStr = [dataDic valueForKey:@"ViewRUName"];
            // NSLog(@"%@",[dataDic valueForKey:@"HotelRUName"]);
            rrc.chineseStr  = [dataDic valueForKey:@"ViewCNName"];
            rrc.payWay =[[dataArray objectAtIndex:btn.tag]valueForKey:@"OrderType"];
            rrc.showTime = [NSString stringWithFormat:@"%@",[dataDic valueForKey:@"ShowTime"]];
            rrc.reseverKnowStr = [dataArray[btn.tag] objectForKey:@"OrderNote"];
            rrc.RMB = [[dataArray objectAtIndex:btn.tag] valueForKey:@"ZPrice"];
            rrc.dollar = [[dataArray objectAtIndex:btn.tag] objectForKey:@"UPrice"];
            rrc.startDate=[[dataArray objectAtIndex:btn.tag]valueForKey:@"StarTime"];
            rrc.endDate=[[dataArray objectAtIndex:btn.tag]valueForKey:@"EndTime"];
            rrc.ToDateStr = [[dataArray objectAtIndex:btn.tag]valueForKey:@"ToDate"];
            rrc.startDate2Str = [[dataArray objectAtIndex:btn.tag]valueForKey:@"StartDate2"];
            rrc.dataDic = dataArray[btn.tag];
            [self.navigationController pushViewController:rrc animated:NO];
        }else if ([self.title isEqualToString:@"酒店介绍"]){
            NSString *ID = [dataArray[btn.tag] objectForKey:@"ID"];
            
            NSString *Ftitle=@"";
            
            if ([[[dataArray objectAtIndex:btn.tag]valueForKey:@"Ftitle"] length]>0) {
                Ftitle = [NSString stringWithFormat:@"-%@",[[dataArray objectAtIndex:btn.tag]valueForKey:@"Ftitle"]];
            }
            RoomReseverClass * rrc = [RoomReseverClass new];
            rrc.ID=[NSString stringWithFormat:@"%@",ID];
            rrc.title = @"酒店预订";
            NSString *head = [NSString stringWithFormat:@"%@%@",[[dataArray objectAtIndex:btn.tag]valueForKey:@"RoomName"],Ftitle];
            rrc.roomTypeStr = head;
            rrc.russianStr = [dataDic valueForKey:@"HotelRUName"];
            // NSLog(@"%@",[dataDic valueForKey:@"HotelRUName"]);
            rrc.chineseStr  = [dataDic valueForKey:@"HotelCNName"];
            rrc.ProdType = [dataArray[btn.tag] objectForKey:@"ProdType"];
            rrc.payWay =[[dataArray objectAtIndex:btn.tag]valueForKey:@"OrderType"];
            rrc.peopleMaxCountStr = [NSString stringWithFormat:@"%@人",[dataArray[btn.tag]  objectForKey:@"MoneyType"]];
            rrc.reseverKnowStr = [dataArray[btn.tag] objectForKey:@"OrderNote"];
            rrc.roomFacilityStr = [[dataArray objectAtIndex:btn.tag]valueForKey:@"Other"];
            rrc.RMB = [[dataArray objectAtIndex:btn.tag] valueForKey:@"CNPrice"];
            rrc.dollar = [[dataArray objectAtIndex:btn.tag] objectForKey:@"USPrice"];
            rrc.startDate=[[dataArray objectAtIndex:btn.tag]valueForKey:@"StartDate"];
            rrc.endDate=[[dataArray objectAtIndex:btn.tag]valueForKey:@"EndDate"];
            rrc.ToDateStr = [[dataArray objectAtIndex:btn.tag]valueForKey:@"ToDate"];
            rrc.startDate2Str = [[dataArray objectAtIndex:btn.tag]valueForKey:@"StartDate2"];
            rrc.dataDic = dataArray[btn.tag];
            [self.navigationController pushViewController:rrc animated:NO];
        }else if ([self.title isEqualToString:@"介绍"]){
            //娱乐
            
            NSString *Ftitle=@"";
            
            if ([[dataDic valueForKey:@"Ftitle"] length]>0) {
                Ftitle = [NSString stringWithFormat:@"-%@",[[dataArray objectAtIndex:btn.tag]valueForKey:@"Ftitle"]];
            }
            EntainReseverClass * rrc = [EntainReseverClass new];
            rrc.ID=[dataDic objectForKey:@"TicketID"];
            rrc.title = @"娱乐门票预订";
            rrc.russianStr = [dataDic valueForKey:@"TicketRName"];
            rrc.ProdType = [dataDic valueForKey:@"PriceType"];
            rrc.payWay =[dataDic valueForKey:@"OrderType"];
            rrc.reseverKnowStr = [dataDic objectForKey:@"OrderNote"];
            rrc.roomFacilityStr = [dataDic valueForKey:@"Other"];
            rrc.RMB = [dataDic valueForKey:@"CNPrice"];
            rrc.dollar = [dataDic objectForKey:@"UDPrice"];
            rrc.startDate=[dataDic valueForKey:@"StarTime"];
            rrc.endDate=[dataDic valueForKey:@"EndTime"];
            rrc.ToDateStr = [dataDic valueForKey:@"ToDate"];
            rrc.startDate2Str = [dataDic valueForKey:@"StartDate2"];
            [self.navigationController pushViewController:rrc animated:NO];
        }else
            if ([self.title isEqualToString:@"线路介绍"]){
            NSString *Ftitle=@"";
            
            if ([[dataDic valueForKey:@"Ftitle"] length]>0) {
                Ftitle = [NSString stringWithFormat:@"-%@",[[dataArray objectAtIndex:btn.tag]valueForKey:@"Ftitle"]];
            }
            LineReseverClass * rrc = [LineReseverClass new];
            rrc.ID=[dataDic objectForKey:@"ID"];
            rrc.title = @"线路预订";
            rrc.russianStr = [dataDic valueForKey:@"Title"];
            rrc.ProdType = [dataDic valueForKey:@"PayType"];
            rrc.payWay =[dataDic valueForKey:@"OrderType"];
            rrc.lineDaysStr =[NSString stringWithFormat:@"%@天",[dataDic  objectForKey:@"LineDays"]];
            rrc.lineTypeStr = [dataDic  objectForKey:@"LineType"];
            rrc.reseverKnowStr = [dataDic objectForKey:@"OrderNote"];
            rrc.roomFacilityStr = [dataDic valueForKey:@"Other"];
            rrc.RMB = [dataDic valueForKey:@"CNPrice"];
            rrc.dollar = [dataDic objectForKey:@"LPrice"];
            rrc.startDate=[dataDic valueForKey:@"StarDate"];
            rrc.endDate=[dataDic valueForKey:@"EndDate"];
            rrc.ToDateStr = [dataDic valueForKey:@"ToDate"];
            rrc.startDate2Str = [dataDic valueForKey:@"StartDate2"];
            rrc.dataDic = dataDic;
            [self.navigationController pushViewController:rrc animated:NO];
        }
        
    }else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请登陆" message:@"您还没登陆，您确定要登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag=10;
        [alertView show];
    }
    
}


- (void)tap:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag==5) {
        UIView*view=(UIView*)[self.view viewWithTag:5];
        [view removeFromSuperview];
    }
    
}
-(void)close:(UIButton*)sender
{
    UIView*view=(UIView*)[self.view viewWithTag:5];
    [view removeFromSuperview];
}
#pragma mark --tag==1、线路、餐厅介绍、购物介绍、景点介绍头--
-(UIView*)creatHeadView
{
    tabHead=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
    tabHead.tag=59;
    [self.view addSubview:tabHead];
    
    picScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, 320, 240)];
    picScrollView.contentSize=CGSizeMake(320*picUrlArray.count, 240);
    picScrollView.pagingEnabled=YES;
    picScrollView.delegate=self;
    [tabHead addSubview:picScrollView];
    
    //图片
    [self imageHeadView];
    //浏览相册
    [self photos];
    //俄文
    RTLabel*russiaHead=[[RTLabel alloc]initWithFrame:CGRectMake(10, 20, 300, 0)];
    //中文
    russiaHead.text=[dataDic valueForKey:@"HotelRUName"];
    if (self.tag==1)
    {
        russiaHead.text=[dataDic valueForKey:@"TicketRName"];
    }
    if ([self.navName isEqualToString:@"餐厅介绍"])
    {
        russiaHead.text=[dataDic valueForKey:@"RestRName"];
    }
    if ([self.navName isEqualToString:@"购物介绍"])
    {
        russiaHead.text=[dataDic valueForKey:@"ShopRName"];
    }
    if ([self.navName isEqualToString:@"景点介绍"])
    {
        russiaHead.text=[dataDic valueForKey:@"ViewRUName"];
    }
    
    
    
    russiaHead.font=[UIFont boldSystemFontOfSize:18];
    CGSize headSize=[russiaHead optimumSize];
    russiaHead.frame=CGRectMake(10, picScrollView.frame.origin.y+picScrollView.frame.size.height+5, 300, headSize.height);
    
    [tabHead addSubview:russiaHead];
    
    RTLabel*  chineseLable=[[RTLabel alloc]initWithFrame:CGRectMake(10,  russiaHead.frame.origin.y+ russiaHead.frame.size.height+5, 300, 0)];
    chineseLable.text=[dataDic valueForKey:@"HotelCNName"];
    if (self.tag==1)
    {
        chineseLable.text=@"";
    }
    if ([self.navName isEqualToString:@"餐厅介绍"])
    {
        chineseLable.text=[dataDic valueForKey:@"RestCName"];
    }
    if ([self.navName isEqualToString:@"购物介绍"])
    {
        chineseLable.text=[dataDic valueForKey:@"ShopCName"];
    }
    if ([self.navName isEqualToString:@"景点介绍"])
    {
        chineseLable.text=[dataDic valueForKey:@"ViewCNName"];
    }
    
    
    

    chineseLable.font=[UIFont boldSystemFontOfSize:16];
    
    chineseLable.textColor=[UIColor grayColor];
    CGSize chineseheadSize=[chineseLable optimumSize];
    chineseLable.frame=CGRectMake(10, russiaHead.frame.origin.y+ russiaHead.frame.size.height+3, 300, chineseheadSize.height);
    if ([self.navName isEqualToString:@"线路介绍"])
    {
        chineseLable.text=[dataDic valueForKey:@"Title"];
        chineseLable.font=[UIFont systemFontOfSize:18];
        chineseLable.textColor=[UIColor blackColor];
        chineseheadSize=[chineseLable optimumSize];
        chineseLable.frame=CGRectMake(10, russiaHead.frame.origin.y+ russiaHead.frame.size.height+3, 300, chineseheadSize.height+10);
        
    }
    
    [tabHead addSubview:chineseLable];
    
    
    
    UIView*introduceView=[[UIView alloc]initWithFrame:CGRectMake(0, chineseLable.frame.origin.y+chineseLable.frame.size.height+10, 320, 0)];
    introduceView.tag=60;
    introduceView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"detailIntroduce.png"]];
    [tabHead addSubview:introduceView];
    
    
    introduceLable=[[RTLabel alloc]initWithFrame:CGRectMake(10, 0, 300, 0)];
    NSString*str=[dataDic valueForKey:@"Content"];
    introduceLable.font=[UIFont systemFontOfSize:15];
    introduceLable.text= [NSString stringWithFormat:@"%@",[dataDic valueForKey:@"Content"]];
    introduceLable.textColor=[UIColor grayColor];
    s=[introduceLable optimumSize];
    
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    if (s.height>120) {
        introduceLable.frame=CGRectMake(10, 10, 300,90);
        [button setImage:[UIImage imageNamed:@"entainmentlookmore.png"] forState:UIControlStateNormal];
    }else{
        introduceLable.frame=CGRectMake(10, 10, 300,s.height);
        [button setImage:[UIImage imageNamed:@"entainmentlooksmall.png"] forState:UIControlStateNormal];
    }
   // NSLog(@"introduceLable  %@",introduceLable.text);
    [introduceView addSubview:introduceLable];
    
    button.frame=CGRectMake(0, introduceLable.frame.origin.y+introduceLable.frame.size.height+10, 320, 20);
    [button addTarget:self action:@selector(lookMore:) forControlEvents:UIControlEventTouchUpInside];
    [introduceView addSubview:button];
    
    if ([str isEqual:@""])
    {
        introduceView.frame=CGRectMake(0, chineseLable.frame.origin.y+chineseLable.frame.size.height, 320, 0);
    }else {
        introduceView.frame=CGRectMake(0, chineseLable.frame.origin.y+chineseLable.frame.size.height+10, 320, button.frame.origin.y+button.frame.size.height);
    }
    float c=introduceView.frame.origin.y+introduceView.frame.size.height;
    
    UIView*contentView=[self creatHotelRowFloat:c];
    contentView.tag=62;
    [tabHead addSubview:contentView];
    tabHead.frame=CGRectMake(0, 0, DeviceWidth, contentView.frame.origin.y+contentView.frame.size.height);
    return tabHead;
}
- (void)imageHeadView{
    if ([self.navName isEqualToString:@"线路介绍"])
    {
        UIButton*imageView=[[UIButton alloc]initWithFrame:CGRectMake(0,0, 320, 240)];
        [imageView setImage:_fromeImage forState:UIControlStateNormal];
        imageView.tag=600;
        [picScrollView addSubview:imageView];
    }
    
    
    for (int i=0; i<picUrlArray.count; i++)
    {
        UIButton*pic=[UIButton buttonWithType:UIButtonTypeCustom];
        [pic setBackgroundImage:[UIImage imageNamed:@"defaultBig.gif"] forState:UIControlStateNormal];
        pic.frame=CGRectMake(320*i,0, 320, 240);
        pic.tag=600+i;
        NSString *name = [[picUrlArray objectAtIndex:i] objectForKey:@"PicName"];
        if ([name length]>4) {
            NSLog(@"[[_dataArr objectAtIndex:indexPath.row] objectForKey:Pic]   %@",name);
            
            NSData *pathData = [NSData dataWithContentsOfFile:PathOfFile(name)];
            NSLog(@"pathData:%@",pathData);
            if (pathData.length==0) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@",PicUrl,_picPath2,name];//_picPath2
                    NSLog(@"picurl %@",urlStr);
                    NSURL *url = [NSURL URLWithString:urlStr];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    // [NSThread sleepForTimeInterval:2];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (data) {

                            [data writeToFile:PathOfFile(name) atomically:YES];
                            [pic setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                        }
                        
                    });
                });
            }else {
                [pic setBackgroundImage:[UIImage imageWithData:pathData] forState:UIControlStateNormal];
            }
        }

        
        [pic addTarget:self action:@selector(browse:) forControlEvents:UIControlEventTouchUpInside];
        [picScrollView addSubview:pic];
        
        
        
        
    }
    
    UIImageView*pic_image=[[UIImageView alloc]initWithFrame:CGRectMake(picScrollView.frame.size.width-35,picScrollView.frame.size.height-35, 30, 30)];
    pic_image.image=[UIImage imageNamed:@"hotel_photo.png"];
    
    [tabHead addSubview:pic_image];
    
    pic_imageLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    pic_imageLable.backgroundColor=[UIColor clearColor];
    pic_imageLable.text=[NSString stringWithFormat:@"1/%d",picUrlArray.count];
    pic_imageLable.font=[UIFont systemFontOfSize:14];
    pic_imageLable.textAlignment=NSTextAlignmentCenter;
    if ([self.navName isEqualToString:@"线路介绍"])
    {
        pic_imageLable.text=@"";
    }
    pic_imageLable.textColor=[UIColor whiteColor];
    [pic_image addSubview:pic_imageLable];
    
    if (picUrlArray.count==0)
    {
        pic_imageLable.text=@"";
        pic_image.image=nil;
    }

}
#pragma mark--创建个人租车表头
-(UIView*)createCarRental
{
    tabHead=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
    
    [self.view addSubview:tabHead];
    
    UIView*intrdouce=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 110)];
    [tabHead addSubview:intrdouce];
    
    userImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 120, 90)];
    
    [intrdouce addSubview:userImage];
    
    
    NSString*name=[self.dataDic2 valueForKey:@"UName"];
    NSString*country;
    if ([[self.dataDic2 valueForKey:@"Country"] integerValue]==1)
    {
        country=@"中国籍";
    }
    else
    {
        country=@"俄籍";
    }
    NSString*seat=[NSString stringWithFormat:@"%@", [self.dataDic2 valueForKey:@"SeatCount"]];
    NSString* sex = nil;
    if ([[self.dataDic2 valueForKey:@"Sex"] integerValue]==1)
    {
        sex=@"男";
    }
    else
    {
        sex=@"女";
    }
    
    NSString*CarClass=[self.dataDic2  valueForKey:@"CarType"];
    NSString*jicheng=[self.dataDic2  valueForKey:@"JiCheng"];
    
    
    RTLabel*userInfo=[[RTLabel alloc]initWithFrame:CGRectMake(135, 10, 175, 70)];
    userInfo.textColor=[UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
    userInfo.text=[NSString stringWithFormat:@"<font size=14 color=black>姓名</font> <font size=14 color=gray>%@（%@）</font><br><font size=14 color=black>国籍</font> <font size=14 color=gray>%@</font><br><font size=14 color=black>车况</font> %@人座 %@ %@",name,sex,country,seat,CarClass,jicheng];
    [intrdouce addSubview:userInfo];
    
    UIButton*address=[UIButton buttonWithType:UIButtonTypeCustom];
    [intrdouce addSubview:address];
    address.frame=CGRectMake(userInfo.frame.origin.x, userInfo.frame.origin.y+userInfo.frame.size.height, 175, 15);
    UIImageView*location=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    if (![[self.dataDic2 valueForKey:@"Location"]isEqualToString:@""])
    {
        location.image=[UIImage imageNamed:@"secenery_location.png"];
    }
    
    [address addSubview:location];
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(23, 0, 150, 20)];
    lable.text=[self.dataDic2 valueForKey:@"Location"];
    [address addSubview:lable];
    
    UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(0, userImage.frame.origin.y+userImage.frame.size.height+8, 320, 2)];
    link.image=[UIImage imageNamed:@"entainmentLink.png"];
    [intrdouce addSubview:link];
    
    
    
    float c=0;
    UIView* order=[[UIView alloc]initWithFrame:CGRectMake(0, userImage.frame.origin.y+userImage.frame.size.height+10, 320, 50)];
    order.tag=61;
    [tabHead addSubview:order];
    
    UIImageView*link1=[[UIImageView alloc]initWithFrame:CGRectMake(0, order.frame.size.height-2, 320, 2)];
    link1.image=[UIImage imageNamed:@"entainmentLink.png"];
    [order addSubview:link1];
    
    RTLabel*lable1=[[RTLabel alloc]initWithFrame:CGRectMake(10, 0, 80, 0)];
    lable1.text=[NSString stringWithFormat:@"$<font size=16  color=orange>%@</font>",[self.dataDic2 valueForKey:@"UPrice"]];
    CGSize size=[lable1 optimumSize];
    lable1.frame=CGRectMake(20, (order.frame.size.height-size.height)/2, 80, size.height);
    [order addSubview:lable1];
    
    
    UIButton*button1=[UIButton buttonWithType:UIButtonTypeCustom];
    button1.layer.cornerRadius=4;
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    button1.frame=CGRectMake(230, 10, 70, 30);
    [order addSubview:button1];
    
    button1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LineDetail_reserve.png"]];
    [button1 setTitle:@"预订" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(goBug:) forControlEvents:UIControlEventTouchUpInside];
    [order addSubview:button1];
    c=order.frame.origin.y+order.frame.size.height;
    
    
    
    
    UIView*contentView=[self creatHotelRowFloat:c];
    contentView.tag=62;
    [tabHead addSubview:contentView];
    
    tabHead.frame=CGRectMake(0, 0, DeviceWidth, contentView.frame.origin.y+contentView.frame.size.height+40);
    
    return tabHead;
    
}
#pragma mark--创建代理商租车表头
-(UIView*)createCompanyCarRental
{
    
    
    tabHead=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
    
    [self.view addSubview:tabHead];
    
    UIView*intrdouce=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 110)];
    [tabHead addSubview:intrdouce];
    
    userImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 120, 90)];
    
    [intrdouce addSubview:userImage];
    
    
    NSString*name=[self.dataDic2 valueForKey:@"UName"];
    NSString*guideCount=[self.dataDic2 valueForKey:@"GuideCount"];
    
    RTLabel*userInfo=[[RTLabel alloc]initWithFrame:CGRectMake(135, 10, 175, 70)];
    userInfo.backgroundColor=[UIColor clearColor];
    userInfo.text=[NSString stringWithFormat:@"<font size=14 color=red>%@</font><br>租车(<font size=14  color=blue>%@辆</font>)",name,guideCount];
    
    [intrdouce addSubview:userInfo];
    
    UIButton*address=[UIButton buttonWithType:UIButtonTypeCustom];
    [intrdouce addSubview:address];
    address.frame=CGRectMake(userInfo.frame.origin.x, userInfo.frame.origin.y+userInfo.frame.size.height, 175, 15);
    UIImageView*location=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    if (![[self.dataDic2 valueForKey:@"Location"]isEqualToString:@""])
    {
        location.image=[UIImage imageNamed:@"secenery_location.png"];
    }
    
    [address addSubview:location];
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(23, 0, 150, 20)];
    lable.text=[self.dataDic2 valueForKey:@"Location"];
    [address addSubview:lable];
    
    UIImageView*link=[[UIImageView alloc]initWithFrame:CGRectMake(0, userImage.frame.origin.y+userImage.frame.size.height+8, 300, 2)];
    link.image=[UIImage imageNamed:@"entainmentLink.png"];
    [intrdouce addSubview:link];
    
    float c=0;
    NSArray*seatCount=@[@"5人座",@"6人座",@"7人座",@"9人座",@"15人座",@"17人座",@"20人座",@"40人座以上"];
    NSArray*priceType=@[@"FiveType",@"SixType",@"SevenType",@"NineType",@"FifteenType",@"SeventeemType",@"TwenType",@"ForType"];
    NSArray*priceArray=@[@"CNUStudent",@"CNUSpasice",@"RUUPutong",@"RUUSpasice",@"SuiUFanyi",@"GWUFanyi",@"ZYUFanYi",@"ZJUFanYi"];
    NSDictionary*_dic=[NSDictionary dictionaryWithObjectsAndKeys:@"小时",@"1",@"天",@"2", nil];
    
    NSMutableArray*titleArray=[NSMutableArray new];
    
    for (int i=0; i<priceType.count; i++)
    {
        [titleArray addObject:[NSString stringWithFormat:@"%@<font   color=gray>      $<font color=orange>%@</font>/%@</font>",[seatCount objectAtIndex:i],[self.dataDic2 valueForKey:[priceArray objectAtIndex:i]],[_dic valueForKey:[NSString stringWithFormat:@"%@",[self.dataDic2 valueForKey:[priceArray objectAtIndex:i]]]]]];
        
    }
    
    
    for (int i=0; i<7; i++)
    {
        UIView* order=[[UIView alloc]initWithFrame:CGRectMake(0, userImage.frame.origin.y+userImage.frame.size.height+10+50*i, 320, 50)];
        order.tag=61;
        order.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [tabHead addSubview:order];
        
        UIImageView*link1=[[UIImageView alloc]initWithFrame:CGRectMake(0, order.frame.size.height-2, 320, 2)];
        link1.image=[UIImage imageNamed:@"entainmentLink.png"];
        [order addSubview:link1];
        
        RTLabel*lable1=[[RTLabel alloc]initWithFrame:CGRectMake(10, 0,200, 0)];
        lable1.text=[titleArray objectAtIndex:i];
        CGSize size=[lable1 optimumSize];
        lable1.frame=CGRectMake(10, (order.frame.size.height-size.height)/2, 200, size.height);
        [order addSubview:lable1];
        
        
        UIButton*button1=[UIButton buttonWithType:UIButtonTypeCustom];
        button1.layer.cornerRadius=4;
        button1.titleLabel.font = [UIFont systemFontOfSize:13];
        button1.frame=CGRectMake(230, 10, 70, 30);
        
        [order addSubview:button1];
        button1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LineDetail_reserve.png"]];
        [button1 setTitle:@"预订" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(goBug:) forControlEvents:UIControlEventTouchUpInside];
        [order addSubview:button1];
        if ([[self.dataDic2 valueForKey:[priceArray objectAtIndex:i]] intValue]==0)
        {
            order.frame=CGRectMake(0, userImage.frame.origin.y+userImage.frame.size.height+10+50*i, 320, 0);
        }
        c=order.frame.origin.y+order.frame.size.height;
    }
    
    UIView*contentView=[self creatHotelRowFloat:c];
    contentView.tag=62;
    [tabHead addSubview:contentView];
    
    tabHead.frame=CGRectMake(0, 0, DeviceWidth, contentView.frame.origin.y+contentView.frame.size.height);
    
    return tabHead;
    
}

#pragma mark--查看更多介绍
-(void)lookMore:(UIButton*)sender
{
    UIView*view=(UIView*)[self.view viewWithTag:60];
    UIView*view2=(UIView*)[self.view viewWithTag:62];
    UIView*view3=(UIView*)[self.view viewWithTag:59];
    float k=s.height-90;
    if (k>0)
    {
        NSLog(@"view.frame.size.height  %f",view.frame.size.height);
        if (view.frame.size.height==130)
        {
            NSString*str=[dataDic valueForKey:@"Content"];
            introduceLable.text= [NSString stringWithFormat:@"%@",str];
            introduceLable.font=[UIFont systemFontOfSize:15];
            introduceLable.frame=CGRectMake(10, 10, 300, s.height);
            [UIView animateWithDuration:0.2f animations:^{
                
                view.frame = CGRectMake(0,view.frame.origin.y, 320, 120+k);
                sender.frame=CGRectMake(0, view.frame.size.height-20, 320, 20);
                
                view2.frame=CGRectMake(0, view2.frame.origin.y+k, view2.frame.size.width, view2.frame.size.height);
                view3.frame=CGRectMake(0, view3.frame.origin.y, view3.frame.size.width, view3.frame.size.height+k);
                _tableView.tableHeaderView=view3;
                [sender setImage:[UIImage imageNamed:@"entainmentlooksmall.png"] forState:UIControlStateNormal];
                
            }];
            
        }
        else
        {
            introduceLable.frame=CGRectMake(10, 10, 300, 90);
            NSString*str=[dataDic valueForKey:@"Content"];
            introduceLable.text= [NSString stringWithFormat:@"%@",str];
            [UIView animateWithDuration:0.2f animations:^{
                
                view.frame = CGRectMake(0,view.frame.origin.y, 320, 130);
                sender.frame=CGRectMake(0, view.frame.size.height-20, 320, 20);
                
                view2.frame=CGRectMake(0, view2.frame.origin.y-k, view2.frame.size.width, view2.frame.size.height);
                [sender setImage:[UIImage imageNamed:@"entainmentlookmore.png"] forState:UIControlStateNormal];
                view3.frame=CGRectMake(0, view3.frame.origin.y, view3.frame.size.width, view3.frame.size.height-k);
                _tableView.tableHeaderView=view3;
            }];
            
            
            
        }
        
        
    }
    
}
#pragma mark---创建每行、线路
-(UIView*)creatHotelRowFloat:(CGFloat)c
{
    
    NSMutableArray*title;
    
    NSMutableArray*imageArray;
    NSString*area;
    NSString*star;
    NSDictionary*dic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
    NSDictionary*dic2=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"star" ofType:@"plist"]];
    if ([dataDic valueForKey:@"Arear"])
    {
        area=[dic valueForKey:[[dataDic valueForKey:@"Arear"] stringValue]];
    }
    
    if ([dataDic valueForKey:@"Star"])
    {
        star=[dic2 valueForKey:[[dataDic valueForKey:@"Star"] stringValue]];
    }
    if ([self.navName isEqualToString:@"酒店介绍"])
    {
        
        title=[NSMutableArray arrayWithObjects:@"所在区域",@"酒店星级",@"房间数量",@"地址",@"电话",@"交通", nil];
        
        title2=[NSArray arrayWithObjects:area, star,[NSString stringWithFormat:@"%@间",[dataDic valueForKey:@"RoomCount"]] ,[dataDic valueForKey:@"Address"] ,[dataDic valueForKey:@"Phone"] ,[dataDic valueForKey:@"Traffic"], nil];
        
        imageArray=[NSMutableArray arrayWithObjects:@"hotel_03-00.png",@"hotel_03-01.png",@"hotel_03-02.png",@"hotel_03-03.png",@"hotel_03-04.png", @"hotel_03-05.png",nil];
    }
    //娱乐
    if (self.tag==1)
    {
        title=[NSMutableArray arrayWithObjects:@"演出时间",@"演出时长",@"演出地点",@"地址",@"电话",@"交通", nil];
        NSString*data1=[dataDic valueForKey:@"StarTime"];
        data1=[data1 stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString*data2=[dataDic valueForKey:@"EndTime"];
        data2=[data2 stringByReplacingOccurrencesOfString:@"-" withString:@"."];
      NSString*  date=[NSString stringWithFormat:@"%@-%@",data1,data2];
        
        
        if ([[dataDic valueForKey:@"PriceType"] integerValue]==1)
        {
            date=@"长期有效";
        }
        
        if ([[dataDic valueForKey:@"PriceType"] integerValue]==2)
        {
            
            NSMutableString*str=RussiaUrl3;
            NSString*fileName= [NSString stringWithFormat:@"%@%d",@"PriceType",self.hotelID];
            NSURL*url=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@?ID=%d",str,@"getTicketdatelist",self.hotelID]];
            NSData*data;
            Reachability*rea22 =[Reachability reachabilityWithHostName:@"www.baidu.com"];
            if ([rea22  currentReachabilityStatus]==NotReachable)
            {
                data=[NSData dataWithContentsOfFile:PathOfFile(fileName)];
            }
            else
            {
                data=[NSData dataWithContentsOfURL:url];
            }
            
            dicResultYiBuNoDic(data, result)
            WriteToFile(data,fileName);
            date=result;
        }
        
        
        
        
        NSLog(@"%@",date);
        
        if ([[dataDic valueForKey:@"TicketClass"] isEqualToString:@"游船"])
        {
            [title insertObject:@"船期" atIndex:0];
            title2=[NSArray arrayWithObjects:date, [dataDic valueForKey:@"ShowTime"],[NSString stringWithFormat:@"%@分钟",[dataDic valueForKey:@"TimeLong"]],[dataDic valueForKey:@"Address"],[dataDic valueForKey:@"Phone"], [dataDic valueForKey:@"Traffic"], nil];
        }
        else if ([[dataDic valueForKey:@"TicketClass"] isEqualToString:@"其他"])
        {
            [title insertObject:@"日期" atIndex:0];
            title2=[NSArray arrayWithObjects:date, [dataDic valueForKey:@"ShowTime"],[NSString stringWithFormat:@"%@分钟",[dataDic valueForKey:@"TimeLong"]],[dataDic valueForKey:@"Address"],[dataDic valueForKey:@"Phone"], [dataDic valueForKey:@"Traffic"], nil];
        }
        else if ([[dataDic valueForKey:@"TicketClass"] isEqualToString:@"大马戏"])
        {
            [title insertObject:@"档期" atIndex:0];
            title2=[NSArray arrayWithObjects:date, [dataDic valueForKey:@"ShowTime"],[NSString stringWithFormat:@"%@分钟",[dataDic valueForKey:@"TimeLong"]],[dataDic valueForKey:@"ShowBuild"],[dataDic valueForKey:@"Address"],[dataDic valueForKey:@"Phone"], [dataDic valueForKey:@"Traffic"], nil];
        }
        else
        {
            [title insertObject:@"演出日期" atIndex:0];
            title2=[NSArray arrayWithObjects:date, [dataDic valueForKey:@"ShowTime"],[NSString stringWithFormat:@"%@分钟",[dataDic valueForKey:@"TimeLong"]],[dataDic valueForKey:@"ShowBuild"],[dataDic valueForKey:@"Address"],[dataDic valueForKey:@"Phone"], [dataDic valueForKey:@"Traffic"], nil];
        }
        
        imageArray=[NSMutableArray arrayWithObjects:@"theater_days.png",@"theater_times.png",@"timeLong.png",@"theater_place.png",@"theater_adds.png",@"theater_phones.png", @"hotel_03-05.png",nil];
        if ([[dataDic valueForKey:@"TicketClass"] isEqualToString:@"游船"]||[[dataDic valueForKey:@"TicketClass"] isEqualToString:@"其他"])
        {
            [title removeObject:@"演出地点"];
            [imageArray removeObjectAtIndex:3];
        }
        
        
        
        
    }
    
    if ([self.navName isEqualToString:@"线路介绍"])
    {
        title=[NSMutableArray arrayWithObjects:@"线路类型",@"行程天数",@"发团日期", nil];
        imageArray=[NSMutableArray arrayWithObjects:@"LineDetail_type.png",@"LineDetail_xingcheng.png",@"theater_days.png", nil];
        
        
        NSString*data1=[dataDic valueForKey:@"StarDate"];
        data1=[data1 stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        
        NSString*data2=[dataDic valueForKey:@"EndDate"];
        data2=[data2 stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSString*data=[NSString stringWithFormat:@"%@-%@",data1,data2];
        
        NSString*faturiqi;
        if ([[dataDic valueForKey:@"PayType"] integerValue]==1)
        {
            faturiqi=@"长期有效";
        }else if ([[dataDic valueForKey:@"PayType"] integerValue]==3)
        {
            faturiqi=data;
            
        }
        //线路介绍
      else  if ([[dataDic valueForKey:@"PayType"] integerValue]==2)
        {
            
            NSMutableString*str=RussiaUrl2;
            NSString*fileName= [NSString stringWithFormat:@"%@%d",@"PayType",self.hotelID];
            NSURL*url=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"%@%@?ID=%d",str,@"getTourLinedatelist",self.hotelID]];
            NSData*data;
            Reachability*rea22 =[Reachability reachabilityWithHostName:@"www.baidu.com"];
            if ([rea22  currentReachabilityStatus]==NotReachable)
            {
                data=[NSData dataWithContentsOfFile:PathOfFile(fileName)];
            }
            else
            {
                data=[NSData dataWithContentsOfURL:url];
                
                
            }
         dicResultYiBuNoDic(data, result)
             WriteToFile(data,fileName);
            faturiqi=result;
            NSLog(@"id  %d",self.hotelID);
              NSLog(@"faturiqi== %@",faturiqi);
        }
       
        title2=[NSArray arrayWithObjects:[dataDic valueForKey:@"LineType"], [NSString stringWithFormat:@"%@天",[dataDic valueForKey:@"LineDays"]],faturiqi, nil];
        
    }
    if ([self.navName isEqualToString:@"餐厅介绍"])
    {
        title=[NSMutableArray arrayWithObjects:@"所在区域",@"菜系",@"人均消费",@"地址",@"电话",@"交通", nil];
        imageArray=[NSMutableArray arrayWithObjects:@"hotel_03-00.png",@"food_type.png",@"food_ consume.png",@"hotel_03-03.png",@"hotel_03-04.png", @"hotel_03-05.png", nil];
        title2=[NSArray arrayWithObjects:area, [dataDic valueForKey:@"RestType"],[NSString stringWithFormat:@"$%@",[dataDic valueForKey:@"Price"]], [dataDic valueForKey:@"Address"], [dataDic valueForKey:@"Phone"], [dataDic valueForKey:@"Traffic"], nil];
    }
    
    if ([self.navName isEqualToString:@"购物介绍"])
    {
        title=[NSMutableArray arrayWithObjects:@"所在区域",@"类型",@"营业时间",@"地址",@"电话",@"交通", nil];
        imageArray=[NSMutableArray arrayWithObjects:@"hotel_03-00.png",@"LineDetail_type.png",@"LineDetail_xingcheng.png",@"hotel_03-03.png",@"hotel_03-04.png", @"hotel_03-05.png", nil];
        
        title2=[NSArray arrayWithObjects:area, [dataDic valueForKey:@"ShopType"],[dataDic valueForKey:@"ShowTime"], [dataDic valueForKey:@"Address"], [dataDic valueForKey:@"Phone"], [dataDic valueForKey:@"Traffic"], nil];
    }
    
    
    if ([self.navName isEqualToString:@"景点介绍"])
    {
        title=[NSMutableArray arrayWithObjects:@"开放时间",@"地址",@"电话",@"交通", nil];
        title2 = [NSArray arrayWithObjects:[dataDic valueForKey:@"ShowTime"], [dataDic valueForKey:@"Address"],[dataDic valueForKey:@"Phone"] ,[dataDic valueForKey:@"Traffic"] , nil];
        imageArray=[NSMutableArray arrayWithObjects:@"theater_times.png",@"theater_adds.png",@"theater_phones.png", @"hotel_03-05.png",nil];
    }
    
    if (self.tag==2)
    {
        NSString*other=@"";
        if ( [[self.dataDic2 valueForKey:@"Other"]intValue]==1)
        {
            other=@"愿意跟随客人到其他城市";
        }
        
        title=[NSMutableArray arrayWithObjects:@"语言",@"汽车品牌",@"擅长讲解",@"工作时间",@"服务宗旨",@"其他", nil];
        title2=[NSArray arrayWithObjects:[self.dataDic2 valueForKey:@"Language"], [self.dataDic2 valueForKey:@"CarBrand"],[self.dataDic2 valueForKey:@"JiangJie"] ,[NSString stringWithFormat:@"每天工作%@小时",[self.dataDic2 valueForKey:@"Hour"] ],[self.dataDic2 valueForKey:@"ZongZhi"] , other,nil];
        imageArray=[NSMutableArray arrayWithObjects:@"language1.png",@"car1.png",@"jiangejie1.png", @"theater_times.png",@"severive1.png",@"other1.png",nil];
    }
    
    float a=c;
    c=0;
    
    UIView*tabHead2=[[UIView alloc]initWithFrame:CGRectMake(0, a, 320, 40)];
    UIButton*view;
    for (int i=0; i<title.count; i++)
    {
        view=[[UIButton alloc]initWithFrame:CGRectMake(0, c, 320, 50)];
        view.tag=90+i;
        view.userInteractionEnabled=NO;
        
        view.backgroundColor=GroupColor;
        
        [tabHead2 addSubview:view];
        UIImageView*pic=[[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 21, 21)];
        pic.image=[UIImage imageNamed:[imageArray objectAtIndex:i]];
        [view addSubview:pic];
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 80, 50)];
        lable.text=[title objectAtIndex:i];
        lable.backgroundColor=[UIColor clearColor];
        lable.font=[UIFont boldSystemFontOfSize:16];
        [view addSubview:lable];
        
        RTLabel*lable2=[[RTLabel alloc]initWithFrame:CGRectMake(115, 15, 195, 30)];
        lable2.lineSpacing=3;
        lable2.userInteractionEnabled=NO;
        
        NSString*str=i<title2.count?[title2 objectAtIndex:i]:@"";
        lable2.text=[NSString stringWithFormat:@"%@",str];
        lable2.backgroundColor=[UIColor clearColor];
        lable2.textColor=[UIColor grayColor];
        lable2.font=[UIFont systemFontOfSize:16];
        CGSize size=[lable2 optimumSize];
        NSLog(@"size %f",size.height);
        view.frame = CGRectMake(0, c, 320, 50);
        [view addSubview:lable2];
        
        
        if ([[title objectAtIndex:i]isEqualToString:@"电话"])
        {
            lable2.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            view.userInteractionEnabled=YES;
            
            [view addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        UIImageView*link;

            link=[[UIImageView alloc]initWithFrame:CGRectMake(10, view.frame.size.height-2, 300, 2)];
            link.image=[UIImage imageNamed:@"entainmentLink.png"];
            [view addSubview:link];
        
        if (size.height>30)
        {
            lable2.frame=CGRectMake(115, 10, 195, size.height);
            lable.frame = CGRectMake(40, 10, 80, 15);
            view.frame=CGRectMake(0, c, 320, size.height+25);
            link.frame=CGRectMake(10, view.frame.size.height-2, 300, 2);
            pic.frame=CGRectMake(10, 7, 21, 21);
        }
        
        NSString*_str=[NSString stringWithFormat:@"%@",title2.count<i?[title2 objectAtIndex:i]:nil];
        if ([_str isEqualToString:@""])
        {
            view.frame=CGRectMake(0, c, 320, 0);
            lable2.frame=CGRectMake(125,5, 175, 0);
            
            
            
            link.frame=CGRectMake(10, view.frame.size.height-2, 300, 0);
            pic.frame=CGRectMake(10, (size.height-30)/2, 30, 0);
            lable.frame=CGRectMake(45, 0, 80,0);
        }
        
        
        c+=view.frame.size.height;
    }
    
    if (self.tag==1) {

        //支付
        UIImageView*roomOrderImage=[[UIImageView alloc]initWithFrame:CGRectMake(12, c+13, 17,17)];
        roomOrderImage.image=[UIImage imageNamed:@"resever.png"];
        [tabHead2 addSubview:roomOrderImage];
        
        UILabel*roomOrederLable1=[[UILabel alloc]initWithFrame:CGRectMake(40, roomOrderImage.frame.origin.y+2, 80, 16)];
        roomOrederLable1.text=@"支付方式";
        roomOrederLable1.font=[UIFont boldSystemFontOfSize:16];
        [tabHead2 addSubview:roomOrederLable1];
        
        
        
        int oredrTypeCount = [[dataDic objectForKey:@"OrderType"] intValue];
        NSArray *orderNameArr = @[@"在线支付",@"当面支付"];
        for (int i = 0; i<oredrTypeCount; i++) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(115, roomOrderImage.frame.origin.y+i*25, 15.5, 15.5)];
            iv.image = [UIImage imageNamed:@"greenGou"];
            [tabHead2 addSubview:iv];
            
            RTLabel*roomOrederLable2=[[RTLabel alloc]initWithFrame:CGRectMake(132, roomOrderImage.frame.origin.y+i*25+3, 60, 15)];
            roomOrederLable2.text = orderNameArr[i];
            roomOrederLable2.font=[UIFont systemFontOfSize:13];
            roomOrederLable2.textColor=[UIColor grayColor];
            [tabHead2 addSubview:roomOrederLable2];
            
            if (i==1) {
                RTLabel*roomOrederLable3=[[RTLabel alloc]initWithFrame:CGRectMake(133.5, roomOrderImage.frame.origin.y+i*25+2, 157, 15)];
                
                roomOrederLable3.text = [NSString stringWithFormat:@"               %@",[dataDic objectForKey:@"OrderMark"]];
                roomOrederLable3.font=[UIFont systemFontOfSize:13];
                roomOrederLable3.textColor=[UIColor grayColor];
                roomOrederLable3.frame = CGRectMake(133.5, roomOrderImage.frame.origin.y+25, 157, roomOrederLable3.optimumSize.height);

                [tabHead2 addSubview:roomOrederLable3];
                c =  roomOrederLable3.frame.origin.y+roomOrederLable3.frame.size.height;
                
            }else c = roomOrederLable2.frame.origin.y+roomOrederLable2.frame.size.height;
        }
        
        UIImageView*linek2=[[UIImageView alloc]init];
        linek2.frame=CGRectMake(10, c+10, 310, 2);
        linek2.image=[UIImage imageNamed:@"entainmentLink.png"];
        [tabHead2 addSubview:linek2];
        
        
        
        if ([[dataDic objectForKey:@"Notice"] length]) {
            //门票使用注意事项
            UIImageView*remarkImage=[[UIImageView alloc]initWithFrame:CGRectMake(8, c+20, 24,24)];
            remarkImage.image=[UIImage imageNamed:@"门票使用注意事项"];
            [tabHead2 addSubview:remarkImage];
            UILabel*remarkLable1=[[UILabel alloc]initWithFrame:CGRectMake(40, remarkImage.frame.origin.y+5, 150, 16)];
            remarkLable1.text=@"门票使用注意事项";
            remarkLable1.font=[UIFont boldSystemFontOfSize:16];
            [tabHead2 addSubview:remarkLable1];
            
            
            RTLabel*remarkLable2=[[RTLabel alloc]initWithFrame:CGRectMake(33, remarkLable1.frame.origin.y+5, 280-33-20, 0)];
            remarkLable2.text=[dataDic objectForKey:@"Notice"];
            remarkLable2.font=[UIFont systemFontOfSize:13];
            remarkLable2.textColor=[UIColor grayColor];
            CGSize remarksize=[remarkLable2 optimumSize];
            remarkLable2.frame=CGRectMake(40, remarkLable1.frame.origin.y+5+remarkLable1.frame.size.height, 280-33-20, remarksize.height);
            
            [tabHead2 addSubview:remarkLable2];
            c=remarkLable2.frame.origin.y+remarkLable2.frame.size.height;
            
            UIImageView*linek1=[[UIImageView alloc]init];
            linek1.frame=CGRectMake(10, c+10, 310, 2);
            linek1.image=[UIImage imageNamed:@"entainmentLink.png"];
            [tabHead2 addSubview:linek1];
        }
        //前预订
        if ([[dataDic valueForKey:@"MoneyType"] length])
        {
            UIImageView*validityImage2=[[UIImageView alloc]initWithFrame:CGRectMake(10, c+20, 15.5,15.5)];
            validityImage2.image=[UIImage imageNamed:@"room_orderday.png"];
            [tabHead2 addSubview:validityImage2];
            UILabel*validityLable3=[[UILabel alloc]initWithFrame:CGRectMake(40, validityImage2.frame.origin.y, 280-33, 15)];
            validityLable3.textColor=[UIColor redColor];
            validityLable3.text=[NSString stringWithFormat:@"入住当日%@前预订有效",[dataDic valueForKey:@"MoneyType"]];
            
            validityLable3.font=[UIFont systemFontOfSize:13];
            [tabHead2 addSubview:validityLable3];
            
            c = validityLable3.frame.origin.y+validityLable3.frame.size.height;
            UIImageView*linek1=[[UIImageView alloc]init];
            linek1.frame=CGRectMake(10, c+10, 310, 2);
            linek1.image=[UIImage imageNamed:@"entainmentLink.png"];
            [tabHead2 addSubview:linek1];
        }
        
        

        
        if ([[dataDic objectForKey:@"OrderNote"] length]) {
            //预订须知
            UIImageView*remarkImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, c+20, 17,17)];
            remarkImage.image=[UIImage imageNamed:@"预订须知"];
            [tabHead2 addSubview:remarkImage];
            UILabel*remarkLable1=[[UILabel alloc]initWithFrame:CGRectMake(40, remarkImage.frame.origin.y+2, 100, 15)];
            remarkLable1.text=@"预订须知";
            remarkLable1.font=[UIFont boldSystemFontOfSize:16];
            [tabHead2 addSubview:remarkLable1];
            
            
            RTLabel*remarkLable2=[[RTLabel alloc]initWithFrame:CGRectMake(40, remarkLable1.frame.origin.y+5, 280-33-20, 0)];
            remarkLable2.text=[dataDic objectForKey:@"OrderNote"];
            remarkLable2.font=[UIFont systemFontOfSize:13];
            remarkLable2.textColor=[UIColor grayColor];
            CGSize remarksize=[remarkLable2 optimumSize];
            remarkLable2.frame=CGRectMake(40, remarkLable1.frame.origin.y+5+remarkLable1.frame.size.height, 280-33-20, remarksize.height);
            
            [tabHead2 addSubview:remarkLable2];
            c=remarkLable2.frame.origin.y+remarkLable2.frame.size.height;
        
            UIImageView*linek1=[[UIImageView alloc]init];
            linek1.frame=CGRectMake(10, c+10, 310, 2);
            linek1.image=[UIImage imageNamed:@"entainmentLink.png"];
            [tabHead2 addSubview:linek1];
        }
        // c=order.frame.origin.y+order.frame.size.height;
    }
    UIImageView*order;
    if (self.tag==1||[self.navName isEqualToString:@"线路介绍"])
    {
        order=[[UIImageView alloc]initWithFrame:CGRectMake(0,self.tag==1?c+10:c, 320, 43)];

        order.userInteractionEnabled=YES;
        order.tag=61;
        // order.image=[UIImage imageNamed:@"_order.png"];
        [tabHead2 addSubview:order];
        
        UIImageView*link1=[[UIImageView alloc]initWithFrame:CGRectMake(0, order.frame.size.height-2, 320, 2)];
        link1.image=[UIImage imageNamed:@"entainmentLink.png"];
        [order addSubview:link1];
        
        RTLabel*lable1=[[RTLabel alloc]initWithFrame:CGRectMake(10, 10, 80, 25)];
        //    lable1.font=[UIFont systemFontOfSize:18];
        
        if (self.tag==1)
        {
            lable1.text=[NSString stringWithFormat:@"$<font size=16  color=orange>%@</font>",[dataDic valueForKey:@"UDPrice"]];
        }else lable1.text=[NSString stringWithFormat:@"$<font size=16  color=orange>%@</font>",[dataDic valueForKey:@"LPrice"]];
       // CGSize size=[lable1 optimumSize];
        //lable1.frame=CGRectMake(10, (order.frame.size.height-size.height)/2, 80, size.height);
        [order addSubview:lable1];
        
        
        UIButton*button1=[UIButton buttonWithType:UIButtonTypeCustom];
     
        button1.layer.cornerRadius=4;
        button1.titleLabel.font = [UIFont systemFontOfSize:14];
        //button1.frame=CGRectMake(240, 12, 59, 25);
        button1.frame=CGRectMake(240,8, 59, 25);
        [order addSubview:button1];
        button1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LineDetail_reserve.png"]];
        [button1 setTitle:@"预订" forState:UIControlStateNormal];
        
        [button1 addTarget:self action:@selector(order:) forControlEvents:UIControlEventTouchUpInside];
        [order addSubview:button1];
        c=order.frame.origin.y+order.frame.size.height;
    }
    if ((self.tag==2||self.tag==3)&&[self.dataDic2 valueForKey:@"Note"])
    {
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(10, c+10, 100, 20)];
        lable.text=@"个人介绍";
        lable.font=[UIFont boldSystemFontOfSize:16];
        [tabHead2 addSubview:lable];
        
        UILabel*introduce=[[UILabel alloc]initWithFrame:CGRectMake(10, c+40, 300, 0)];
        introduce.numberOfLines=0;
        introduce.textColor=[UIColor grayColor];
        introduce.font=[UIFont systemFontOfSize:16];
        introduce.text=[self.dataDic2 valueForKey:@"Note"];
        CGSize _size=[introduce sizeThatFits:CGSizeMake(300, 0)];
        introduce.frame=CGRectMake(10,  c+40, 300, _size.height);
        [tabHead2 addSubview:introduce];
        
        c+=introduce.frame.size.height;
    }
    tabHead2.frame=CGRectMake(0, a, 320, c);
    return tabHead2;
}
-(void)callPhone:(UIButton*)sender
{
    NSString*str=[title2 objectAtIndex:sender.tag-90];
    NSLog(@"str=========%@",str);
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"（" withString:@"("];
    str=[str stringByReplacingOccurrencesOfString:@"）" withString:@")"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",str]]];
    
}
#pragma mark--浏览相册
-(void)photos
{
    
    
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    view.tag=6;
    view.hidden=YES;
    view.backgroundColor=[UIColor blackColor];
    [self.view addSubview:view];
    
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    _scrollView.delegate=self;
    _scrollView.contentSize=CGSizeMake(320*picUrlArray.count, DeviceHeight);
    _scrollView.pagingEnabled=YES;
    _scrollView.bouncesZoom=YES;
    
    [view addSubview:_scrollView];
    
    
    for (int i=0; i<picUrlArray.count; i++)
    {
        
        
        ImageScrollView*button=[ImageScrollView new];
        button.frame=CGRectMake(320*i, 0, 320,DeviceHeight);
        button.tag=610+i;

         NSString *picName = [picUrlArray[i] objectForKey:@"PicName"];
        NSData *pathData = [NSData dataWithContentsOfFile:PathOfFile(picName)];
       
        if (pathData.length==0) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSString *urlStr = [NSString stringWithFormat:@"%@/%@/%@",PicUrl,_picPath2,picName];//_picPath2
                NSLog(@"picurl %@",urlStr);
                NSURL *url = [NSURL URLWithString:urlStr];
                NSData *data = [NSData dataWithContentsOfURL:url];
                // [NSThread sleepForTimeInterval:2];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data) {
                        [data writeToFile:PathOfFile(picName) atomically:YES];
                        button.imageView.image=[UIImage imageWithData:data];
                    }
                    
                });
            });
        }else button.imageView.image=[UIImage imageWithData:pathData];
     
        
        [_scrollView addSubview:button];
        
        
    }
    imgeHeight=320;
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, DeviceHeight-40, 320, 20)];//图片上的小点
    pageControl.numberOfPages=picUrlArray.count;
    pageControl.currentPage=0;
    pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    pageControl.pageIndicatorTintColor=[UIColor grayColor];
    
    [view addSubview:pageControl];
    
    
    
}
-(void)browse:(UIButton*)sender
{
    self.navigationController.navigationBarHidden=YES;
    UIView*view=(UIView*)[self.view viewWithTag:6];
    view.hidden=NO;
    _scrollView.contentOffset=CGPointMake(pre*320, 0);
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    AppDelegate *mydelegate=[[UIApplication sharedApplication] delegate];
    if ([touch.view isMemberOfClass:[ImageScrollView class]]&&touch.tapCount==1)
    {
        if (mydelegate.isTime==NO)
        {
            [self performSelector:@selector(time) withObject:nil afterDelay:0.5];
            mydelegate.isTime=YES;
        }
        
        NSLog( @"touchTimerArray");
        
    }
    
}


-(void)time
{
    ImageScrollView *imgScrollView = (ImageScrollView *)[_scrollView viewWithTag:610+pre];
    NSLog(@"width==%f",imgScrollView.imageView.frame.size.width);
    NSLog(@"imgeHeight==%f",imgeHeight);
    
    if (imgScrollView.imageView.frame.size.width==imgeHeight)
    {
        UIView*view=(UIView*)[self.view viewWithTag:6];
        view.hidden=YES;
        self.navigationController.navigationBarHidden=NO;
        AppDelegate *mydelegate=[[UIApplication sharedApplication] delegate];
        mydelegate.isTime=NO;
        picScrollView.contentOffset=CGPointMake(320*pre, 0);
        
        ImageScrollView *imgScrollView = (ImageScrollView *)[_scrollView viewWithTag:pre+610];
        
        if ( imgScrollView.zoomScale > 1) {
            imgScrollView.zoomScale = 1;
            imgeHeight=320;
        }
        
    }
    else
    {
        
        imgeHeight=imgScrollView.imageView.frame.size.width;
    }
    NSLog(@"imgeHeight==%f",imgeHeight);
}
#pragma mark--关闭相册
-(void)closePhoto:(UITapGestureRecognizer*)sender
{
    NSLog(@"QQQsender.numberOfTouches=%d",sender.numberOfTouches);
    if (sender.numberOfTouches==2)
    {
        return;
    }
    if (sender.numberOfTouches==1)
    {
      //  [self performSelector:@selector(time:) withObject:sender afterDelay:0.5];
        
    }
    
    
    
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int current = scrollView.contentOffset.x / 320;
    ImageScrollView *imgScrollView = (ImageScrollView *)[scrollView viewWithTag:pre+610];
    
    if (current != pre && imgScrollView.zoomScale > 1) {
        imgScrollView.zoomScale = 1;
        imgeHeight=320;
    }
    
    pre = current;
    
    CGPoint offset= scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pageControl setCurrentPage:offset.x/bounds.size.width];
    if (![self.navName isEqualToString:@"线路介绍"])
    {
        pic_imageLable.text=[NSString stringWithFormat:@"%d/%d",current+1,picUrlArray.count];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
