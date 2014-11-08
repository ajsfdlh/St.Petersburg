//
//  TimeAndMoneyViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-24.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "TimeAndMoneyViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
@interface TimeAndMoneyViewController ()

@end

@implementation TimeAndMoneyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
     MainTabarController*main=(MainTabarController*)self.tabBarController;main.customizedBar.hidden=YES;
    
    [self setTitle:self.pageName];
    if ([self.pageName isEqualToString:@"时间"])
    {
        [clock1 start];
        [clock2 start2];
    }
   
//    [clockView1_1 start2];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    float height=35;
    UIButton *backbutton = [[UIButton alloc]init];backbutton.frame=CGRectMake(0, (44-height)/2, 55, height);[backbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(-5, 10, 15, 15)];
    imageView.image=[UIImage imageNamed:@"_back.png"];[backbutton addSubview:imageView];
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 35)];
    lable.font=[UIFont systemFontOfSize:15];lable.textColor=[UIColor whiteColor];
    lable.text=@"返回";
    [backbutton addSubview:lable];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backbutton];
    self.navigationItem.leftBarButtonItem =backItem;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
   str=[NSMutableString new];
     str1=[NSMutableString new];
     str2=[NSMutableString new];
    USDCNY=0;
    USDRUB=0;
    USDEUR=0;
//    NSString *canshu=[NSString stringWithFormat:@"UserID=%@&UserName=%@&Content=%@&Contact=%@&PTime=%@&cityid=%d",ID,name,textView.text,textField.text,[formatter stringFromDate:[NSDate date ]],2];
    
//    NSMutableString*urlDomain=RussiaUrl
//    NSString *urlMethod=@"addFeedback";
//    [urlDomain appendString:urlMethod];
     self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"moneyBack.png"]];
    if ([self.pageName isEqualToString:@"货币"])
    {
        
         Reachability*rea2 =[Reachability reachabilityWithHostName:@"www.baidu.com"];if ([rea2  currentReachabilityStatus]==NotReachable){UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败，无法获取当前汇率" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertView show];}
        NSURL *url = [NSURL URLWithString:@"http://download.finance.yahoo.com/d/quotes.csv?e=.csv&f=sl1d1t1&s=USDCNY=x"];
        
        
        
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        
        [connection start];
        [self performSelector:@selector(getRUB) withObject:nil afterDelay:0.2];
        

    }
    
    
    
    
//    UIImageView*imageView=[UIImageView alloc]initWithFrame:CGRectMake(15, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
   Money=[[UIScrollView alloc]initWithFrame:self.view.frame];
    Money.contentSize=CGSizeMake(320, DeviceHeight+50);
    [self.view addSubview:Money];
    NSArray*MoneyImage=[NSArray arrayWithObjects:@"moneyCNY.png",@"moneyRUB.png",@"moneyUSD.png" ,@"moneyEUR.png" ,nil];
//     NSArray*MoneyTitle=[NSArray arrayWithObjects:@"人民币(CNY)",@"卢布(RUB)",@"美元(USB)",@"欧元(EUR)" ,nil];
 for (int i=0; i<4; i++)
 {
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20+71.5*i, 300, 51.5)];
    imageView.userInteractionEnabled=YES;
    imageView.image=[UIImage imageNamed:[MoneyImage objectAtIndex:i]];
    [Money addSubview:imageView];
   
    UITextField*textField=[[UITextField alloc]initWithFrame:CGRectMake(70, 25, 220, 30)];
    textField.tag=10+i;
    textField.delegate=self;
     textField.keyboardType=UIKeyboardTypeNumberPad;
    textField.font=[UIFont systemFontOfSize:20];
//    textField.backgroundColor=[UIColor blueColor];
     textField.textColor=[UIColor whiteColor];
    textField.placeholder=@"0.00";
    [imageView addSubview:textField];
    
    
    
    
    UIToolbar*toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    toolBar.translucent=YES;
