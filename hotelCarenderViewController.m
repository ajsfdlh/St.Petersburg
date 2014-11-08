//
//  hotelCarenderViewController.m
//  St.Petersburg
//
//  Created by beginner on 14-10-20.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "hotelCarenderViewController.h"
#import "SceneryReceverClass.h"
#import "RoomReseverClass.h"
#import "GDataXMLNode.h"
#import "JSON.h"


#define Gary40 [UIColor colorWithRed:0.40 green:0.40 blue:0.40 alpha:1]
#define BlueCo [UIColor colorWithRed:0.10 green:0.34 blue:0.66 alpha:1]
#define Gary55 [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1]
#define Gary96 [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]
#define Gary90 [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1]
#define CyanCo [UIColor colorWithRed:0.85 green:0.95 blue:1 alpha:1];
#define orange [UIColor colorWithRed:0.89 green:0.29 blue:0.16 alpha:1];


@interface hotelCarenderViewController ()
{
    NSMutableData *datas;
    NSArray *DataArr;
    UIButton *YDButton;
    NSInteger todate;
    NSInteger Year;
    NSInteger Month;
    NSInteger Day;
    NSInteger BtnY;
    NSInteger BtnM;
//    NSInteger self.BtnD;
    NSInteger endY;
    NSInteger endM;
//    NSInteger self.endD;
    NSInteger roomNum;
    NSInteger WeekD;
    NSInteger fi;
    NSMutableArray *dateArr;
    NSMutableArray *dayArr;
    NSMutableArray *monthArr;
    NSMutableArray *yearArr;
    NSMutableArray *numArr;
//    NSMutableArray *self.CIOArr;
    RTLabel *price;
    NSString *CM;
    NSString *UM;
    BOOL flag;
    BOOL firstF;
    NSArray *CPArr;
    NSArray *UPArr;
    NSArray *PCArr;
    NSInteger DF;
    NSMutableArray *date1Arr;
    NSMutableArray *date2Arr;
    BOOL lineF;
}
@end

@implementation hotelCarenderViewController



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
//    NSLog(@"pordType = %@",self.prodType);    
    hideTabbar
}

backButton



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self GetData];
    [self addCalenderView];
}

#pragma - mark 连接服务器
- (void)GetData
{
    flag = NO;
    firstF = NO;
    lineF = NO;
    self.hotelBool = YES;
    DF = -1;
    roomNum = 100;
    CM = [[NSString alloc]init];
    UM = [[NSString alloc]init];
    DataArr = [[NSMutableArray alloc]init];
    dateArr = [[NSMutableArray alloc]init];
    dayArr = [[NSMutableArray alloc]init];
    monthArr = [[NSMutableArray alloc]init];
    yearArr = [[NSMutableArray alloc]init];
    numArr = [[NSMutableArray alloc]init];
    self.CIOArr = [[NSMutableArray alloc]init];
    date1Arr = [[NSMutableArray alloc]init];
    date2Arr = [[NSMutableArray alloc]init];
    NSURL *url;
    if ([self.title isEqual:@"出发日期"])
    {
        url = [[NSURL alloc]initWithString:@"http://t.russia-online.cn/ListService.asmx/getLinePriceDetail"];
    }
    else if ([self.title isEqual:@"订票日期"])
    {
        url = [[NSURL alloc]initWithString:@"http://t.russia-online.cn/ListServicet.asmx/getTicketPriceDetail"];
    }
    else if ([self.title isEqual:@"游玩日期"])
    {
        url = [[NSURL alloc]initWithString:@"http://t.russia-online.cn/ListServicet.asmx/getViewPriceDetail"];
    }
    else if ([self.title isEqual:@"可入住日期"])
    {
        url = [[NSURL alloc]initWithString:@"http://t.russia-online.cn/ListServicet.asmx/getRoomPriceDetail"];
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSString *str = [NSString stringWithFormat:@"ID=%@",self.ID];
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
    if ([resule isEqualToString:@""])
    {
        self.prodType = 0;
    }
//    if ([self.prodType integerValue] == 3)
//    {
//        DataArr = [resule componentsSeparatedByString:@","];
//    }
    else if ([self.prodType integerValue] == 2 || [self.prodType integerValue] == 1 || [self.prodType integerValue] == 3)
    {
        NSData *data = [resule dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]JSONValue];
        DataArr = [dic objectForKey:@"ds"];
    }
//    NSLog(@"dataArr = %@",DataArr);
//    NSLog(@"self.dataDic = %@",self.dataDic);
    if ([self.title isEqual:@"游玩日期"])
    {
        CPArr = [[NSArray alloc]initWithArray:[self arrayWithstr:[self.dataDic valueForKey:@"ZPrice"]]];
        UPArr = [[NSArray alloc]initWithArray:[self arrayWithstr:[self.dataDic valueForKey:@"UPrice"]]];
        PCArr = [[NSArray alloc]initWithArray:[self arrayWithstr:[self.dataDic valueForKey:@"UDPrice"]]];
    }
    else
    {
        CPArr = [[NSArray alloc]initWithObjects:
                 [self.dataDic valueForKey:@"TRPrice"],
                 [self.dataDic valueForKey:@"ZPrice"],
                 [self.dataDic valueForKey:@"ZPrice"],
                 [self.dataDic valueForKey:@"ZPrice"],
                 [self.dataDic valueForKey:@"ZPrice"],
                 [self.dataDic valueForKey:@"FRPrice"],
                 [self.dataDic valueForKey:@"SRPrice"], nil];
        if ([self.title isEqual:@"出发日期"])
        {
            CPArr = [[NSArray alloc]initWithObjects:
                     [self.dataDic valueForKey:@"TRPrice"],
                     [self.dataDic valueForKey:@"RPrice"],
                     [self.dataDic valueForKey:@"RPrice"],
                     [self.dataDic valueForKey:@"RPrice"],
                     [self.dataDic valueForKey:@"RPrice"],
                     [self.dataDic valueForKey:@"FRPrice"],
                     [self.dataDic valueForKey:@"SRPrice"], nil];
        }
        UPArr = [[NSArray alloc]initWithObjects:
                 [self.dataDic valueForKey:@"TUPrice"],
                 [self.dataDic valueForKey:@"Price"],
                 [self.dataDic valueForKey:@"Price"],
                 [self.dataDic valueForKey:@"Price"],
                 [self.dataDic valueForKey:@"Price"],
                 [self.dataDic valueForKey:@"FUPrice"],
                 [self.dataDic valueForKey:@"SUPrice"], nil];
        PCArr = [[NSArray alloc]initWithObjects:
                 [self.dataDic valueForKey:@"TUDPrice"],
                 [self.dataDic valueForKey:@"UDPrice"],
                 [self.dataDic valueForKey:@"UDPrice"],
                 [self.dataDic valueForKey:@"UDPrice"],
                 [self.dataDic valueForKey:@"UDPrice"],
                 [self.dataDic valueForKey:@"FUDPrice"],
                 [self.dataDic valueForKey:@"SUDPrice"], nil];

    }
    
        if ([self.title isEqual:@"出发日期"] || [self.title isEqual:@"订票日期"])
    {
        if (self.checkDate != nil)
        {
//            NSLog(@"checkDate = %@",self.checkDate);
            NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
            [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
            [inputFormatter setDateFormat:@"yyyy年M月d日"];
            NSDate* inputDate = [inputFormatter dateFromString:self.checkDate];
            NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:inputDate];
//            NSLog(@"component = %@",components);
            BtnY = components.year;
            BtnM = components.month;
            self.BtnD = components.day;
            DF = self.BtnD;
        }
    }
    [self.calenderV GetData];
}

