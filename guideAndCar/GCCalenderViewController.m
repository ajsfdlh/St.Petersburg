//
//  GCCalenderViewController.m
//  St.Petersburg
//
//  Created by beginner on 14-11-5.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "GCCalenderViewController.h"
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
#define Gary40 [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1]
#define Gary55 [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1]
#define Gary96 [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]
#define Gary90 [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1]




@interface GCCalenderViewController ()
{
    RTLabel *price;
    UIButton *YDButton;
    NSString *CM;
    NSString *UM;
    NSMutableData *datas;
    NSMutableArray *dayArr;
    NSMutableArray *monthArr;
    NSMutableArray *yearArr;
    NSMutableArray *dataArr;
    NSMutableArray *selectArr;
    NSString *dateStr;
    BOOL Flag;

}
@end

@implementation GCCalenderViewController

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
    hideTabbar
}
backButton

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self GetData];
    [self addScrollView];
    [self addCalenderView];
    [self addNuderView];
}

- (void)GetData
{
    dayArr = [[NSMutableArray alloc]init];
    yearArr = [[NSMutableArray alloc]init];
    monthArr = [[NSMutableArray alloc]init];
    selectArr = [[NSMutableArray alloc]init];
    NSURL *url = [[NSURL alloc]initWithString:@"http://t.russia-online.cn/ListServiceg.asmx/getGuideOrderdatelist"];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSString *argStr = [NSString stringWithFormat:@"ID=%@",_ID];
    NSData *data = [argStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [NSURLConnection connectionWithRequest:request delegate:self];
    Flag = NO;
    CM = [[NSString alloc]init];
    UM = [[NSString alloc]init];
    dateStr = [[NSString alloc]init];
    dataArr = [[NSMutableArray alloc]init];

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
    if ([self.guideType integerValue] == 1)
    {
        dataArr = (NSMutableArray *)[resule componentsSeparatedByString:@","];
    }
    NSLog(@"dataArr = %@",dataArr);
    NSLog(@"%@",resule);
    [self.calenderV GetData];
    
}


#pragma - mark 添加日历
- (void)addCalenderView
{
    self.calenderV= [[calenderView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - 64)];
    //    NSLog(@"%@",NSStringFromCGRect(self.aaC.frame));
    [self.calenderV setBackgroundColor:[UIColor clearColor]];
    self.calenderV.calendarDate = [NSDate date];
    self.calenderV.GCCVC = self;
    [self.ScrollV addSubview:self.calenderV];
}

#pragma - mark 添加scroll
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
    
    UILabel *BLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    BLabel.backgroundColor = OutCol;
    BLabel.layer.borderWidth = 1.0f;
    BLabel.layer.borderColor = BlackC.CGColor;
    [self.underView addSubview:BLabel];
    
    UILabel *BText = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 110, 15)];
    BText.text = @"不可预订";
    BText.textColor = BlackC;
    BText.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [self.underView addSubview:BText];
    
    UILabel *OLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 15, 15)];
    OLabel.backgroundColor = BColor;
    OLabel.layer.borderWidth = 1.0f;
    OLabel.layer.borderColor = KColor.CGColor;
    [self.underView addSubview:OLabel];
    
    UILabel *OText = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 50, 15)];
    OText.text = @"可预订";
    OText.textColor = BColor;
    OText.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [self.underView addSubview:OText];
    
    UILabel *RLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 10, 15, 15)];
    RLabel.backgroundColor = RColor;
    RLabel.layer.borderWidth = 1.0f;
    RLabel.layer.borderColor = KColor.CGColor;
    [self.underView addSubview:RLabel];
    
    UILabel *RText = [[UILabel alloc]initWithFrame:CGRectMake(200, 10, 70, 15)];
    RText.text = @"选中日期";
    RText.textColor = RColor;
    RText.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.0f];
    [self.underView addSubview:RText];
    
    UIImageView *attentionIV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"预订须知.png"]];
    attentionIV.frame = CGRectMake(10, 35, 20, 20);
    [self.underView addSubview:attentionIV];
    
    UILabel *attentionText = [[UILabel alloc]initWithFrame:CGRectMake(35, 35, 40, 20)];
    attentionText.text = @"注意";
    attentionText.textColor = [UIColor blackColor];
    attentionText.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
    [self.underView addSubview:attentionText];
    
    RTLabel * SLabel =[[RTLabel alloc]initWithFrame:CGRectMake(10, 63, 300, 55)];
    SLabel.text=@"每个定最多可预订8天，如果预定不相连的多个日期，间隔不能超过3天";
    SLabel.font = [UIFont systemFontOfSize:12];
    [self.underView addSubview:SLabel];
        
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 64 - 50, self.view.frame.size.width, 50)];
    view.backgroundColor = Gary40;
    [self.view addSubview:view];
    
    YDButton= [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 12, 70, 26)];
    [YDButton setTitle:@"预订" forState:UIControlStateNormal];
    YDButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [YDButton addTarget:self action:@selector(clickOnReservation) forControlEvents:UIControlEventTouchUpInside];
    YDButton.backgroundColor = Gary55;
    [view addSubview:YDButton];
    YDButton.layer.cornerRadius = 5;
    YDButton.clipsToBounds = YES;
    
    price=[[RTLabel alloc]initWithFrame:CGRectMake(10, 15, 150, 25)];
    price.font = [UIFont systemFontOfSize:13.5];
    [view addSubview:price];
    
}