//    UIBarButtonItem *barButton1=[[UIBarButtonItem alloc]initWithTitle:@"Hello" style: UIBarButtonItemStyleBordered target:self action:@selector(didClickHello)];
//    
    UIBarButtonItem *barButton3=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    UIBarButtonItem *barButton2=[[UIBarButtonItem alloc]initWithTitle:@"完成" style: UIBarButtonItemStyleDone target:self action:@selector(dismissKey)];
    NSArray*array=[[NSArray alloc]initWithObjects:barButton3, barButton2 ,nil];
    toolBar.items=array;
    [textField setInputAccessoryView:toolBar];
  
          
        
        
        
        
        
        
    }
    if ([self.pageName isEqualToString:@"时间"])
    {
        Money.hidden=YES;
        NSArray*s=[NSArray arrayWithObjects:@"北京",@"圣彼得堡", nil];
        for (int i = 0; i<2; i++)
        {
            UIImageView*beijing=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10+160*i, 300, 150)];
            beijing.image=[UIImage imageNamed:@"TimeBck.png"];
            [self.view addSubview:beijing];
            
            UILabel*date=[[UILabel alloc]initWithFrame:CGRectMake(150, 20, 140, 20)];
            date.textColor=[UIColor greenColor];
            date.textAlignment=NSTextAlignmentCenter;