- (NSArray *)arrayWithstr:(NSString *)str
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 7; i ++)
    {
        [arr addObject:str];
    }
    return arr;
}

#pragma - mark 添加日历
- (void)addCalenderView
{
    self.calenderV= [[calenderView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - 64)];
    [self.calenderV setBackgroundColor:[UIColor clearColor]];
    self.calenderV.calendarDate = [NSDate date];
    self.calenderV.HCVC = self;
    self.ScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview: self.ScrollV];
    [self.ScrollV addSubview:self.calenderV];
    
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
    if (DF != -1)
    {
        if ([self.title isEqual:@"出发日期"])
        {
            self.lineRC.checkDate = [self dateStrWithYear:BtnY andMonth:BtnM andDay:self.BtnD];
            self.lineRC.ticketCount = roomNum;
            self.lineRC.dollar = UM;
            self.lineRC.RMB = CM;
            [self.navigationController popViewControllerAnimated:NO];
        }
        else if ([self.title isEqual:@"订票日期"])
        {
            self.entainRC.checkDate = [self dateStrWithYear:BtnY andMonth:BtnM andDay:self.BtnD];
            self.entainRC.ticketCount = roomNum;
            self.entainRC.dollar = UM;
            self.entainRC.RMB = CM;
            [self.navigationController popViewControllerAnimated:NO];
        }
        else if([self.title isEqual:@"游玩日期"])
        {
            SceneryReceverClass * rrc = [SceneryReceverClass new];
            rrc.ID = [self.dataDic objectForKey:@"ID"];
            rrc.title = @"景点门票预订";
            NSString *head = [self.dataDic valueForKey:@"ViewName"];
            rrc.roomTypeStr = head;
            rrc.russianStr = _HotelRUName;
            rrc.chineseStr  = _HotelCNName;
            rrc.payWay =[_dataDic valueForKey:@"OrderType"];
            rrc.showTime = _showTime;
            rrc.reseverKnowStr = [_dataDic objectForKey:@"OrderNote"];
            rrc.RMB = CM;
            rrc.dollar = UM;
            rrc.ticketCount = roomNum;
            rrc.checkDate = [self dateStrWithYear:BtnY andMonth:BtnM andDay:self.BtnD];
            [self.navigationController pushViewController:rrc animated:NO];
        }
        else if([self.title isEqual:@"可入住日期"])
        {
            NSString *ID = [self.dataDic objectForKey:@"ID"];
            
            NSString *Ftitle=@"";
            
            if ([[self.dataDic valueForKey:@"Ftitle"] length]>0)
            {
                Ftitle = [NSString stringWithFormat:@"-%@",[self.dataDic valueForKey:@"Ftitle"]];
            }
            RoomReseverClass * rrc = [RoomReseverClass new];
            rrc.ID=[NSString stringWithFormat:@"%@",ID];
            NSString *head = [NSString stringWithFormat:@"%@%@",[self.dataDic valueForKey:@"RoomName"],Ftitle];
            rrc.roomTypeStr = head;
            rrc.russianStr = self.HotelRUName;
            rrc.chineseStr  = self.HotelCNName;
            rrc.ProdType = [self.dataDic objectForKey:@"ProdType"];
            rrc.peopleMaxCountStr = [NSString stringWithFormat:@"%@人",[self.dataDic  objectForKey:@"MoneyType"]];
            rrc.RMB = CM;
            rrc.dollar = UM;
            rrc.roomFacilityStr = [self.dataDic valueForKey:@"Other"];
            rrc.checkDate = [self dateStrWithYear:BtnY andMonth:BtnM andDay:self.BtnD];
            if ([self.prodType integerValue] != 4)
            {
                if (self.BtnD == [self GetMonthDayWithYear:BtnY andMonth:BtnM])
                {
                    self.endD = 1;
                    if (BtnM == 12)
                    {
                        endM = 1;
                        endY = BtnY + 1;
                    }
                    else
                    {
                        endM = BtnM + 1;
                        endY = BtnY;
                    }
                }
                else
                {
                    self.endD = self.BtnD + 1;
                    endM = BtnM;
                    endY = BtnY;
                }
            }
            rrc.check_outDate = [self dateStrWithYear:endY andMonth:endM andDay:self.endD];
            rrc.roomNum = roomNum;
            rrc.hotel = self;
            [self.navigationController pushViewController:rrc animated:NO];
        }
    }
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
    
    return [NSString stringWithFormat:@"%d年%@月%@日",year,MStr,dStr];
}


#pragma - mark 字符串转化成date
- (NSDate *)dateWithYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day
{
    NSString* string = [NSString stringWithFormat:@"%d年%d月%d日",year,month,day];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy年M月d日"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    return inputDate;
}


- (NSArray *)arrWithArray:(NSArray *)arr
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:arr[0]];
    
    NSString *str = arr[1];
    if ([str hasPrefix:@"0"])
        {
            str = [str substringWithRange:NSMakeRange(1, 1)];
        }
        [array addObject:str];
        
    NSString *st = arr[2];
        if ([st hasPrefix:@"0"])
        {
            st = [st substringWithRange:NSMakeRange(1, 1)];
        }
        [array addObject:st];
    return array;
}


