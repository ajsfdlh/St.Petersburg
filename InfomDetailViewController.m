//
//  InfomDetailViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-17.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "InfomDetailViewController.h"
#import "RTLabel.h"
#import "JSON.h"
#import "GDataXMLNode.h"

@interface InfomDetailViewController ()

@end

@implementation InfomDetailViewController

NetChange(noNetButton)
-(void)viewWillAppear:(BOOL)animated
{
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
    [self.navigationItem setNewTitle:@"资讯正文"];

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}
- (void)relodata:(UIRefreshControl*)refresh{
    NSLog(@"%@",refresh);
     [navActivity startAnimating];
    NSDictionary*dic1 ;
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    if ([self.pageName isEqualToString:@"消息中心"])
    {
        dataArray=[defaults objectForKey:@"dataArray"];
        
        
        dic1=[dataArray objectAtIndex:self.ID];
        
    }
    else
    {
        
        NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
        NSString*canshu=[NSString stringWithFormat:@"ID=%@",ID];
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getNewsDetail";
        [urlDomain appendString:urlMethod];
        
        postRequestTongBu(canshu, urlDomain, received)
        dicResultTongbu(received, result, dic)
        
        
        dic1=[[dic valueForKey:@"ds"]lastObject];
    }
    NSString *HTMLData=[NSString stringWithFormat:@"<div id='foo' style='line-height:1.5'><font size=3 >%@</font></div>",[dic1 valueForKey:@"Content"]] ;
    [_webView loadHTMLString:HTMLData baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
   
}

//NoNetButton(noNetButton)
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    
    navActivity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    navActivity.frame=CGRectMake(65+(8-4)*10, (44- navActivity.frame.size.height)/2, navActivity.frame.size.width,  navActivity.frame.size.height);
    [self.navigationController.navigationBar addSubview:navActivity];
    [navActivity startAnimating];
    
    
    
     NSLog(@"received====");
    NSDictionary*dic1 ;
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    if ([self.pageName isEqualToString:@"消息中心"])
    {
        dataArray=[defaults objectForKey:@"dataArray"];
    
    
     dic1=[dataArray objectAtIndex:self.ID];
    
    }
    else
    {
   
    NSString*ID=[NSString stringWithFormat:@"%d",self.ID];
    NSString*canshu=[NSString stringWithFormat:@"ID=%@",ID];
    NSMutableString*urlDomain=RussiaUrl2
    NSString *urlMethod=@"getNewsDetail";
    [urlDomain appendString:urlMethod];

   postRequestTongBu(canshu, urlDomain, received)
    dicResultTongbu(received, result, dic)
   
  
    dic1=[[dic valueForKey:@"ds"]lastObject];
    }
   _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    _scrollView.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:_scrollView];
    RTLabel*head=[[RTLabel alloc]initWithFrame:CGRectMake(10, 10, 300,40)];
    head.text=[dic1 valueForKey:@"Title"];
    head.font=[UIFont systemFontOfSize:18];
    head.font=[UIFont boldSystemFontOfSize:18];
    CGSize headSize=[head optimumSize];
     head.frame=CGRectMake(10, 10, 310,headSize.height );
    [_scrollView addSubview:head];
  time=[[RTLabel alloc]initWithFrame:CGRectMake(10,head.frame.origin.y+head.frame.size.height+5, 310,40)];
    NSString*strtime=[dic1 valueForKey:@"PTime"];
    
    
    time.text=[strtime stringByReplacingOccurrencesOfString:@"/" withString:@"."];

    time.textColor=[UIColor grayColor];
    time.font=[UIFont systemFontOfSize:12];
    CGSize timeSize=[time optimumSize];
    time.frame=CGRectMake(10,head.frame.origin.y+head.frame.size.height+5, 310,timeSize.height );
    [_scrollView addSubview:time];
    

    
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(10, time.frame.origin.y+time.frame.size.height, 300, 20)];
    _webView.delegate=self;
       _webView.scrollView.bounces=YES;
    _webView.scrollView.scrollEnabled=NO;
    _webView.backgroundColor = [UIColor clearColor];
   NSString *HTMLData=[NSString stringWithFormat:@"<div id='foo' style='line-height:1.5'><font size=3 >%@</font></div>",[dic1 valueForKey:@"Content"]] ;
    
//    [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]
     [_webView loadHTMLString:HTMLData baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
      [_scrollView addSubview:_webView];
    
    noNetButton=NoNetButton(noNetButton);
    
    Reachability*rea2 =[Reachability reachabilityWithHostName:@"www.baidu.com"];if ([rea2  currentReachabilityStatus]==NotReachable)
    {
        
        noNetButton.hidden=NO;
    }
    else
    {
        noNetButton.hidden=YES;
    }

    refresh = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
    [refresh addTarget:self action:@selector(relodata:) forControlEvents:UIControlEventValueChanged];
    [_webView addSubview:refresh];
//    CGFloat webViewHeight=[_webView.scrollView contentSize].height;
    
   //在 WebView 中显示本地的字符串

	// Do any additional setup after loading the view.
}
GO_NET
-(void)viewDidDisappear:(BOOL)animated
{
    [navActivity removeFromSuperview];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [navActivity stopAnimating];
    [refresh endRefreshing];
    [QYHMeThod changeImageWidthHeight:webView];
    
       
    NSString *htmlHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"foo\").offsetHeight;"];
    _scrollView.contentSize = CGSizeMake(320, 120+[htmlHeight intValue]);
    CGRect frame=_webView.frame;
    [_webView setFrame:CGRectMake(0, frame.origin.y, 320, [htmlHeight intValue]+100)];

//    _scrollView.contentSize=CGSizeMake(320, _webView.frame.origin.y+_webView.frame.size.height+20);
  
    


}
backButton
postRequestAgency(datas)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //dicResultYiBu(datas, result, dic)
    dicResultYiBuNoDic(datas, result)
    NSLog(@"result=%@",result);
 
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
