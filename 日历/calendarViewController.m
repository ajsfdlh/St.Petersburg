//
//  calendarViewController.m
//  rili
//
//  Created by beginner on 14-10-13.
//  Copyright (c) 2014年 beginner. All rights reserved.
//

#import "calendarViewController.h"
#import "GDataXMLNode.h"
#import "JSON.h"
#define BColor [UIColor colorWithRed:0.46 green:0.76 blue:0.98 alpha:1]
#define OColor [UIColor colorWithRed:0.95 green:0.68 blue:0.24 alpha:1]
#define RColor [UIColor colorWithRed:0.89 green:0.35 blue:0.44 alpha:1]
#define GColor [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]
#define BlackC [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1]
#define KColor [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1]
#define GrayCo [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]
#define BlueCo [UIColor colorWithRed:0.10 green:0.34 blue:0.66 alpha:1]
#define OutCol [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]



@interface calendarViewController ()
{
    NSMutableData *datas;
    NSString *didSetStr;
    NSString *didreservationStr;
    NSString *setStr;
    NSArray *didSetArr;
    NSArray *didreservationArr;
    NSMutableArray *setArr;
    NSInteger Year;
    NSInteger Month;
    NSInteger Day;
    NSInteger sixMonrhs;
    BOOL flag;
    BOOL deleteFlag;
}


@end

@implementation calendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setNewTitle:@"设置可服务日期"];
    hideTabbar
}

backButton

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    setArr = [[NSMutableArray alloc]init];
    setStr = [[NSString alloc]init];
    
    [self GetData];
    [self addScrollView];
    [self addCalenderView];
    [self addNuderView];
}

- (void)GetData
{
    flag = NO;
    deleteFlag = NO;
    NSURL *url = [[NSURL alloc]initWithString:@"http://t.russia-online.cn/ListServiceg.asmx/AddOrderdate"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSString *str = [NSString stringWithFormat:@"guideid=%d&datelist=&typeid=0",[[[NSUserDefaults standardUserDefaults] objectForKey:GUIDE_ID] integerValue]];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma -mark 接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    datas = [[NSMutableData alloc]init];
    [datas appendData:data];
}


#pragma -mark 数据接收完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    NSLog(@"%@",datas);
//    NSString *str = [[NSString alloc]initWithData:datas encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str);
    NSError *error = nil;
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:datas options:0 error:&error];
    GDataXMLElement *element = [document rootElement];
    NSString *resule = [element stringValue];
//    NSLog(@"%@",resule);
    if ([resule integerValue] == 1)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜，您已经设置的成功！！" delegate:self cancelButtonTitle:@"好的，谢谢" otherButtonTitles:nil, nil];
        [alert show];
        resule = [NSString stringWithFormat:@"%@|",setStr];
        [self GetData];
    }
    if ([resule integerValue] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"抱歉，您未曾设置日期，您再想想看好吗？？" delegate:self cancelButtonTitle:@"好的，谢谢" otherButtonTitles:nil, nil];
        [alert show];
        resule = [NSString stringWithFormat:@"%@|",setStr];
        [self GetData];
    }
    NSArray * array = [resule componentsSeparatedByString:@"|"];
//    NSLog(@"%@",array);
    
    
        didSetStr = [NSString stringWithString:array[0]];
        didreservationStr = [NSString stringWithString:array[1]];
        didSetArr = [NSArray arrayWithArray:[didSetStr componentsSeparatedByString:@","]];
        didreservationArr = [NSArray arrayWithArray:[didreservationStr componentsSeparatedByString:@","]];

    //    for (NSInteger i = 0; i < 32; i ++)
    //    {
    //        [FlagArr addObject:@"0"];
    //    }
        
    //    NSLog(@"%@",didSetArr);
        [self.aaC GetData];
    
}

#pragma - mark 添加日历
- (void)addCalenderView
{
    self.aaC= [[calenderView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - 64)];
    //    NSLog(@"%@",NSStringFromCGRect(self.aaC.frame));
    [self.aaC setBackgroundColor:[UIColor clearColor]];
    self.aaC.calendarDate = [NSDate date];
    [self.ScrollV addSubview:self.aaC];

}

- (void)addScrollView
{
    self.ScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview: self.ScrollV];
}