- (void)tappedDate:(UIButton *)sender
{
    if (flag == NO)
    {
        Year = self.calenderV.year;
        Month = self.calenderV.month;
        Day = self.calenderV.day;
        flag = YES;
    }
    
    if ([self.prodType integerValue] == 1 || [self.prodType integerValue] == 3)
    {
        if (firstF == NO)
        {
//            dateArr = (NSMutableArray *)@[@"2014-11-04",@"2014-11-25"];
            dateArr = (NSMutableArray *)[[DataArr[0] objectForKey:@"date0"] componentsSeparatedByString:@","];
            [self changeBtnDateWithArray:dateArr];
            if (![[DataArr[0] objectForKey:@"date1"] isEqualToString:@""])
            {
                NSArray * arr = [[DataArr[0] objectForKey:@"date1"]
                                 componentsSeparatedByString:@"|"];
                for (NSInteger i = 0; i < [arr  count]; i ++)
                {
                    [date1Arr addObject:[self arrWithArray:[[arr[i] componentsSeparatedByString:@","][0] componentsSeparatedByString:@"-"]]];
                    [numArr addObject:[arr[i] componentsSeparatedByString:@","][1]];
                }
            }
            if (![[DataArr[0] objectForKey:@"date2"] isEqualToString:@""])
            {
                NSArray * arr1 = [[DataArr[0] objectForKey:@"date2"]
                                  componentsSeparatedByString:@"|"];
                for (NSInteger i = 0; i < [arr1  count]; i ++)
                {
                    [date2Arr addObject:[self arrWithArray:[arr1[i] componentsSeparatedByString:@"-"]]];
                }
            }
            firstF = YES;
        }
        if (sender.tag == 0)
        {
            [self duringTheActivity:sender];
            for (NSInteger i = 0; i < [date2Arr count]; i ++)
            {
                if ([date2Arr[i][0] integerValue] == self.calenderV.year &&
                    [date2Arr[i][1] integerValue] == self.calenderV.month)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date2Arr[i][2] integerValue]];
                    button.backgroundColor = Gary90;
                    button.userInteractionEnabled = NO;
                }
            }
            NSArray *arrB = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",BtnY],[NSString stringWithFormat:@"%d",BtnM],[NSString stringWithFormat:@"%d",self.BtnD], nil];
            
            for (NSInteger i = 0; i < [date1Arr count]; i ++)
            {
                if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                    [date1Arr[i][1] integerValue] == self.calenderV.month)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                    for (NSInteger i = 1; i < button.subviews.count;)
                    {
                        [button.subviews[i] removeFromSuperview];
                    }
                    [button setTitle:@"" forState:UIControlStateNormal];
                    WeekD = [self GetWeekWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:[date1Arr[i][2] integerValue]];
                    [self addDayLText:date1Arr[i][2] withBtn:button];
                    [self addMoneyLText:[NSString stringWithFormat:@"$%@",UPArr[WeekD - 1]] withBtn:button];
                    [self addNumLText:[NSString stringWithFormat:@"剩%@",numArr[i]] withBtn:button];
                }
            }
            if ([date1Arr containsObject:arrB] == YES)
            {
                for (NSInteger i = 0; i < [date1Arr count]; i ++)
                {
                    if (BtnY == self.calenderV.year &&
                        BtnM == self.calenderV.month)
                    {
                        if ([date1Arr[i][2] integerValue] == DF)
                        {
                            UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                            button.backgroundColor = CyanCo;
                        }
                    }
                }
            }
        }
        else
        {
            NSArray *arr = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",self.calenderV.year],[NSString stringWithFormat:@"%d",self.calenderV.month],[NSString stringWithFormat:@"%d",sender.tag], nil];
            NSArray *arrB = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",BtnY],[NSString stringWithFormat:@"%d",BtnM],[NSString stringWithFormat:@"%d",self.BtnD], nil];
            WeekD = [self GetWeekWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:sender.tag ];
            roomNum = [PCArr[WeekD - 1] integerValue];

            if ([date1Arr containsObject:arr])
            {
                if (DF == -1)
                {
                    for (NSInteger i = 0; i < [date1Arr count]; i ++)
                    {
                        if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                            [date1Arr[i][1] integerValue] == self.calenderV.month)
                        {
                            if ([date1Arr[i][2] integerValue] == sender.tag)
                            {
                                UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                                button.backgroundColor = CyanCo;
                                YDButton.backgroundColor = BlueCo;
                                CM = CPArr[WeekD - 1];
                                UM = UPArr[WeekD - 1];
                                price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",CM,UM];
                                DF = sender.tag;
                                BtnY = self.calenderV.year;
                                BtnM = self.calenderV.month;
                                self.BtnD = DF;
                                roomNum = [numArr[i] integerValue];
                            }
                        }
                    }
                }
                else if(sender.tag == DF)
                {
                    for (NSInteger i = 0; i < [date1Arr count]; i ++)
                    {
                        if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                            [date1Arr[i][1] integerValue] == self.calenderV.month)
                        {
                            if ([date1Arr[i][2] integerValue] == sender.tag)
                            {
                                UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                                button.backgroundColor = Gary96;
                                YDButton.backgroundColor = Gary55;
                                price.text=@"";
                                DF = -1;
                                BtnY = self.calenderV.year;
                                BtnM = self.calenderV.month;
                                self.BtnD = sender.tag;
                            }
                        }
                    }
                }
                else if([date1Arr containsObject:arrB] == NO)
                {
                    [self clickAgainBtn:sender];
                    for (NSInteger i = 0; i < [date1Arr count]; i ++)
                    {
                        if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                            [date1Arr[i][1] integerValue] == self.calenderV.month)
                        {
                            if ([date1Arr[i][2] integerValue] == sender.tag)
                            {
                                UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                                button.backgroundColor = CyanCo;
                                YDButton.backgroundColor = BlueCo;
                                CM = CPArr[WeekD - 1];
                                UM = UPArr[WeekD - 1];
                                price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",CM,UM];
                                DF = sender.tag;
                                BtnY = self.calenderV.year;
                                BtnM = self.calenderV.month;
                                self.BtnD = DF;
                                roomNum = [numArr[i] integerValue];
                            }
                        }
                    }
                }
                else
                {
                    if (self.calenderV.year == BtnY && self.calenderV.month == BtnM)
                    {
                        UIButton *button = (UIButton *)[self.calenderV viewWithTag:self.BtnD];
                        button.backgroundColor = Gary96;
                    }
                    for (NSInteger i = 0; i < [date1Arr count]; i ++)
                    {
                        if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                            [date1Arr[i][1] integerValue] == self.calenderV.month)
                        {
                            if ([date1Arr[i][2] integerValue] == sender.tag)
                            {
                                UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                                button.backgroundColor = CyanCo;
                                DF = sender.tag;
                                BtnY = self.calenderV.year;
                                BtnM = self.calenderV.month;
                                self.BtnD = DF;
                                roomNum = [numArr[i] integerValue];
                            }
                        }
                    }
                }
            }
            else
            {
                if ([date1Arr containsObject:arrB] == YES)
                {
                    [self clickDuringTheActivity:sender];
                    for (NSInteger i = 0; i < [date1Arr count]; i ++)
                    {
                        if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                            [date1Arr[i][1] integerValue] == self.calenderV.month)
                        {
                            UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                            [button setTitle:@"" forState:UIControlStateNormal];
                            for (NSInteger i = 1; i < button.subviews.count;)
                            {
                                [button.subviews[i] removeFromSuperview];
                            }
                            WeekD = [self GetWeekWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:[date1Arr[i][2] integerValue]];
                            [self addDayLText:date1Arr[i][2] withBtn:button];
                            [self addMoneyLText:[NSString stringWithFormat:@"$%@",UPArr[WeekD - 1]] withBtn:button];
                            [self addNumLText:[NSString stringWithFormat:@"剩%@",numArr[i]] withBtn:button];
                        }
                    }
                }
                else
                {
                    [self clickDuringTheActivity:sender];
                }
            }
            if (self.calenderV.year == [yearArr[0] integerValue] &&
                self.calenderV.month == [monthArr[0] integerValue] &&
                self.calenderV.year == [yearArr[1] integerValue] &&
                self.calenderV.month == [monthArr[1] integerValue])
            {
                if (sender.tag >= [dayArr[0] integerValue] &&
                    sender.tag <= [dayArr[1] integerValue])
                {
                    [self shanchu:sender];
                }
            }
            else if (self.calenderV.year == [yearArr[0] integerValue] &&
                self.calenderV.month == [monthArr[0] integerValue])
            {
                if (sender.tag >= [dayArr[0] integerValue])
                {
                    [self shanchu:sender];
                }
            }
            else if (self.calenderV.year == [yearArr[1] integerValue] &&
                self.calenderV.month == [monthArr[1] integerValue])
            {
                if (sender.tag <= [dayArr[1] integerValue])
                {
                    [self shanchu:sender];
                }
            }
            else
            {
                [self shanchu:sender];
            }
        }
    }
    else if ([self.prodType integerValue] == 2)
    {
        if (firstF == NO)
        {
            for (NSInteger i = 0; i<[DataArr count]; i ++)
            {
                NSString *Pdata = [DataArr[i] objectForKey:@"PDate"];
                [dateArr addObject:Pdata];
            }
            [self changeBtnDateWithArray:dateArr];
            firstF = YES;
        }
        
        if (sender.tag == 0)
        {
            for (NSInteger i = 0; i< [yearArr count]; i ++)
            {
                if ([yearArr[i] integerValue] == self.calenderV.year && [monthArr[i] integerValue] == self.calenderV.month)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:[dayArr[i] integerValue]];
                    button.backgroundColor = Gary96;
                    [button setTitle:@"" forState:UIControlStateNormal];
                    
                    UILabel *dayL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, 20)];
                    dayL.text = dayArr[i];
                    dayL.textAlignment = NSTextAlignmentCenter;
                    dayL.font = [UIFont systemFontOfSize:14];
                    [button addSubview:dayL];
                    
                    UILabel *moneyL = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, button.frame.size.width, 12)];
                    moneyL.textAlignment = NSTextAlignmentCenter;
                    moneyL.text = [NSString stringWithFormat:@"$%@",[DataArr[i] objectForKey:@"Price"]];
                    moneyL.textColor = [UIColor orangeColor];
                    moneyL.font = [UIFont systemFontOfSize:9];
                    [button addSubview:moneyL];
                    
                    UILabel *numL = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, button.frame.size.width - 3, button.frame.size.height - 32)];
                    numL.textAlignment = NSTextAlignmentRight;
                    numL.text = [NSString stringWithFormat:@"剩%@",[DataArr[i] objectForKey:@"Number"]];
                    numL.textColor = [UIColor colorWithRed:0.26 green:0.57 blue:0.23 alpha:1];
                    numL.font = [UIFont systemFontOfSize:9];
                    roomNum = [[DataArr[i] objectForKey:@"Number"]integerValue];
                    [button addSubview:numL];
                }
               
                if (BtnY == self.calenderV.year && BtnM == self.calenderV.month)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:DF];
                    button.backgroundColor = CyanCo;
                    YDButton.backgroundColor = BlueCo;
                    if (lineF == NO && self.checkDate != nil)
                    {
                        
                        if ([self.title isEqual:@"出发日期"])
                        {
                            price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",self.lineRC.RMB,self.lineRC.dollar];
                        }
                        else if ([self.title isEqual:@"订票日期"])
                        {
                            price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",self.entainRC.RMB,self.entainRC.dollar];
                        }

                        lineF = YES;
                    }
                }
            }
        }
        else
        {
            for (NSInteger i = 0; i< [yearArr count]; i ++)
            {
                if ([yearArr[i] integerValue] == self.calenderV.year && [monthArr[i] integerValue] == self.calenderV.month)
                {
                    if (sender.tag == [dayArr[i] integerValue])
                    {
                        CM = [DataArr[i] objectForKey:@"RPrice"];
                        UM = [DataArr[i] objectForKey:@"Price"];
                        if (DF == -1)
                        {
                            sender.backgroundColor = CyanCo;
                            price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",CM,UM];
                            DF = sender.tag;
                            YDButton.backgroundColor = BlueCo;
                        }
                        else if (DF == sender.tag)
                        {
                            sender.backgroundColor = Gary96;
                            price.text = @"";
                            DF = -1;
                            YDButton.backgroundColor = Gary55;
                        }
                        else
                        {
                            UIButton *button = (UIButton *)[self.calenderV viewWithTag:DF];
                            button.backgroundColor = Gary96;
                            sender.backgroundColor = CyanCo;
                            price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",CM,UM];
                            DF = sender.tag;
                        }
                        BtnY = [yearArr[i] integerValue];
                        BtnM = [monthArr[i] integerValue];
                        self.BtnD = DF;
                    }
                }
            }
        }
    }