- (void)clickOnReservation
{
    self.CGRV.dollar = UM;
    self.CGRV.RMB = CM;
    self.CGRV.CGArr = selectArr;
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)tappedDate:(UIButton *)sender
{
    if ([self.guideType integerValue] == 1)
    {
        if (Flag == NO)
        {
            if (self.CGRV.CGArr != nil)
            {
                selectArr = (NSMutableArray *)self.CGRV.CGArr;
                price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%d</font><font color=white>（$%d)</font>",[self.CGRV.RMB integerValue] * selectArr.count,[self.CGRV.dollar integerValue] * selectArr.count];
                CM = [NSString stringWithFormat: @"%d",[self.CGRV.RMB integerValue] * selectArr.count];
                UM = [NSString stringWithFormat: @"%d",[self.CGRV.dollar integerValue] * selectArr.count];
                YDButton.backgroundColor = BlueCo;
            }
//            dataArr = (NSMutableArray*)@[@"2014-12-02",@"2014-12-03",@"2014-12-04",@"2014-12-05",@"2014-12-06",@"2014-12-07",@"2014-12-08",@"2014-12-09",@"2014-12-10",@"2014-12-11",@"2014-12-12",@"2014-12-13"];
            [self changeBtnDateWithArray:dataArr];
            Flag = YES;
        }
        if (sender.tag == 0)
        {
            for (NSInteger i = 0; i < yearArr.count; i ++)
            {
                if ([yearArr[i] integerValue] == self.calenderV.year &&
                    [monthArr[1] integerValue] == self.calenderV.month)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:[dayArr[i] integerValue]];
                    button.userInteractionEnabled = YES;
                    button.backgroundColor = BColor;
                }
            }
            
            if (selectArr.count != 0)
            {
                for (NSInteger i = 0; i < selectArr.count; i ++)
                {
                    NSDate *date = [self dateWithString:selectArr[i]];
                    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
                    NSDateComponents *componnents = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
                    if (self.calenderV.year == componnents.year && self.calenderV.month == componnents.month)
                    {
                        UIButton *button = (UIButton *)[self.calenderV viewWithTag:componnents.day];
                        button.userInteractionEnabled = YES;
                        button.backgroundColor = RColor;
                    }
                }
            }
        }
        else
        {
            dateStr = [self dateStrWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:sender.tag];
            if (selectArr.count == 0)
            {
                [selectArr addObject:dateStr];
                UIButton *button = (UIButton *)[self.calenderV viewWithTag:sender.tag];
                button.userInteractionEnabled = YES;
                button.backgroundColor = RColor;
                YDButton.backgroundColor = BlueCo;
            }
            else
            {
                if ([selectArr containsObject:dateStr] == YES)
                {
                    [selectArr removeObject:dateStr];
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:sender.tag];
                    button.userInteractionEnabled = YES;
                    button.backgroundColor = BColor;
                    if (selectArr.count == 0)
                    {
                        YDButton.backgroundColor = Gary55;
                    }
                }
                else
                {
                    if (selectArr.count < 8)
                    {
                        for (NSInteger i = 0; i < selectArr.count; i ++)
                        {
                            NSCalendar *userCalendar = [NSCalendar currentCalendar];
                            unsigned int unitFlags = NSDayCalendarUnit;
                            dateStr = [self dateStrWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:sender.tag];
                            NSDateComponents *components = [userCalendar components:unitFlags fromDate:[self dateWithString:selectArr[i]] toDate:[self dateWithString:dateStr]  options:0];
                            NSInteger days = [components day];
//                            NSLog(@"component = %@",components);
                            if (days >= -3 && days <= 3)
                            {
//                                NSLog(@"day = %d",days);
                                i = selectArr.count;
                                [selectArr addObject:dateStr];
                                UIButton *button = (UIButton *)[self.calenderV viewWithTag:sender.tag];
                                button.userInteractionEnabled = YES;
                                button.backgroundColor = RColor;
                            }
                            else if(i == selectArr.count - 1)
                            {
                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"相隔不能超过3天哦！" delegate:self cancelButtonTitle:@"哦，知道了" otherButtonTitles: nil];
                                [alert show];
                            }
                        }
                    }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"抱歉，最多只能为您预定8天" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                        [alert show];
                    }
                }
            }
            
            
            if (selectArr.count == 0)
            {
                price.text = @"";
            }
            else
            {
                price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%d</font><font color=white>（$%d)</font>",[self.CGRV.RMB integerValue] * selectArr.count,[self.CGRV.dollar integerValue] * selectArr.count];
                CM = [NSString stringWithFormat: @"%d",[self.CGRV.RMB integerValue] * selectArr.count];
                UM = [NSString stringWithFormat: @"%d",[self.CGRV.dollar integerValue] * selectArr.count];
            }
        }
    }
}