#pragma  - mark 添加底视图
- (void)addNuderView
{
    self.underView = [[UIView alloc]initWithFrame:CGRectZero];
    self.underView.backgroundColor = GColor;
    self.underView.layer.borderWidth = 0.5;
    self.underView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.ScrollV addSubview:self.underView];
    self.aaC.CVC = self;
    
    UILabel *BLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    BLabel.backgroundColor = BColor;
    BLabel.layer.borderWidth = 1.0f;
    BLabel.layer.borderColor = KColor.CGColor;
    [self.underView addSubview:BLabel];
    
    UILabel *BText = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 110, 15)];
    BText.text = @"已设置可服务日期";
    BText.textColor = BColor;
    BText.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [self.underView addSubview:BText];
    
    UILabel *OLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 10, 15, 15)];
    OLabel.backgroundColor = OColor;
    OLabel.layer.borderWidth = 1.0f;
    OLabel.layer.borderColor = KColor.CGColor;
    [self.underView addSubview:OLabel];
    
    UILabel *OText = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, 50, 15)];
    OText.text = @"已有订单";
    OText.textColor = OColor;
    OText.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [self.underView addSubview:OText];
    
    UILabel *RLabel = [[UILabel alloc]initWithFrame:CGRectMake(220, 10, 15, 15)];
    RLabel.backgroundColor = RColor;
    RLabel.layer.borderWidth = 1.0f;
    RLabel.layer.borderColor = KColor.CGColor;
    [self.underView addSubview:RLabel];
    
    UILabel *RText = [[UILabel alloc]initWithFrame:CGRectMake(240, 10, 70, 15)];
    RText.text = @"选中日期";
    RText.textColor = RColor;
    RText.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [self.underView addSubview:RText];
    
    UILabel *OutL = [[UILabel alloc]initWithFrame:CGRectMake(140, 35, 15, 15)];
    OutL.backgroundColor = OutCol;
    OutL.layer.borderWidth = 1.0f;
    OutL.layer.borderColor = BlackC.CGColor;
    [self.underView addSubview:OutL];
    
    UILabel *OutT = [[UILabel alloc]initWithFrame:CGRectMake(160, 35, 100, 15)];
    OutT.text = @"不可设置的日期";
    OutT.textColor = BlackC;
    OutT.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [self.underView addSubview:OutT];

    UIImageView *attentionIV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"预订须知.png"]];
    attentionIV.frame = CGRectMake(10, 35, 20, 20);
    [self.underView addSubview:attentionIV];
    
    UILabel *attentionText = [[UILabel alloc]initWithFrame:CGRectMake(35, 35, 40, 20)];
    attentionText.text = @"注意";
    attentionText.textColor = [UIColor blackColor];
    attentionText.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    [self.underView addSubview:attentionText];

    RTLabel * SLabel =[[RTLabel alloc]initWithFrame:CGRectMake(10, 63, 300, 55)];
    SLabel.text=@"<b>请<font color=red>慎重设置</font>您可提供服务的日期，并根据自身日程表，及时确认更新可服务日期表！如设定为可服务日期，则<font color=red>无权更改或拒绝</font>客户或游客订单</b>";
    SLabel.font = [UIFont systemFontOfSize:13];
    [self.underView addSubview:SLabel];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 64 - 60, self.view.frame.size.width, 60)];
    view.backgroundColor = BlackC;
    [self.view addSubview:view];
    
    UIButton *TJButton = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, 10, 80, 40)];
    [TJButton setTitle:@"提交" forState:UIControlStateNormal];
    [TJButton addTarget:self action:@selector(clickOnSubmit) forControlEvents:UIControlEventTouchUpInside];
    TJButton.backgroundColor = BlueCo;
    [view addSubview:TJButton];
    TJButton.layer.cornerRadius = 5;
    TJButton.clipsToBounds = YES;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex == 0)
    {
        
    }
    if (buttonIndex == 1)
    {
        setStr = [setArr componentsJoinedByString:@","];
        NSURL *url = [[NSURL alloc]initWithString:@"http://t.russia-online.cn/ListServiceg.asmx/AddOrderdate"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];
        NSString *str = [NSString stringWithFormat:@"guideid=%d&datelist=%@&typeid=1",[[[NSUserDefaults standardUserDefaults] objectForKey:GUIDE_ID] integerValue],setStr];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }
}
- (void)clickOnSubmit
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"由于设置之后不能修改，您真的考虑好了吗？？" delegate:self cancelButtonTitle:@"没有" otherButtonTitles:@"考虑好了", nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tappedDate:(UIButton *)sender
{
//    NSLog(@"%d",sender.tag);
//    NSLog(@"%@",didSetArr);
//    NSLog(@"%d",self.aaC.month);
//    NSLog(@"%d",self.aaC.year);
    
    if (flag == NO)
    {
        Year = self.aaC.year;
        Month = self.aaC.month;
        Day = self.aaC.day;
        flag = YES;
    }
    
#pragma -mark 剩下的月份够半年的
    if (6 + Month <= 12)
    {
        sixMonrhs = 6 + Month;
        if (Year == self.aaC.year && self.aaC.month == Month)
        {
            if (sender.tag > Day)
            {
                [self GetSetArr:sender];
            }
        }
        else if (Year == self.aaC.year && self.aaC.month <= sixMonrhs - 1)
        {
            [self GetSetArr:sender];
        }
        else if (Year ==self.aaC.year && self.aaC.month > sixMonrhs - 1)
        {
            if (sender.tag != 0)
            {
                [self addBeyondAlert];
            }
        }
        else if (Year  < self.aaC.year)
        {
            if (sender.tag != 0)
            {
                [self addBeyondAlert];
            }
        }
    }
    
#pragma -mark 剩下的月份不够半年的
    if (6 + Month > 12)
    {
        sixMonrhs = 6 + Month - 12;
        
        if (Year == self.aaC.year && self.aaC.month == Month)
        {
            if (sender.tag > Day)
            {
                [self GetSetArr:sender];
            }
        }
        else if (Year == self.aaC.year && Month <= 12 && Month <= self.aaC.month)
        {
            [self GetSetArr:sender];
        }
                
        if (Year + 1 ==self.aaC.year && self.aaC.month <= sixMonrhs - 1)
        {
            [self GetSetArr:sender];
        }
        else if (Year < self.aaC.year && self.aaC.month > sixMonrhs - 1)
        {
            if (sender.tag != 0)
            {
                [self addBeyondAlert];
            }
        }
        else if (Year + 1 < self.aaC.year)
        {
            if (sender.tag != 0)
            {
                [self addBeyondAlert];
            }
        }
    }
    [self addDateWithArray:setArr andColor:RColor];
    [self addDateWithArray:didSetArr andColor:BColor];
    [self addDateWithArray:didreservationArr andColor:OColor];
    for (NSInteger j = 0; j < [didSetArr count]; j ++)
    {
        for (NSInteger i = 0; i <[setArr count]; i ++)
        {
            if ([setArr[i] isEqual:didSetArr[j]])
            {
                [setArr removeObject:setArr[i]];
            }
        }
    }
    for (NSInteger j = 0; j < [didreservationArr count]; j ++)
    {
        for (NSInteger i = 0; i <[setArr count]; i ++)
        {
            if ([setArr[i] isEqual:didreservationArr[j]])
            {
                [setArr removeObject:setArr[i]];
            }
        }
    }
//    NSLog(@"%@",setArr);

}