//    else if ([self.prodType integerValue] == 3)
//    {
//        if (firstF == NO)
//        {
////            DataArr = @[@"2014-10-10",@"2015-02-25"];
//            dateArr = (NSMutableArray *)DataArr;
//            [self changeBtnDateWithArray:dateArr];
//            firstF = YES;
//        }
//        if (sender.tag == 0)
//        {
//            [self duringTheActivity:sender];
//        }
//        else
//        {
//            [self clickDuringTheActivity:sender];
//        }
//    }
    else if ([self.prodType integerValue] == 4)
    {
        if (sender.tag == 0)
        {
            [self duringTheActivity:sender];
            [self changeclickOutBtn:sender];
            for (NSInteger i = 0; i < [date2Arr count]; i ++)
            {
                if ([date2Arr[i][0] integerValue] == self.calenderV.year &&
                    [date2Arr[i][1] integerValue] == self.calenderV.month)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date2Arr[i][2] integerValue]];
                    button.backgroundColor = Gary90;
                    button.userInteractionEnabled = NO;
                }
            }
            for (NSInteger i = 0; i < [date1Arr count]; i ++)
            {
                if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                    [date1Arr[i][1] integerValue] == self.calenderV.month)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                    for (NSInteger i = 1; i < button.subviews.count;)
                    {
                        [button.subviews[i] removeFromSuperview];
                    }
                    [button setTitle:@"" forState:UIControlStateNormal];
                    WeekD = [self GetWeekWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:[date1Arr[i][2] integerValue]];
                    [self addDayLText:date1Arr[i][2] withBtn:button];
                    [self addMoneyLText:[NSString stringWithFormat:@"$%@",UPArr[WeekD - 1]] withBtn:button];
                    [self addNumLText:[NSString stringWithFormat:@"剩%@",numArr[i]] withBtn:button];
                }
            }
        }
        else
        {
            
            if (self.calenderV.year == [yearArr[0] integerValue] && self.calenderV.month == [monthArr[0] integerValue])
            {
                if (BtnY == self.calenderV.year && BtnM == self.calenderV.month)
                {
                    if (sender.tag >= [dayArr[0] integerValue] && sender.tag<=self.BtnD)
                    {
                        [self clickAgainBtn:sender];
                        [self clickOnBtn:sender];
                        [self.CIOArr removeAllObjects];
                        [self CheckInAndCheckOut:sender];
                    }
                }
                else
                {
                    [self clickAgainBtn:sender];
                    [self clickOnBtn:sender];
                    [self.CIOArr removeAllObjects];
                    [self CheckInAndCheckOut:sender];
                }
            }
            if (self.calenderV.year == [yearArr[0] integerValue] && [yearArr[0] integerValue] == BtnY)
            {
                if (self.calenderV.month > [monthArr[0] integerValue] && self.calenderV.month < BtnM)
                {
                    [self clickAgainBtn:sender];
                    [self clickOnBtn:sender];
                    [self.CIOArr removeAllObjects];
                    [self CheckInAndCheckOut:sender];
                }
            }
            else if ([yearArr[0] integerValue] <BtnY)
            {
                if (self.calenderV.month > [monthArr[0] integerValue] && self.calenderV.year == [yearArr[0] integerValue])
                {
                    [self clickAgainBtn:sender];
                    [self clickOnBtn:sender];
                    [self.CIOArr removeAllObjects];
                    [self CheckInAndCheckOut:sender];
                }
                else if (self.calenderV.month < BtnM && self.calenderV.year == BtnY)
                {
                    [self clickAgainBtn:sender];
                    [self clickOnBtn:sender];
                    [self.CIOArr removeAllObjects];
                    [self CheckInAndCheckOut:sender];
                }
            }
            if (self.calenderV.year == BtnY && self.calenderV.month == BtnM)
            {
                if (sender.tag <= self.BtnD)
                {
                    [self clickAgainBtn:sender];
                    [self clickOnBtn:sender];
                    [self.CIOArr removeAllObjects];
                    [self CheckInAndCheckOut:sender];
                }
            }
            
            
            if (self.calenderV.year == BtnY && self.calenderV.month == BtnM)
            {
                if ([yearArr[1] integerValue] == self.calenderV.year && [monthArr[1] integerValue] == self.calenderV.month)
                {
                    if (sender.tag > self.BtnD && sender.tag<=[dayArr[1] integerValue])
                    {
                        [self CheckInAndCheckOut:sender];
                    }
                }
                else if(sender.tag >self.BtnD)
                {
                    [self CheckInAndCheckOut:sender];
                }
            }
            if (self.calenderV.year == BtnY && BtnY == [yearArr[1] integerValue])
            {
                if (self.calenderV.month > BtnM && self.calenderV.month < [monthArr[1] integerValue])
                {
                    [self CheckInAndCheckOut:sender];
                }
            }
            else if (BtnY <[yearArr[1] integerValue])
            {
                if (self.calenderV.month > BtnM && self.calenderV.year == BtnY)
                {
                    [self CheckInAndCheckOut:sender];
                }
                else if (self.calenderV.month < [monthArr[1] integerValue] && self.calenderV.year == [yearArr[1] integerValue])
                {
                    [self CheckInAndCheckOut:sender];
                }
            }
            if (self.calenderV.year == [yearArr[1] integerValue] && self.calenderV.month == [monthArr[1] integerValue])
            {
                if (self.calenderV.year != BtnY && self.calenderV.month)
                {
                    if (sender.tag <= [dayArr[1] integerValue])
                    {
                        [self CheckInAndCheckOut:sender];
                    }
                }
            }
            for (NSInteger i = 0; i < [date1Arr count]; i ++)
            {
                if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                    [date1Arr[i][1] integerValue] == self.calenderV.month)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date2Arr[i][2] integerValue]];
                    for (NSInteger i = 1; i < button.subviews.count;)
                    {
                        [button.subviews[i] removeFromSuperview];
                    }
                    [button setTitle:date2Arr[i][2] forState:UIControlStateNormal];
                    button.backgroundColor = Gary90;
                    button.userInteractionEnabled = NO;
                }
            }
            for (NSInteger i = 0; i < [date1Arr count]; i ++)
            {
                if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                    [date1Arr[i][1] integerValue] == self.calenderV.month)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                    for (NSInteger i = 1; i < button.subviews.count;)
                    {
                        [button.subviews[i] removeFromSuperview];
                    }
                    [button setTitle:@"" forState:UIControlStateNormal];
                    WeekD = [self GetWeekWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:[date1Arr[i][2] integerValue]];
                    [self addDayLText:date1Arr[i][2] withBtn:button];
                    [self addMoneyLText:[NSString stringWithFormat:@"$%@",UPArr[WeekD - 1]] withBtn:button];
                    [self addNumLText:[NSString stringWithFormat:@"剩%@",numArr[i]] withBtn:button];
                }
            }
        }
    }
}


