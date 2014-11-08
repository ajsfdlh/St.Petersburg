//
//  WeatherViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-24.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "WeatherViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
#import "QYHMeThod.h"
@interface WeatherViewController ()

@end

@implementation WeatherViewController

backButton


-(void)viewWillAppear:(BOOL)animated
{

    hideTabbar
    [self.navigationItem setNewTitle:@"圣彼得堡天气"];

    [self getWeather];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];

    weatherDic=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weather" ofType:@"plist"]];

}
-(void)netChange:(NSNotification*)sender
{
    Reachability*reach=[sender object];
    if ([reach currentReachabilityStatus]==NotReachable)
    {
        [self.navigationItem setNewTitle:@"(未连接)圣彼得堡天气"];
        
    }
    else
    {
        [self.navigationItem setNewTitle:@"圣彼得堡天气"];
        
        
        
        
    }
}

-(void)refresh
{


    [self getWeather];
  
   
}
-(void)getWeather
{


    [QYHMeThod YahooWeatherRequest:2123260 andU:@"c" andDeleget:self];
    //  rotateIV=[QYHMeThod rotate360DegreeWithImageView:rotateIV];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
     animation.delegate = self;
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI , 0, 0, 1.0)];
    animation.duration = 1;
    animation.cumulative = YES;
    animation.repeatCount = INT_MAX;
    [rotateIV.layer addAnimation:animation forKey:@"animation"];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    UIButton *backbutton2 = [[UIButton alloc]init] ;
    float height=19;
    backbutton2.frame=CGRectMake(0, (44-height)/2, height, height);
    [backbutton2 addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    rotateIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, height, height)];
    rotateIV.image = [UIImage imageNamed:@"weatherRefresh.png"];//weatherRefresh.png

    [backbutton2 addSubview:rotateIV];
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:backbutton2] ;
    self.navigationItem.rightBarButtonItem =backItem2;


	// Do any additional setup after loading the view.
}
//NoNetMethod
-(void)creatDisplayPanel:(NSArray*)documentArr andDocumentArr2:(NSArray*)documentArr2
{
 
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight-64)];
    [self.view addSubview:view];
    
    NSArray*forecastArray=[[documentArr objectAtIndex:0] elementsForName:@"yweather:forecast"];
    
    NSArray*todayArray=[[documentArr objectAtIndex:0] elementsForName:@"yweather:condition"];
     NSArray*windArray=[[documentArr2 objectAtIndex:0] elementsForName:@"yweather:wind"];
      NSArray*atmosphereArray=[[documentArr2 objectAtIndex:0] elementsForName:@"yweather:atmosphere"];
    
    NSString*todayTemp=[[[todayArray objectAtIndex:0] attributeForName:@"temp"] stringValue];
    
    NSString*todayHumidity=[[[atmosphereArray objectAtIndex:0] attributeForName:@"humidity"] stringValue];
    
    NSString*s=[[[windArray objectAtIndex:0] attributeForName:@"direction"] stringValue];
     float todayDirection=[s floatValue];
   // NSString*todayWeather=[weatherDic valueForKey:[[[todayArray objectAtIndex:0] attributeForName:@"code"] stringValue]];

    
    
    
   
    
    
    for (int i=0; i<5; i++)
    {
        
        
        NSTimeInterval secondsPerDay = -4 * 60 * 60+(60*60*24)*i;
        
        NSDate*date=[NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit |
        NSMonthCalendarUnit |
        NSDayCalendarUnit |
        NSWeekdayCalendarUnit |
        NSHourCalendarUnit |
        NSMinuteCalendarUnit |
        NSSecondCalendarUnit;
        
        comps = [calendar components:unitFlags fromDate:date];
        int week = [comps weekday];
        int year=[comps year];
        int month = [comps month];
        int day = [comps day];
        
        NSString*dateStr;
        if (month<10)
        {
            dateStr=[NSString stringWithFormat:@"%d-0%d-%d",year,month,day];
        }
        else
        {
            dateStr=[NSString stringWithFormat:@"%d-%d-%d",year,month,day];
        }
        
        NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys:@"星期天",@"1",@"星期一",@"2",@"星期二",@"3",@"星期三",@"4",@"星期四",@"5",@"星期五",@"6",@"星期六",@"7", nil];
          NSString*weekStr=[dic valueForKey:[NSString stringWithFormat:@"%d",week]];
        if (i==0)
        {
            UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 115)];
            if (DeviceHeight==568)
            {
                imageView.frame=CGRectMake(0, 0, 320, 145);
                
                
            }
            [view addSubview:imageView];
            
            UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height-2, 320, 2)];
            line.backgroundColor = [UIColor colorWithRed:1 green:86.0/255 blue:125.0/255 alpha:1];
            [imageView addSubview:line];
            
            RTLabel*lable=[[RTLabel alloc]initWithFrame:CGRectMake(30, 35, 100, 60)];
            [imageView addSubview:lable];
            NSDateFormatter *dayFormatter = [NSDateFormatter new];
            [dayFormatter setAMSymbol:@"AM"];
            [dayFormatter setPMSymbol:@"PM"];
            dayFormatter.dateFormat = @"hh:mm aaa";
            NSString *title1 = [dayFormatter stringFromDate:date];
            lable.text=[NSString stringWithFormat:@"<font  size=15 color='#7ab6e0'>今天 %@</font><br><font  size=15 color='#f14491'>%@</font>",weekStr,title1];
            NSLog(@"text=%@",title1);
            if (DeviceHeight==568)
            {
                lable.frame = CGRectMake(30, 50, 100, 60);
            }
            NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://l.yimg.com/a/i/us/we/52/%@.gif",[[[todayArray objectAtIndex:0] attributeForName:@"code"] stringValue]]];
            NSData*data=[NSData dataWithContentsOfURL:url];
            
            UIImageView*weatherCondition=[[UIImageView alloc]initWithFrame:CGRectMake((320.0-40.0)/2, (imageView.frame.size.height-40)/2, 40, 40)];
            weatherCondition.image=[UIImage imageWithData:data];
            [imageView addSubview:weatherCondition];

            
            RTLabel*weatherCondition2=[[RTLabel alloc]initWithFrame:CGRectMake(225, 0, 320, 0)];
            weatherCondition2.textColor=[UIColor redColor];

            NSString*wind;
            
            if (todayDirection==0)
            {
                wind=@"北风";
            }
            if (todayDirection==90)
            {
                wind=@"东风";
            }

            if (todayDirection==180)
            {
                wind=@"南风";
            }

            if (todayDirection==270)
            {
                wind=@"西风";
            }

            
            if (0<todayDirection&&todayDirection<90)
            {
                wind=@"东北风";
            }
            if (90<todayDirection&&todayDirection<180)
            {
                wind=@"东南风";
            }
            if (180<todayDirection&&todayDirection<270)
            {
                wind=@"西南风";
            }

            if (270<todayDirection&&todayDirection<360)
            {
                wind=@"西北风";
            }


            weatherCondition2.text=[NSString stringWithFormat:@"<font size=30 color='#f14491' >%@</font><font  size=27 color='#7ab6e0' >℃</font><br><font  size=13 color='#f14491'>相对湿度:%@%%</font><br><font  size=13 color='#7ab6e0'>%@</font>",todayTemp,todayHumidity,wind];
            weatherCondition2.textAlignment=NSTextAlignmentCenter;
            CGSize size2=[weatherCondition2 optimumSize];
            weatherCondition2.frame=CGRectMake(200, (imageView.frame.size.height-size2.height)/2, 100, size2.height);
            
            [imageView addSubview:weatherCondition2];
            
        }
        else
        {
            float a=0;
            if (DeviceHeight==480.0)
            {
                a=115;
            }
            else
            {
                a=145;
            }
            
            UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, a+( DeviceHeight-64-a)/4.0*(i-1), 320,( DeviceHeight-64-a)/4.0)];
            [view addSubview:imageView];
        
            UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height-2, 320, 2)];
            [imageView addSubview:line];
            
            RTLabel*lable=[[RTLabel alloc]init];
            lable.frame=CGRectMake(30, (imageView.frame.size.height-50)/2, 100, 50);
            [imageView addSubview:lable];
            
            NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://l.yimg.com/a/i/us/we/52/%@.gif",[[[forecastArray objectAtIndex:i-1]attributeForName:@"code"] stringValue]]];
            NSData*data=[NSData dataWithContentsOfURL:url];
            
            UIImageView*weatherCondition=[[UIImageView alloc]initWithFrame:CGRectMake((320.0-40.0)/2, (imageView.frame.size.height-40)/2, 40, 40)];
            weatherCondition.image=[UIImage imageWithData:data];
            [imageView addSubview:weatherCondition];

        
            RTLabel*weatherCondition2=[[RTLabel alloc]init];
           // NSLog(@"%@",forecastArray);
            weatherCondition2.textAlignment=NSTextAlignmentCenter;
            weatherCondition2.frame=CGRectMake(200, (imageView.frame.size.height-30)/2, 100, 30);
            
            [imageView addSubview:weatherCondition2];

            switch (i) {
                case 1:{
                    line.backgroundColor = [UIColor colorWithRed:74.0/255 green:184.0/255 blue:183.0/255 alpha:1];
                     lable.text=[NSString stringWithFormat:@"<font  size=15 color='#7ab6e0'>%@</font><br><font  size=15 color='#4ab8b7'>%@</font>",dateStr,weekStr];
                    weatherCondition2.text=[NSString stringWithFormat:@"<font size=20 color='#4ab8b7'>%@-%@</font><font size=20 color='#7ab6e0'>℃</font>",[[[forecastArray objectAtIndex:i]attributeForName:@"low"] stringValue],[[[forecastArray objectAtIndex:i]attributeForName:@"high"] stringValue]];
                }
                    
                    break;
                case 2:{
                    line.backgroundColor = [UIColor colorWithRed:1 green:107.0/255 blue:92.0/255 alpha:1];
                    lable.text=[NSString stringWithFormat:@"<font  size=15 color='#7ab6e0'>%@</font><br><font  size=15 color='#ff6b5c'>%@</font>",dateStr,weekStr];
                    weatherCondition2.text=[NSString stringWithFormat:@"<font size=20 color='#ff6b5c'>%@-%@</font><font size=20 color='#7ab6e0'>℃</font>",[[[forecastArray objectAtIndex:i]attributeForName:@"low"] stringValue],[[[forecastArray objectAtIndex:i]attributeForName:@"high"] stringValue]];
                }
                    
                    break;
                case 3:{
                    line.backgroundColor = [UIColor colorWithRed:131.0/255 green:96.0/255 blue:196.0/255 alpha:1];
                    lable.text=[NSString stringWithFormat:@"<font  size=15 color='#7ab6e0'>%@</font><br><font  size=15 color='#8360c4'>%@</font>",dateStr,weekStr];
                    weatherCondition2.text=[NSString stringWithFormat:@"<font size=20 color='#8360c4'>%@-%@</font><font size=20 color='#7ab6e0'>℃</font>",[[[forecastArray objectAtIndex:i]attributeForName:@"low"] stringValue],[[[forecastArray objectAtIndex:i]attributeForName:@"high"] stringValue]];
                }
                    
                    break;
                case 4:{
                    line.backgroundColor = [UIColor colorWithRed:231.0/255 green:179.0/255 blue:0 alpha:1];
                    lable.text=[NSString stringWithFormat:@"<font  size=15 color='#7ab6e0'>%@</font><br><font  size=15 color='#e7b300'>%@</font>",dateStr,weekStr];
                    weatherCondition2.text=[NSString stringWithFormat:@"<font size=20 color='#e7b300'>%@-%@</font><font size=20 color='#7ab6e0'>℃</font>",[[[forecastArray objectAtIndex:i]attributeForName:@"low"] stringValue],[[[forecastArray objectAtIndex:i]attributeForName:@"high"] stringValue]];
                }
                    
                    break;
                    
                default:
                    break;
            }
        
        }
    }


    noNetButton=[UIButton buttonWithType:UIButtonTypeCustom];noNetButton.frame=CGRectMake(0, 0, 320, 40);[noNetButton setImage:[UIImage imageNamed:@"noNet.gif"] forState:UIControlStateNormal];noNetButton.hidden=YES;
    //[noNetButton addTarget:self action:@selector(noNet) forControlEvents:UIControlEventTouchUpInside];[view addSubview:noNetButton];
    Reachability*reach =[Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([reach currentReachabilityStatus]==NotReachable)
    {
        [self.navigationItem setNewTitle:@"(未连接)圣彼得堡天气"];
        
    }
    else
    {
        [self.navigationItem setNewTitle:@"圣彼得堡天气"];
        
        
        
        
    }

}
postRequestAgency(datas)
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

 

    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [rotateIV.layer removeAllAnimations];
        

     GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithData:datas options:0 error:nil];

 
    //NSLog(@"stringReply=========%@",stringReply);
    NSArray *documentArr = [document nodesForXPath:@"//rss//channel//item" error:nil];
    NSArray*documentToday= [document nodesForXPath:@"//rss//channel" error:nil];

  
    if (view!=nil)
    {
        [view removeFromSuperview];
    }
    [self creatDisplayPanel:documentArr andDocumentArr2:documentToday];
    


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
