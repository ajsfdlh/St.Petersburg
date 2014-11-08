//
//  TravelViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-18.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "TravelViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
#import "ComentCell.h"
@interface TravelViewController ()

@end

@implementation TravelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
backButton
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
                
                
                NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
                NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&typeid=%d&classid=%d",ID,f,1,1];
                NSMutableString*urlDomain2=RussiaUrl2
                NSString *urlMethod=@"UnColloLike";
                [urlDomain2 appendString:urlMethod];
                postRequestYiBu(canshu, urlDomain2)
                isLike=YES;
                
            }
            
            if (alertView.tag==21)
            {
                NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
                NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&typeid=%d&classid=%d",ID,f,2,1];
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
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationItem setNewTitle:@"游记正文"];
    
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int f=[defaults integerForKey:@"QuseID"];
    if (f)
    {
        [self performSelector:@selector(checkLike:) withObject:[NSNumber numberWithInt:f] afterDelay:0.1];
    }
    
    
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
    
}
NetChange(noNetButton)
GO_NET
-(void)checkLike:(id)f
{
    NSString*canshu=[NSString stringWithFormat:@"ID=%d&userid=%d&typeid=%d&classid=%d",self.ID,[f intValue],1,1];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"CheckColloLike";
    [urlDomain appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomain)
    checkLike=YES;
    
    [self performSelector:@selector(checkCllecet:) withObject:[NSNumber numberWithInt:[f integerValue]] afterDelay:0.1];
    
    
}
-(void)checkCllecet:(id)f
{
    
    NSString*canshu=[NSString stringWithFormat:@"ID=%d&userid=%d&typeid=%d&classid=%d",self.ID,[f intValue],2,1];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"CheckColloLike";
    [urlDomain appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomain)
    checkCollect=YES;
    
    
}
-(UIView*)creatTabHead
{

    _scrollView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];

    head=[[RTLabel alloc]initWithFrame:CGRectMake(5, 5, 310,0)];
    head.text=[dic1 valueForKey:@"Title"];
    
    NSLog(@"%@----",[dic1 valueForKey:@"Title"]);
    head.font=[UIFont systemFontOfSize:18];
    head.font=[UIFont boldSystemFontOfSize:18];
    
    CGSize headSize=[head optimumSize];
    head.frame=CGRectMake(10, 10, 310,headSize.height );
    [_scrollView addSubview:head];
    
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, head.frame.origin.y+head.frame.size.height+5, 30, 30)];
    if (self.userImage)
    {
        imageView.image=self.userImage;

    }
    else
    {
    
        imageView.image=[UIImage imageNamed:@"defaultHead.jpg"];
    }
    
    [_scrollView addSubview:imageView];
    
    
    Name=[[UILabel alloc]initWithFrame:CGRectMake(50-2, head.frame.origin.y+head.frame.size.height+5, 150, 30)];
    Name.text=[dic1 valueForKey:@"UserName"];
    
    Name.textColor=[UIColor blueColor];
    [_scrollView addSubview:Name];
    
    
    time=[[RTLabel alloc]initWithFrame:CGRectMake(10,imageView.frame.origin.y+imageView.frame.size.height+5, 310,20)];
    
    NSMutableString*strtime=[dic1 valueForKey:@"PTime"];
    [strtime replaceOccurrencesOfString:@"/" withString:@"-" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 10)];
    
    
    time.text=strtime;
    
    time.textColor=[UIColor grayColor];
    [_scrollView addSubview:time];
    
    
    
    
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(10, time.frame.origin.y+time.frame.size.height, 300, 20)];
    _webView.delegate=self;
    _webView.scrollView.bounces=YES;
    _webView.scrollView.scrollEnabled=NO;
    _webView.backgroundColor =[UIColor redColor];
    NSString *HTMLData=[NSString stringWithFormat:@"<div id='foo' style='line-height:1.5'><font size=3 line-height=25>%@</font></div>",[dic1 valueForKey:@"Content"]];
    
    //    [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]
    [_webView loadHTMLString:HTMLData baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    [_scrollView addSubview:_webView];
    
    
    return _scrollView;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [navActivity stopAnimating];
    [refresh endRefreshing];
    [QYHMeThod changeImageWidthHeight:webView];
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"foo\").offsetHeight;"];
    _scrollView.frame=CGRectMake(0, 0, 320, 100+[htmlHeight intValue]);
    CGRect frame=_webView.frame;
    _webView.backgroundColor=GroupColor;
    [_webView setFrame:CGRectMake(0, frame.origin.y, 320, [htmlHeight intValue]+100)];
    _tableView.tableHeaderView=_scrollView;
    
}