- (void)shanchu:(UIButton *)sender
{
    if ( self.hotelBool == NO)
    {
        self.hotelBool = YES;

        for (NSInteger i = 1; i < 32; i ++)
        {
            UIButton *button = (UIButton *)[self.calenderV viewWithTag: i];
            [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            for (NSInteger i = 1; i < button.subviews.count;)
            {
                [button.subviews[i] removeFromSuperview];
            }
        }
        
        [self duringTheActivity:sender];
        for (NSInteger i = 0; i < [date2Arr count]; i ++)
        {
            if ([date2Arr[i][0] integerValue] == self.calenderV.year &&
                [date2Arr[i][1] integerValue] == self.calenderV.month)
            {
                UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date2Arr[i][2] integerValue]];
                button.backgroundColor = Gary90;
                button.userInteractionEnabled = NO;
            }
        }
        NSArray *arrB = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%d",BtnY],[NSString stringWithFormat:@"%d",BtnM],[NSString stringWithFormat:@"%d",self.BtnD], nil];
        
        for (NSInteger i = 0; i < [date1Arr count]; i ++)
        {
            if ([date1Arr[i][0] integerValue] == self.calenderV.year &&
                [date1Arr[i][1] integerValue] == self.calenderV.month)
            {
                UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                for (NSInteger i = 1; i < button.subviews.count;)
                {
                    [button.subviews[i] removeFromSuperview];
                }
                [button setTitle:@"" forState:UIControlStateNormal];
                WeekD = [self GetWeekWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:[date1Arr[i][2] integerValue]];
                [self addDayLText:date1Arr[i][2] withBtn:button];
                [self addMoneyLText:[NSString stringWithFormat:@"$%@",UPArr[WeekD - 1]] withBtn:button];
                [self addNumLText:[NSString stringWithFormat:@"剩%@",numArr[i]] withBtn:button];
            }
        }
        if ([date1Arr containsObject:arrB] == YES)
        {
            for (NSInteger i = 0; i < [date1Arr count]; i ++)
            {
                if (BtnY == self.calenderV.year &&
                    BtnM == self.calenderV.month)
                {
                    if ([date1Arr[i][2] integerValue] == DF)
                    {
                        UIButton *button = (UIButton *)[self.calenderV viewWithTag:[date1Arr[i][2] integerValue]];
                        button.backgroundColor = CyanCo;
                    }
                }
            }
        }
    }
}