#pragma - mark 字符串转化成date
- (NSDate *)dateWithString:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-M-d"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    return inputDate;
}


#pragma -mark 将年月日变成某个特定格式的字符串
- (NSString *)dateStrWithYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day
{
    NSString *dStr;
    if (day < 10)
    {
        dStr = [NSString stringWithFormat:@"0%d",day];
        
    }
    else
    {
        dStr = [NSString stringWithFormat:@"%d",day];
        
    }
    
    NSString *MStr;
    if (month < 10)
    {
        MStr = [NSString stringWithFormat:@"0%d",month];
        
    }
    else
    {
        MStr = [NSString stringWithFormat:@"%d",month];
        
    }
    
    return [NSString stringWithFormat:@"%d-%@-%@",year,MStr,dStr];
}



#pragma -mark 将一个date拆分成年月日数组
- (void)changeBtnDateWithArray:(NSArray *)arr
{
    for (NSInteger i = 0; i < [arr count]; i ++)
    {
        if (![arr[i] isEqualToString:@""])
        {
            [yearArr addObject:[arr[i] substringWithRange:NSMakeRange(0, 4)]];
            
            NSString *str = [arr[i] substringWithRange:NSMakeRange(5, 2)];
            if ([str hasPrefix:@"0"])
            {
                str = [str substringWithRange:NSMakeRange(1, 1)];
            }
            [monthArr addObject:str];
            
            NSString *st = [arr[i] substringWithRange:NSMakeRange(8, 2)];
            if ([st hasPrefix:@"0"])
            {
                st = [st substringWithRange:NSMakeRange(1, 1)];
            }
            [dayArr addObject:st];
        }
    }
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