postRequestAgency(datas)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    dicResultYiBu(datas, result, dic)
     NSDictionary* _dic1=[[dic valueForKey:@"ds"]lastObject];
    if (_loadingMore==YES)
    {
        _loadingMore=NO;
        if ([_dic1 valueForKey:@"ArtID"])
        {
            for (int i=0; i<[[dic valueForKey:@"ds"]count]; i++)
            {
                array=[array arrayByAddingObject:[[_dic1 valueForKey:@"ds"]objectAtIndex:i]];
            }
        }
        else
        {
         [self loadDataEnd:@""];
        }
        [_tableView reloadData];
        return;
    }
    
    
    if ([[_dic1 valueForKey:@"Content"]length]>0)
    {
        if ([_dic1 valueForKey:@"Msgcount"]!=nil)
        {
            
            dic1=[NSDictionary dictionaryWithDictionary:_dic1];
            [self creatTabHead];
            [self createTableFooter:@"上拉显示跟多评论"];
            
        }
        
        else
        {
            array=[array arrayByAddingObjectsFromArray:[dic valueForKey:@"ds"]];
            NSLog(@"%@",@"评论评论评论评论评论");
            [self loadDataEnd:@"上拉显示更多评论"];
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
    [refresh endRefreshing];
        [_tableView reloadData];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [navActivity removeFromSuperview];
    
}
- (void)refreshData{
    [navActivity startAnimating];
    NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
    NSString*canshu=[NSString stringWithFormat:@"ID=%@",ID];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"getTravelDetail";
    [urlDomain appendString:urlMethod];
    //        NSString *urlStr=[NSString stringWithFormat:@"%@Service1.asmx/UserLogin",RussiaUrl];
    postRequestYiBu(canshu, urlDomain)
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    navActivity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    navActivity.frame=CGRectMake(65+(8-4)*10, (44- navActivity.frame.size.height)/2, navActivity.frame.size.width,  navActivity.frame.size.height);
    [self.navigationController.navigationBar addSubview:navActivity];
    [navActivity startAnimating];
   
    
    
    self.view.backgroundColor=GroupColor;
    index1=0;
    _loadingMore = NO;
    isLike=NO;
    isComent=NO;
    isCollect=NO;
    isComentDone=NO;
    
    checkCollect=NO;
    checkLike=NO;
    checkLikeNum=@"没有喜欢";
    checkCollectNum=@"没有收藏";
    
    array=[NSArray new];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
    NSString*canshu=[NSString stringWithFormat:@"ID=%@",ID];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"getTravelDetail";
    [urlDomain appendString:urlMethod];
    //NSString *urlStr=[NSString stringWithFormat:@"%@Service1.asmx/UserLogin",RussiaUrl];
    postRequestYiBu(canshu, urlDomain)
    
    
    
    
    
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
//    _tableView.backgroundColor=GroupColor;
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];
   
    refresh=[[UIRefreshControl alloc] init];
    refresh.tintColor=[UIColor clearColor];
    refresh.attributedTitle=[[NSAttributedString alloc] initWithString:@""];
    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refresh];
    
    
    UIImageView*guding=[[UIImageView alloc]initWithFrame:CGRectMake(0,  DeviceHeight-64-45, 320, 45)];
    //    guding.alpha=0.8;
    guding.userInteractionEnabled=YES;
    guding.image=[UIImage imageNamed:@"guding.png"];
    
    [self.view addSubview:guding];
    NSArray*tabfootImage=@[@"Coment.png",@"Like.png",@"Collect.png",@"Share.png"];
    NSArray*tabfootImagehight=@[@"Coment_h.png",@"Like_h.png",@"Collect_h.png",@"Share_h.png"];
  //  NSArray*titleArray=@[@"点评",@"喜欢",@"收藏",@"分享"];
    for (int i=0; i<4; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=400+i;
        button.frame=CGRectMake(12+80*i, 11, 56, 28);
        [button setImage:[UIImage imageNamed:[tabfootImage objectAtIndex:i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[tabfootImagehight objectAtIndex:i]] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        [guding addSubview:button];
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
    

	// Do any additional setup after loading the view.
}

-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = self.view.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
    //	self.view.frame = containerFrame;
    self.view.frame = CGRectMake(0, containerFrame.origin.y+64, containerFrame.size.width, containerFrame.size.height);
    
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	// get a rect for the textView frame
	CGRect containerFrame = self.view.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
    //	self.view.frame = containerFrame;
    self.view.frame = CGRectMake(0, containerFrame.origin.y+64, containerFrame.size.width, containerFrame.size.height);
	// commit animations
	[UIView commitAnimations];
}
-(void)touch:(UIButton*)sender
{
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    switch (sender.tag)
    {
            
            
        case 400:
        {
            
            int ss=[defaults integerForKey:@"QuseID"];
            if (ss)
            {
                ComentViewController*text=[ComentViewController new];
                    text.pageName=@"游记评论";
                    text.head=[dic1 valueForKey:@"Title"];
                    text.eTittle=[dic1 valueForKey:@"Msgcount"];
                    text.type=9;
                    text.ID=self.ID;
                [self.navigationController pushViewController:text animated:NO];
                
//                UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"此功能暂未开通" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alertView show];

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
            
            int ss=[defaults integerForKey:@"QuseID"];
            if (ss)
            {
                
                
                if ([checkLikeNum isEqualToString:@"没有喜欢"])
                {
                    NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
                    NSString*canshu=[NSString stringWithFormat:@"cityid=%d&ID=%@&userid=%d&username=%@&typeid=%d&classid=%d",2,ID,ss,[defaults valueForKey:@"useName"],1,1];
                    
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
                    NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
                    NSString*canshu=[NSString stringWithFormat:@"cityid=%d&ID=%@&userid=%d&username=%@&typeid=%d&classid=%d",2,ID,ss,[defaults valueForKey:@"useName"],2,1];
                    
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
-(void)send
{
    [_texteView resignFirstResponder];
    //    tableFooterView.frame=CGRectMake(0, DeviceHeight-64-50, 320, 50);
    
    
    
    
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int b=[defaults integerForKey:@"QuseID"];
    if (b)
    {
        if (![_texteView.text isEqualToString:@""])
        {
            NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
            NSLog(@"ID====%@",ID);
            NSString*canshu=[NSString stringWithFormat:@"ID=%@&userid=%d&username=%@&content=%@",ID,b,[defaults valueForKey:@"useName"],_texteView.text];
            NSMutableString*urlDomain=RussiaUrl2
            NSString *urlMethod=@"getAddTravelMessage";
            [urlDomain appendString:urlMethod];
            postRequestYiBu(canshu, urlDomain)
            isComent=YES;
            
        }
        else
        {
            UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"评论不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertView show];
            
            
        }
        
    }
    else
    {
        MineViewController*mine=[MineViewController new];
        mine.tag=1;
        [self.navigationController pushViewController:mine animated:NO];
        //      MainTabarController*main=(MainTabarController*)self.navigationController.tabBarController;
        //
        //      main.selectedIndex=3;
        //      UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"请先登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertView show];
        //      self.navigationControll
        
        
    }
    
    
    
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    UIView*view=touch.view;
//    if ( ![view isKindOfClass:[UITextView class]])
//        
//    {
//        NSLog(@"--------");
//        [_texteView resignFirstResponder];
//        //        tableFooterView.frame=CGRectMake(0, DeviceHeight-64-50, 320, 50);
//    }
//    
//    
//    
//    
//}
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    UITouch *touch = [touches anyObject];
//    //    self.touchTimer = [touch timestamp]-self.touchTimer;
//    //    NSLog(@"----%f",self.touchTimer);
//    
//    //    NSUInteger tapCount = [touch tapCount];
//    //    CGPoint touchPoint = [touch locationInView:scrollView];
//    UIView*view=touch.view;
//    //判断单击事件，touch时间和touch的区域
//    
//    if (![view isKindOfClass:[UITextView class]])
//        
//    {
//        NSLog(@"--------");
//        [_texteView resignFirstResponder];
//    }
//    
//    
//    
//    
//}

-(void)dismissKey
{
    [_texteView resignFirstResponder];
    //    tableFooterView.frame=CGRectMake(0, DeviceHeight-64-50, 320, 50);
    //
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"cell";
    ComentCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[ComentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.name.text=[[array objectAtIndex:indexPath.row]valueForKey:@"UserName"];
    NSLog(@"%@77777777",[[array objectAtIndex:indexPath.row]valueForKey:@"UserName"]);
    NSString*str2=[[array objectAtIndex:indexPath.row]valueForKey:@"PTime"];
    
    cell.date.text=[str2 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    cell.comment.text=[[array objectAtIndex:indexPath.row]valueForKey:@"Content"];
    CGSize size=[cell.comment optimumSize];
    cell.comment.frame=CGRectMake(40, 35, 270, size.height);
    cell._imageView.frame=CGRectMake(5, cell.comment.frame.origin.y+cell.comment.frame.size.height+20, 310, 1);
    height2=cell.comment.frame.origin.y+cell.frame.size.height+20;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ComentCell*cell=(ComentCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGSize size=cell.comment.frame.size;
    
    return  size.height+56;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    
    // 下拉到最底部时显示更多数据
    
    if(!_loadingMore && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height+10)))
        
    {
        
        [self loadDataBegin];
        
    }
    
}


// 开始加载数据

- (void) loadDataBegin

{
    
    if (_loadingMore == NO)
        
    {
        
        _loadingMore = YES;
        
        UILabel*lable=(UILabel*)[self.view viewWithTag:2];
        lable.text=@"";
        UIActivityIndicatorView *tableFooterActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150.0f, 10.0f, 20.0f, 20.0f)];
        
        [tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        
        [tableFooterActivityIndicator startAnimating];
        
        [_tableView.tableFooterView addSubview:tableFooterActivityIndicator];
        
        
        
        [self loadDataing];
        
    }
    
}


// 加载数据中

- (void) loadDataing

{
   
    //    dataNumber = [tableData count];
      index1++;
    NSString*canshu=[NSString stringWithFormat:@"ID=%d&pagesize=%d&pageindex=%d",self.ID,10,index1];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"getTravelMessage";
    [urlDomain appendString:urlMethod];
    
    postRequestYiBu(canshu, urlDomain)
   
    
    
}


// 加载数据完毕

- (void) loadDataEnd:(NSString*)text

{
    
    _loadingMore = NO;
    
    [self createTableFooter:text];
    
}


// 创建表格底部

- (UIView*) createTableFooter:(NSString*)text

{
    NSLog(@"%s",__func__);
    UIView *_tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tableView.bounds.size.width, 40.0f)];

    
    return _tableFooterView;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