- (void)addDayLText:(NSString *)labelT withBtn:(UIButton *)button
{
    UILabel *dayL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, 20)];
    dayL.text = labelT;
    dayL.textAlignment = NSTextAlignmentCenter;
    dayL.font = [UIFont systemFontOfSize:14];
    [button addSubview:dayL];
}

- (void)addMoneyLText:(NSString *)labelT withBtn:(UIButton *)button
{
    UILabel *moneyL = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, button.frame.size.width, 12)];
    moneyL.textAlignment = NSTextAlignmentCenter;
    moneyL.text = labelT;
    moneyL.textColor = [UIColor orangeColor];
    moneyL.font = [UIFont systemFontOfSize:9];
    [button addSubview:moneyL];

}

- (void)addNumLText:(NSString *)labelT withBtn:(UIButton *)button
{
    UILabel *numL = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, button.frame.size.width - 3, button.frame.size.height - 32)];
    numL.textAlignment = NSTextAlignmentRight;
    numL.text = labelT;
    numL.textColor = [UIColor colorWithRed:0.26 green:0.57 blue:0.23 alpha:1];
    numL.font = [UIFont systemFontOfSize:9];
    [button addSubview:numL];
}


- (void)clickDuringTheActivity:(UIButton *)sender
{
    if ([self.CIOArr count] != 0)
    {
        [self.CIOArr removeAllObjects];
//        for (NSInteger i = 1; i < [self GetMonthDayWithYear:BtnY andMonth:BtnM] - self.BtnD + 1; i ++)
//        {
//            if (self.calenderV.year == BtnY  && self.calenderV.month == BtnM) {
//                UIButton *button = (UIButton *)[self.calenderV viewWithTag:self.BtnD + i];
//                for (NSInteger i = 1; i < button.subviews.count;)
//                {
//                    [button.subviews[i] removeFromSuperview];
//                }
//                [button setTitle:[NSString stringWithFormat:@"%d",self.endD + i] forState:UIControlStateNormal];
////                button.backgroundColor = Gary96;
//            }
//        }
        if (BtnM != endM)
        {
            for (NSInteger i = 1; i <= self.endD ; i ++)
            {
                if (self.calenderV.year == endY  && self.calenderV.month == endM)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:i];
                    for (NSInteger i = 1; i < button.subviews.count;)
                    {
                        [button.subviews[i] removeFromSuperview];
                    }
                    [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
                    button.backgroundColor = Gary96;
                }
            }
        }
    }
    if (self.calenderV.year == [yearArr[0] integerValue] && self.calenderV.month == [monthArr[0] integerValue])
    {
        if ([yearArr[1] integerValue] == [yearArr[0] integerValue] && [monthArr[1] integerValue] == [monthArr[0] integerValue])
        {
            if (sender.tag >= [dayArr[0] integerValue] && sender.tag<=[dayArr[1]integerValue])
            {
                [self changeBtn:sender];
            }
        }
        else if (sender.tag >= [dayArr[0] integerValue])
        {
            [self changeBtn:sender];
        }
    }
    else  if (self.calenderV.year == [yearArr[1] integerValue] && self.calenderV.month == [monthArr[1] integerValue])
    {
        if (sender.tag <= [dayArr[1] integerValue])
        {
            [self changeBtn:sender];
        }
    }

    if (self.calenderV.year == [yearArr[0] integerValue] && [yearArr[0] integerValue] == [yearArr[1] integerValue])
    {
        if (self.calenderV.month > [monthArr[0] integerValue] && self.calenderV.month < [monthArr[1] integerValue])
        {
            [self changeBtn:sender];
        }
    }
    else if ([yearArr[0] integerValue] < [yearArr[1] integerValue])
    {
        if (self.calenderV.month > [monthArr[0] integerValue] && self.calenderV.year == [yearArr[0] integerValue])
        {
            [self changeBtn:sender];
        }
        else if (self.calenderV.month < [monthArr[1] integerValue] && self.calenderV.year == [yearArr[1] integerValue])
        {
            [self changeBtn:sender];
        }
    }
}


