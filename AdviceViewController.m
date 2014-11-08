//
//  AdviceViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-15.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "AdviceViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
@interface AdviceViewController ()

@end

@implementation AdviceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor=GroupColor;
    scrollView.contentSize=CGSizeMake(320, DeviceHeight+50);
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
    lable.text=@"欢迎你提出宝贵的意见和建议";
    lable.font=[UIFont systemFontOfSize:16];
    [scrollView addSubview:lable];
    
    UIView*textViewView=[[UIView alloc]initWithFrame:CGRectMake(0, 45, 320, 130)];
    textViewView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:textViewView];
    
    textView=[[UITextView alloc]initWithFrame:CGRectMake(5, 45, 310, 130)];
    textView.font=[UIFont systemFontOfSize:17];
    textView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:textView];
 
    
    UIView*textFieldView=[[UIView alloc]initWithFrame:CGRectMake(0, 183, 320, 40)];
    textFieldView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:textFieldView];

   textField2=[[UITextField alloc]initWithFrame:CGRectMake(5, 183, 310, 40)];
    textField2.delegate=self;
 
    textField2.backgroundColor=[UIColor whiteColor];
    textField2.borderStyle=UITextBorderStyleNone;
    textField2.keyboardAppearance=UIKeyboardAppearanceAlert;
    textField2.keyboardType=UIKeyboardTypeEmailAddress;
    textField2.placeholder=@"你的联系方式（邮箱,QQ,手机号码）";
    [scrollView addSubview:textField2];
    {
    ToolBar(textField2)
    }
    ToolBar(textView)
    
   
    Reachability*reach =[Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([reach currentReachabilityStatus]==NotReachable)
    {
        [self.navigationItem setNewTitle:@"(未连接)圣彼得堡天气"];
        
    }
    else
    {
        [self.navigationItem setNewTitle:@"圣彼得堡天气"];
        
        
        
        
    }


	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setNewTitle:@"意见反馈"];
    
       UIButton *backbutton2 = [[UIButton alloc]init] ;
    
    float height=34;
    backbutton2.frame=CGRectMake(0, (44-height)/2, 60, height) ;
    
    backbutton2.titleLabel.font=[UIFont systemFontOfSize:16];
    [backbutton2 setTitle:@"提交" forState:UIControlStateNormal];
  
    [backbutton2 addTarget:self action:@selector(xiala) forControlEvents:UIControlEventTouchUpInside];
    
      UIImage *imgSelected2 = [UIImage imageNamed:@"submit.png"];
       [backbutton2 setBackgroundImage:[imgSelected2 stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    
 
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:backbutton2] ;
       self.navigationItem.rightBarButtonItem =backItem2;
    
   hideTabbar
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
}
-(void)netChange:(NSNotification*)sender
{
    Reachability*reach=[sender object];
    if ([reach currentReachabilityStatus]==NotReachable)
    {
        [self.navigationItem setNewTitle:@"(未连接)意见反馈"];
        
    }
    else
    {
        [self.navigationItem setNewTitle:@"意见反馈"];
        
        
        
        
    }
}

dismissKey(textView, textField2)
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //第二种取消键盘时间点（按下Return键）
//    if ([text isEqualToString:@"\n"])
//    {
        [textField resignFirstResponder];
//    }
  return YES;
}

backButton
-(void)xiala
{
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    
    NSString*ID=[NSString stringWithFormat:@"%d",[defaults integerForKey:@"QuseID"]];
    NSString*name=[defaults valueForKey:@"useName"];
    
    if ([defaults integerForKey:@"QuseID"])
    {
        if (![textView.text isEqual:@""])
        {
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
            NSLog(@"time=%@",[formatter stringFromDate:[NSDate date]]);
            
            NSString *canshu=[NSString stringWithFormat:@"UserID=%@&UserName=%@&Content=%@&Contact=%@&PTime=%@&cityid=%d",ID,name,textView.text,textField2.text,[formatter stringFromDate:[NSDate date ]],2];
            
            NSMutableString*urlDomain=RussiaUrl
            NSString *urlMethod=@"addFeedback";
            [urlDomain appendString:urlMethod];
//            postRequestTongBu(canshu, urlDomain, received)
//            dicResultTongbu(received, result, dic)
            postRequestYiBu(canshu, urlDomain)
         
            
        }
        else
        {  UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    scrollView.contentOffset=CGPointMake(0, 80);
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{

    scrollView.contentOffset=CGPointMake(0, 0);
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    datas=[[NSMutableData alloc]init];
    
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [datas appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"---------");
//    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"发送成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
//    NSString *str=[[NSString alloc] initWithData:datas encoding:NSUTF8StringEncoding];
//    NSLog(@"str=%@",str);
    
    dicResultYiBuNoDic(datas, result)
    NSLog(@"----------%d",[result intValue]);
    if ([result intValue])
    {
        UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"反馈成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        textView.text=nil;
    }
    else
    {
        UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"反馈失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"000000000");
    UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"发送失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