//            date.text=[s objectAtIndex:i];
            date.tag=300+i;
            date.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"dateColor.png"]];
            date.textAlignment=NSTextAlignmentCenter;
            [beijing addSubview:date];
            
            
            
            UIImageView*Location=[[UIImageView alloc]initWithFrame:CGRectMake(150, 45, 140, 40)];
            Location.image=[UIImage imageNamed:@"TimeLable.png"];
            [beijing addSubview:Location];
            
            UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 40)];
            lable.text=[s objectAtIndex:i];
            lable.textColor=[UIColor whiteColor];
            lable.textAlignment=NSTextAlignmentCenter;
            [Location addSubview:lable];

            
            UILabel*timeLable=[[UILabel alloc]initWithFrame:CGRectMake(150, 90, 140, 40)];
            timeLable.font=[UIFont systemFontOfSize:31];
            timeLable.tag=200+i;
            timeLable.backgroundColor=[UIColor clearColor];
            timeLable.textColor=[UIColor whiteColor];
            timeLable.textAlignment=NSTextAlignmentCenter;
            [beijing addSubview:timeLable];
        }
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(Time) userInfo:nil repeats:YES ];
        
        clock1=[[ClockView alloc]initWithFrame:CGRectMake(15, 16.5, 137.5, 137.5)];
        clock2=[[ClockView alloc]initWithFrame:CGRectMake(15, 176.5, 137.5, 137.5)];
        [self.view addSubview:clock1];
        [self.view addSubview:clock2];
        
        
        //            clock2=[[ClockView alloc]initWithFrame:CGRectMake(clock1.frame.origin.x+clock1.frame.size.width+15, 100, 137.5, 137.5)];
        //            [self.view addSubview:clock2];
        
        [clock1 setClockBackgroundImage:[UIImage imageNamed:@"TimeBell.png"].CGImage];
        [clock1 setHourHandImage:[UIImage imageNamed:@"tool_hour.png"].CGImage];
        [clock1 setMinHandImage:[UIImage imageNamed:@"tool_minute.png"].CGImage];
        [clock1 setSecHandImage:[UIImage imageNamed:@"tool_second.png"].CGImage];
        
        [clock2 setClockBackgroundImage:[UIImage imageNamed:@"TimeBell.png"].CGImage];
        [clock2 setHourHandImage:[UIImage imageNamed:@"tool_hour.png"].CGImage];
        [clock2 setMinHandImage:[UIImage imageNamed:@"tool_minute.png"].CGImage];
        [clock2 setSecHandImage:[UIImage imageNamed:@"tool_second.png"].CGImage];
        

    
}
    
    
	// Do any additional setup after loading the view.
}
-(void)getRUB
{
    NSURL *url2= [NSURL URLWithString:@"http://download.finance.yahoo.com/d/quotes.csv?e=.csv&f=sl1d1t1&s=USDRUB=x"];
    
    
    
    NSURLRequest *request2 = [[NSURLRequest alloc]initWithURL:url2 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    NSURLConnection *connection2 = [[NSURLConnection alloc]initWithRequest:request2 delegate:self];
     [self performSelector:@selector(getEUR) withObject:nil afterDelay:0.2];
    [connection2 start];
}
-(void)getEUR
{


    NSURL *url2= [NSURL URLWithString:@"http://download.finance.yahoo.com/d/quotes.csv?e=.csv&f=sl1d1t1&s=USDEUR=x"];
    
    
    
    NSURLRequest *request2 = [[NSURLRequest alloc]initWithURL:url2 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    NSURLConnection *connection2 = [[NSURLConnection alloc]initWithRequest:request2 delegate:self];
    [connection2 start];

}
postRequestAgency(datas)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{

  NSString*  result = [[NSString alloc] initWithData:datas encoding:NSUTF8StringEncoding];
    
    NSLog(@"result=%@",result);
    
    NSArray*RUB=[result componentsSeparatedByString:@","];
    if ([[[RUB objectAtIndex:0] substringWithRange:NSMakeRange(4, 1)]isEqualToString:@"R"])
    {
        
        USDRUB=[[RUB objectAtIndex:1]floatValue];
    }
    
    if ([[[RUB objectAtIndex:0] substringWithRange:NSMakeRange(4, 1)]isEqualToString:@"C"])
    {
        USDCNY=[[RUB objectAtIndex:1]floatValue];
    }

    if ([[[RUB objectAtIndex:0] substringWithRange:NSMakeRange(4, 1)]isEqualToString:@"E"])
    {
        USDEUR=[[RUB objectAtIndex:1]floatValue];
    }


}
-(void)Time
{

    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit| NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
    
    
    NSDateComponents *dateComponents2 = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit| NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate dateWithTimeIntervalSinceNow:-4*60*60]];
    
    
    NSInteger year=[dateComponents year];
     NSInteger month=[dateComponents month];
     NSInteger day=[dateComponents day];
	NSInteger seconds = [dateComponents second];
	NSInteger minutes = [dateComponents minute];
    NSInteger hours =[dateComponents hour];

	NSInteger hours1 =[dateComponents2 hour];
    NSInteger year2=[dateComponents2 year];
    NSInteger month2=[dateComponents2 month];
    NSInteger day2=[dateComponents2 day];

    UILabel*lable1=(UILabel*)[self.view viewWithTag:200];
    lable1.text=[NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
    UILabel*lable2=(UILabel*)[self.view viewWithTag:201];
    lable2.text=[NSString stringWithFormat:@"%02d:%02d:%02d",hours1,minutes,seconds];
    UILabel*lable3=(UILabel*)[self.view viewWithTag:300];
    lable3.text=[NSString stringWithFormat:@"%04d-%02d-%02d",year,month,day];
  
  
    UILabel*lable4=(UILabel*)[self.view viewWithTag:301];
    lable4.text=[NSString stringWithFormat:@"%04d-%02d-%02d",year2,month2,day2];
    

//    NSLog(@"year=%d",year);
//NSLog(@"month=%d",month);NSLog(@"day=%d",day);



}
-(void)dismissKey
{
    UITextField*text=(UITextField*)[self.view viewWithTag:10];
    UITextField*text1=(UITextField*)[self.view viewWithTag:11];
    UITextField*text2=(UITextField*)[self.view viewWithTag:12];
      UITextField*text3=(UITextField*)[self.view viewWithTag:13];
    [text resignFirstResponder];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField*text1=(UITextField*)[self.view viewWithTag:(textField.tag-10+1)%4+10];
    UITextField*text2=(UITextField*)[self.view viewWithTag:(textField.tag-10+2)%4+10];
    UITextField*text3=(UITextField*)[self.view viewWithTag:(textField.tag-10+3)%4+10];
    NSLog(@"tag=%d",textField.tag);
//    if (textField.tag==10)
//    {
        str= [NSMutableString stringWithString: [textField.text  stringByAppendingString:string] ];

//    }
    
    
      int a=[str length];
    if ([string isEqualToString:@""])
    {
        [str deleteCharactersInRange:NSMakeRange(a-1, 1)];
        NSLog(@"shangchu");
    }
    NSLog(@"string=%@",string);
    float _chinese=0.0;
    NSLog(@"%f----",_chinese);
    float _russia=0.0;
    float _US = 0.0;
    float _EUR=0.0;
    if (textField.tag==10)
    {
       
        
//        NSLog(@"text====%@",text.text);
        
        _chinese=[str floatValue];
        NSLog(@"%f----",_chinese);
        
        
        if (USDCNY!=0&&USDRUB!=0)
        {
            _russia=_chinese*(USDRUB/USDCNY);
            _US=_chinese*1/USDCNY;
            _EUR=_chinese*(USDEUR/USDCNY);
        }
        else
        {
         _russia=_chinese*5.8250;
         _US=_chinese*0.1641;
        }
      
        text1.text=[NSString stringWithFormat:@"%.2f",_russia];
        text2.text=[NSString stringWithFormat:@"%.2f",_US];
        text3.text=[NSString stringWithFormat:@"%.2f",_EUR];
        

        
    }
 
    if (textField.tag==11)
    {
        
        
        //        NSLog(@"text====%@",text.text);
         _russia=[str floatValue];
        
        if (USDCNY!=0&&USDRUB!=0)
        {
            _chinese=USDCNY/USDRUB*_russia;
            _EUR=USDEUR/USDRUB*_russia;
            _US=_russia*(1/USDRUB);
        }
        else
        {

        
       _chinese=0.1720*_russia;
        NSLog(@"%f----",_chinese);
       
        _US=_russia*0.02825;
        }
        text1.text=[NSString stringWithFormat:@"%.2f",_US];
        text2.text=[NSString stringWithFormat:@"%.2f",_EUR];
        text3.text=[NSString stringWithFormat:@"%.2f",_chinese];
        
    }
    if (textField.tag==12)
    {
        
        
        //        NSLog(@"text====%@",text.text);
         _US=[str floatValue];
        if (USDCNY!=0&&USDRUB!=0)
        {
            _chinese=_US*USDCNY;
            NSLog(@"%f----",_chinese);
            _russia=_US*USDRUB;
            _EUR=_US*USDEUR;

        }
        else
        {
            

        _chinese=_US*6.0977;
        NSLog(@"%f----",_chinese);
        _russia=_US*35.4015;
        
        }
        text1.text=[NSString stringWithFormat:@"%.2f",_EUR];
        text2.text=[NSString stringWithFormat:@"%.2f",_chinese];
         text3.text=[NSString stringWithFormat:@"%.2f",_russia];
        
        
    }
     if (textField.tag==13)
    {
        _EUR=[str floatValue];
        if (USDCNY!=0&&USDRUB!=0)
        {
            _chinese=USDCNY/USDEUR*_EUR;
            _russia=USDRUB/USDEUR*_EUR;
            _US=_EUR*(1/USDEUR);
           
            
        }
        else
        {
            
            
            _chinese=_US*6.0977;
            NSLog(@"%f----",_chinese);
            _russia=_US*35.4015;
        }
        text1.text=[NSString stringWithFormat:@"%.2f",_chinese];
        text2.text=[NSString stringWithFormat:@"%.2f",_russia];
         text3.text=[NSString stringWithFormat:@"%.2f",_US];
        
        
    }
    if ([str isEqualToString:@""])
    {
        textField.text=@"";
        text1.text=@"";
        text2.text=@"";
        
    }


    return YES;
}
- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
	if (numberKeyPad) {
		numberKeyPad.currentTextField = textField;
	}
//    UIButton*button=[UIButton buttonWithType:<#(UIButtonType)#>]
    
    
	return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
	//if (![textField isEqual:normal]) {
    
    Money.contentOffset=CGPointMake(0, 0)
    ;

	if (textField == numberKeyPad.currentTextField) {
		/*
		 Hide the number keypad
         */
		[numberKeyPad removeButtonFromKeyboard];
		numberKeyPad = nil;
	}

}
- (void) textFieldDidBeginEditing:(UITextField *)textField
{

    if (textField.tag==12)
    {
        Money.contentOffset=CGPointMake(0, 80)
        ;
    }
    if (textField.tag==13)
    {
        Money.contentOffset=CGPointMake(0, 170)
        ;
    }

    
		if (!numberKeyPad) {
			numberKeyPad = [NumberKeypadDecimalPoint keypadForTextField:textField];
		}else {
	
			numberKeyPad.currentTextField = textField;
		}
//	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