#pragma -mark 入住和退房
- (void)CheckInAndCheckOut:(UIButton *)sender
{
    if ([self getDays:sender] + 1 <= 20 + fi)
    {
//        NSLog(@"yes");
        if (sender.tag != 0)
        {
            self.endD = sender.tag;
        }
        endM = self.calenderV.month;
        endY = self.calenderV.year;
        [self.CIOArr removeAllObjects];
        
        if (endM == BtnM)
        {
            for (NSInteger i = 0; i < [self getDays:sender] + 1; i ++)
            {
                NSArray *arr =[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",BtnY],[NSString stringWithFormat:@"%d",BtnM],[NSString stringWithFormat:@"%d",self.BtnD + i], nil];
                [self.CIOArr addObject:arr];
            }
        }
        else
        {
            for (NSInteger i = 0; i < [self GetMonthDayWithYear:BtnY andMonth:BtnM] - self.BtnD + 1; i ++)
            {
                NSArray *arr =[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",BtnY],[NSString stringWithFormat:@"%d",BtnM],[NSString stringWithFormat:@"%d",self.BtnD + i], nil];
                [self.CIOArr addObject:arr];
            }
            for (NSInteger i = 1; i <= self.endD; i ++)
            {
                NSArray *arr =[[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",endY],[NSString stringWithFormat:@"%d",endM],[NSString stringWithFormat:@"%d",i], nil];
                [self.CIOArr addObject:arr];
            }
        }
        [self changeclickOutBtn:sender];
    }
    else
    {
//        NSLog(@"no");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"不好意思，最多只能帮你订20天。" delegate:self cancelButtonTitle:@"好的，谢谢" otherButtonTitles: nil];
        [alert show];
    }
}

#pragma - mark 点击退房
- (void)changeclickOutBtn:(UIButton *)sender
{
    NSInteger up = 0;
    NSInteger cp = 0;
    for (NSInteger i = 0; i < [self.CIOArr count]; i ++)
    {
        NSInteger bf = [self GetWeekWithYear:[self.CIOArr[i][0] integerValue]andMonth:[self.CIOArr[i][1] integerValue] andDay:[self.CIOArr[i][2] integerValue]];
        //            PCArr = @[@"3",@"5",@"6",@"8",@"9",@"6",@"4"];
        for (NSInteger j = 0; j < [numArr count]; j ++)
        {
            if ([numArr[j] integerValue] <= roomNum)
            {
                roomNum = [numArr[j] integerValue];
            }
        }
        if (roomNum >= [PCArr[bf - 1] integerValue])
        {
            roomNum = [PCArr[bf - 1] integerValue];
        }
        up += [UPArr[bf - 1] integerValue];
        UM = [NSString stringWithFormat:@"%d",up];
        cp += [CPArr[bf - 1] integerValue];
        CM = [NSString stringWithFormat:@"%d",cp];
        for (NSInteger j = 0; j < [date2Arr count]; j ++)
        {
            if ([self.CIOArr[i][0] integerValue] == [date2Arr[j][0] integerValue]&&
                [self.CIOArr[i][1] integerValue] == [date2Arr[j][1] integerValue]&&
                [self.CIOArr[i][2] integerValue] == [date2Arr[j][2] integerValue])
            {
                NSInteger date = [self GetWeekWithYear:[date2Arr[j][0] integerValue]andMonth:[date2Arr[j][1] integerValue] andDay:[date2Arr[j][2] integerValue]];
                
                up -= [UPArr[date - 1] integerValue];
                UM = [NSString stringWithFormat:@"%d",up];
                cp -= [CPArr[date - 1] integerValue];
                CM = [NSString stringWithFormat:@"%d",cp];
            }
        }
        price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",CM,UM];
        if ([self.CIOArr[i][0] integerValue] == self.calenderV.year && [self.CIOArr[i][1] integerValue] == self.calenderV.month)
        {
            
            UIButton *button = (UIButton *)[self.calenderV viewWithTag:[self.CIOArr[i][2] integerValue]];
            button.backgroundColor = CyanCo;
            for (NSInteger i = 1; i < button.subviews.count;)
            {
                [button.subviews[i] removeFromSuperview];
            }
            [button setTitle:@"" forState:UIControlStateNormal];
            
            [self addDayLText:[NSString stringWithFormat:@"%d",[self.CIOArr[i][2] integerValue]] withBtn:button];
            
            WeekD = [self GetWeekWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:[self.CIOArr[i][2] integerValue]];

            
            [self addMoneyLText:[NSString stringWithFormat:@"$%@",UPArr[WeekD - 1]] withBtn:button];
            
            UILabel *numL = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, button.frame.size.width, button.frame.size.height - 32)];
            numL.textAlignment = NSTextAlignmentCenter;
            if (i == 0)
            {
                numL.text = [NSString stringWithFormat:@"入住"];
            }
            else if ([self.CIOArr[i][2] integerValue] == self.endD)
            {
                numL.text = [NSString stringWithFormat:@"退房"];
            }
            else
            {
                numL.text = [NSString stringWithFormat:@""];
            }
            numL.textColor = [UIColor colorWithRed:0.26 green:0.57 blue:0.23 alpha:1];
            numL.font = [UIFont systemFontOfSize:9];
            [button addSubview:numL];
        }
    }
    //删除退房的button
        if (self.calenderV.year == endY  && self.calenderV.month == endM)
        {
            if (self.calenderV.year == [yearArr[1] integerValue] && self.calenderV.month == [monthArr[1] integerValue])
            {
                for (NSInteger i = 1; i <= [dayArr[1] integerValue] - self.endD; i ++)
                {
                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:self.endD + i];
                    for (NSInteger j = 1; j < button.subviews.count;)
                    {
                        [button.subviews[j] removeFromSuperview];
                    }
                    [button setTitle:[NSString stringWithFormat:@"%d",self.endD + i] forState:UIControlStateNormal];
                    button.backgroundColor = Gary96;
                }
            }
            else
            {
                for (NSInteger i = 1; i < [self GetMonthDayWithYear:endY andMonth:endM] - self.endD + 1; i ++)
                {

                    UIButton *button = (UIButton *)[self.calenderV viewWithTag:self.endD + i];
                    for (NSInteger j = 1; j < button.subviews.count;)
                    {
                        [button.subviews[j] removeFromSuperview];
                    }
                    [button setTitle:[NSString stringWithFormat:@"%d",self.endD + i] forState:UIControlStateNormal];
                    button.backgroundColor = Gary96;
                }
            }
        }
    
}

#pragma -mark 求两个日期相隔的天数
- (NSInteger)getDays:(UIButton *)sender
{
    NSCalendar *userCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *components = [userCalendar components:unitFlags fromDate:[self dateWithYear:BtnY andMonth:BtnM andDay:self.BtnD] toDate:[self dateWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:sender.tag]  options:0];
    NSInteger days = [components day];
    /*---------------------------------------------------------------*/
    fi = 0;
    for (NSInteger i = 0; i <[date2Arr count]; i ++)
    {
        NSDateComponents *component = [userCalendar components:unitFlags fromDate:[self dateWithYear:BtnY andMonth:BtnM andDay:self.BtnD] toDate:[self dateWithYear:[date2Arr[i][0] integerValue] andMonth:[date2Arr[i][1] integerValue] andDay:[date2Arr[i][2] integerValue]]  options:0];
        NSInteger day = [component day];
        if (days >= day && day >0)
        {
            fi ++;
        }
    }
//    NSLog(@"days = %d",days);
    return days;
}

#pragma - mark 初始日期与结束日期的区间
- (void)duringTheActivity:(UIButton *)sender
{
    if (self.calenderV.year == [yearArr[0] integerValue] &&
        self.calenderV.month == [monthArr[0] integerValue] &&
        self.calenderV.year == [yearArr[1] integerValue] &&
        self.calenderV.month == [monthArr[1] integerValue])
    {
        for (NSInteger i = 0; i < [dayArr[1] integerValue] - [dayArr[0] integerValue] + 1; i ++)
        {
            UIButton *button = (UIButton *)[self.calenderV viewWithTag:[dayArr[0] integerValue] + i];
            button.backgroundColor = Gary96;
        }
        
    }

     else if (self.calenderV.year == [yearArr[0] integerValue] && self.calenderV.month == [monthArr[0] integerValue])
    {
        for (NSInteger i = 0; i < [self GetMonthDayWithYear:[yearArr[0] integerValue] andMonth:[monthArr[0] integerValue]] - [dayArr[0] integerValue] + 1; i ++)
        {
            UIButton *button = (UIButton *)[self.calenderV viewWithTag:[dayArr[0] integerValue] + i];
            button.backgroundColor = Gary96;
        }
    }
    else if (self.calenderV.year == [yearArr[1] integerValue] && self.calenderV.month == [monthArr[1] integerValue])
        {
            for (NSInteger i = 1; i <= [dayArr[1] integerValue]; i ++)
            {
                UIButton *button = (UIButton *)[self.calenderV viewWithTag:i];
                button.backgroundColor = Gary96;
            }
        }

        if (self.calenderV.year == [yearArr[0] integerValue] && [yearArr[0] integerValue] == [yearArr[1] integerValue])
    {
        if (self.calenderV.month > [monthArr[0] integerValue] && self.calenderV.month < [monthArr[1] integerValue])
        {
            for (NSInteger i = 1; i < 32; i ++)
            {
                UIButton *button = (UIButton *)[self.calenderV viewWithTag: i];
                button.backgroundColor = Gary96;
            }
        }
    }
    else if ([yearArr[0] integerValue] < [yearArr[1] integerValue])
    {
        if (self.calenderV.month > [monthArr[0] integerValue] && self.calenderV.year == [yearArr[0] integerValue])
        {
            for (NSInteger i = 1; i < 32; i ++)
            {
                UIButton *button = (UIButton *)[self.calenderV viewWithTag: i];
                button.backgroundColor = Gary96;
            }
        }
        else if (self.calenderV.month < [monthArr[1] integerValue] && self.calenderV.year == [yearArr[1] integerValue])
        {
            for (NSInteger i = 1; i < 32; i ++)
            {
                UIButton *button = (UIButton *)[self.calenderV viewWithTag: i];
                button.backgroundColor = Gary96;
            }
        }
    }
    if (self.calenderV.year == BtnY && self.calenderV.month == BtnM)
    {
        [self clickOnBtn:sender];
    }
}


#pragma - mark 第一次点击btn触发的方法
- (void)clickOnBtn:(UIButton *)sender
{
    if (sender.tag != 0)
    {
        DF = sender.tag;
    }
    UIButton *button = (UIButton *)[self.calenderV viewWithTag:DF];
    button.backgroundColor = CyanCo;
    [button setTitle:@"" forState:UIControlStateNormal];
    
    UILabel *dayL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, 20)];
    dayL.text = [NSString stringWithFormat:@"%d",DF];
    dayL.textAlignment = NSTextAlignmentCenter;
    dayL.font = [UIFont systemFontOfSize:14];
    dayL.tag = 1;
    [button addSubview:dayL];
    
    UILabel *moneyL = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, button.frame.size.width, 12)];
    moneyL.textAlignment = NSTextAlignmentCenter;
    
    WeekD = [self GetWeekWithYear:self.calenderV.year andMonth:self.calenderV.month andDay:DF];