#pragma -mark 提前超过半年
- (void)addBeyondAlert
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您好，为了您的身体，我们只能帮你预定半年。" delegate:self cancelButtonTitle:@"好的，谢谢" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)GetSetArr:(UIButton *)sender
{
    NSString *str;
    if ([[NSString stringWithFormat:@"%d",sender.tag] length] == 1)
    {
        if (sender.tag != 0)
        {
            str = [NSString stringWithFormat:@"%d-%d-0%d",self.aaC.year,self.aaC.month,sender.tag];
        }
        if ([[NSString stringWithFormat:@"%d",self.aaC.month] length] == 1)
        {
            if (sender.tag != 0)
            {
                str = [NSString stringWithFormat:@"%d-0%d-0%d",self.aaC.year,self.aaC.month,sender.tag];
            }
        }
    }
    if ([[NSString stringWithFormat:@"%d",sender.tag] length] == 2)
    {
        str = [NSString stringWithFormat:@"%d-%d-%d",self.aaC.year,self.aaC.month,sender.tag];
        
        if ([[NSString stringWithFormat:@"%d",self.aaC.month] length] == 1)
        {
            if (sender.tag != 0)
            {
                str = [NSString stringWithFormat:@"%d-0%d-%d",self.aaC.year,self.aaC.month,sender.tag];
            }
        }

    }
    if (str != nil)
    {
        if ([setArr count] > 0)
        {
            for (NSInteger i = 0; i < [setArr count]; i ++)
            {
                if ([setArr[i] isEqual:str])
                {
                    [setArr removeObject:str];
                    sender.backgroundColor = GrayCo;
                    deleteFlag = YES;
                }
            }
        }
        else
        {
            [setArr addObject:str];
            deleteFlag = YES;
        }
        
        if (deleteFlag == NO)
        {
            [setArr addObject:str];
        }
        deleteFlag = NO;
    }

}


- (void)addDateWithArray:(NSArray *)arr andColor:(UIColor *)color
{
    for (NSInteger i = 0; i < [arr count]; i ++)
    {
        if (![arr[i] isEqualToString:@""])
        {
            if (self.aaC.year == [[arr[i] substringWithRange:NSMakeRange(0, 4)] integerValue])
            {
                NSString *str = [arr[i] substringWithRange:NSMakeRange(5, 2)];
                if ([str hasPrefix:@"0"])
                {
                    str = [str substringWithRange:NSMakeRange(1, 1)];
                }
                if ([str integerValue] == self.aaC.month)
                {
                    NSString *str = [arr[i] substringWithRange:NSMakeRange(8, 2)];
                    if ([str hasPrefix:@"0"])
                    {
                        str = [str substringWithRange:NSMakeRange(1, 1)];
                    }
                    UIButton *button = (UIButton *)[self.aaC viewWithTag:[str integerValue]];
                    button.backgroundColor = color;
                }
            }
        }
    }
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