//    NSLog(@"weekD = %d",WeekD);
    
    moneyL.text = [NSString stringWithFormat:@"$%@",UPArr[WeekD - 1]];
    moneyL.textColor = [UIColor orangeColor];
    moneyL.font = [UIFont systemFontOfSize:9];
    moneyL.tag = 2;
    [button addSubview:moneyL];
    
    UILabel *numL = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, button.frame.size.width - 3, button.frame.size.height - 32)];
    numL.textAlignment = NSTextAlignmentRight;
    numL.text = [NSString stringWithFormat:@"剩%@",PCArr[WeekD - 1]];
    numL.textColor = [UIColor colorWithRed:0.26 green:0.57 blue:0.23 alpha:1];
    roomNum = [PCArr[WeekD - 1] integerValue];
    numL.font = [UIFont systemFontOfSize:9];
    numL.tag = 3;
    [button addSubview:numL];
    
    self.BtnD = DF;
    BtnM = self.calenderV.month;
    BtnY = self.calenderV.year;
    
    CM = CPArr[WeekD - 1];
    UM = UPArr[WeekD - 1];
    price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",CPArr[WeekD - 1],UPArr[WeekD - 1]];
    YDButton.backgroundColor = BlueCo;
}

#pragma -mark 再次点击触发的方法
- (void)clickAgainBtn:(UIButton *)sender
{
    UIButton *button = (UIButton *)[self.calenderV viewWithTag:DF];
    for (NSInteger i = 1; i < button.subviews.count;)
    {
        [button.subviews[i] removeFromSuperview];
    }
    [button setTitle:[NSString stringWithFormat:@"%d",DF] forState:UIControlStateNormal];

    if (self.calenderV.year == BtnY && self.calenderV.month == BtnM)
    {
        button.backgroundColor = Gary96;
    }
    price.text = @"";
    DF = sender.tag;
    self.BtnD = sender.tag;
    BtnM = self.calenderV.month;
    BtnY = self.calenderV.year;
    YDButton.backgroundColor = Gary55;
}


- (void)changeBtn:(UIButton *)sender
{
    if (DF == -1)
    {
        [self clickOnBtn:sender];
    }
    else if(DF == sender.tag && self.calenderV.year == BtnY && self.calenderV.month == BtnM)
    {
        [self clickAgainBtn:sender];
        DF = -1;
    }
    else
    {
        [self clickAgainBtn:sender];
        [self clickOnBtn:sender];
    }
}

#pragma -mark 通过年月日求星期几
- (NSInteger)GetWeekWithYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps.day = day;
    comps.year = year;
    comps.month = month;
    now=[NSDate date];
    now = [calendar dateFromComponents:comps];
    comps = [calendar components:unitFlags fromDate:now];
    return comps.weekday;
//    NSLog(@"weekday = %d",comps.weekday);
}

#pragma  - mark 求某个月有几天
- (NSInteger)GetMonthDayWithYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps.day = Day;
    comps.year = year;
    comps.month = month;
    now=[NSDate date];
    now = [calendar dateFromComponents:comps];
    comps = [calendar components:unitFlags fromDate:now];
    NSRange days = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:now];
    return days.length;
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
