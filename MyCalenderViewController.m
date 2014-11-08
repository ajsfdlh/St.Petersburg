//
//  MyCalanderViewController.m
//  重写日历
//
//  Created by 刘 吕琴 on 14-6-23.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MyCalenderViewController.h"
#import "GDataXMLNode.h"
#import "RoomReseverClass.h"
#import "SceneryReceverClass.h"
#import "JSON.h"
@implementation MyCalenderViewController
backButton
-(void)viewWillAppear:(BOOL)animated{
    //获取网络数据
    NSLog(@"_ProdType %@  id %@",_ProdType,_ID);
    if ([self.title isEqualToString:@"订票日期"]) {
        NSMutableString*str=RussiaUrl3;
        [str appendString:@"getTicketPriceDetail"];
        NSString *argStr = [NSString stringWithFormat:@"ID=%@",_ID];
        postRequestYiBu(argStr, str)
    }else if ([self.title isEqualToString:@"出发日期"]) {
        NSMutableString*str=RussiaUrl2;
        [str appendString:@"getLinePriceDetail"];
        NSString *argStr = [NSString stringWithFormat:@"ID=%@",_ID];
        postRequestYiBu(argStr, str)
    }else {
        //酒店预订
        NSMutableString*str=RussiaUrl3;
        [str appendString:@"getRoomPriceDetail"];
        NSString *argStr = [NSString stringWithFormat:@"ID=%@",_ID];
        postRequestYiBu(argStr, str)
    }
    
}
postRequestAgency(datas)
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    dicResultYiBu(datas, result, dic)
    
    dataArrs = [dic objectForKey:@"ds"];
    NSLog(@"result   %@",result);
    NSLog(@"dataArrs %@",dataArrs);
    NSDictionary* tempDic = dataArrs[0];
    if (result.length==0) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"访问失败。" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [av show];
        return;
    }else if (result.length==1){
        _ProdType=@"1";
    }else if (result.length==11){
        _ProdType=@"2";
        _isInOrOut=@"1";
    }else if (_ProdType.intValue==2||_ProdType.intValue==3) {
        
        //指定某些天可以预订
        currutDate = [startDate2Formatter dateFromString:[NSString stringWithFormat:@"%@ %@",[dataArrs[0] objectForKey:@"PDate"],hms]];
        NSLog(@"currutDate %@",currutDate);
    }else {
        // if (dic[@"date1"])
        //长期(可能某一天剩余较少或者某一天不能预订)]
        
        date1Arr = [NSMutableArray array];//用来存放能预订但是剩余较少的日期
        date2Arr = [NSMutableArray array];//用来存放某一天不能预订
        date3Arr = [NSMutableArray array];//用来存放剩余多少
        
        //遍历得到date1Arr和date2Arr的内容
//        for (int i = 1; i <= tempDic.count; i++) {
//            NSString* keyStr = [NSString stringWithFormat:@"date%d",i];
//            NSString* str = [tempDic objectForKey:keyStr];
//            NSRange douhao = [str rangeOfString:@","];
//            if (douhao.length > 0) {
//                NSArray* restDay = [str componentsSeparatedByString:@","];
//                [date1Arr addObject:restDay[0]];
//                [date3Arr addObject:restDay[1]];
//            } else {
//                [date2Arr addObject:str];
//            }
//        }
        
        
        for (NSInteger i = 0; i < [dataArrs count]; i ++)
        {
            [date1Arr addObject:[dataArrs[i] allValues] ];
        }
        date1Arr = date1Arr[0];
        for (NSInteger i = 0; i < [date1Arr count]; i ++)
        {
            if ([date1Arr[i] rangeOfString:@","].length>0)
            {
                [date2Arr addObject:[date1Arr[i] componentsSeparatedByString:@","][0]];
                [date3Arr addObject:[date1Arr[i] componentsSeparatedByString:@","][1]];
            }
            else
            {
                [date2Arr addObject:date1Arr[i]];
                [date3Arr addObject:@"0"];
            }
        }
        
        currutDate = [NSDate date];
        
        _ProdType=@"4";
        
    }
    // NSLog(@"pdatahms %@",[NSString stringWithFormat:@"%@ %@",[dataArrs[0] objectForKey:@"PDate"],hms]);
    //  NSLog(@"PDate  %@",[startDate2Formatter dateFromString:[NSString stringWithFormat:@"%@ %@",[dataArrs[0] objectForKey:@"PDate"],hms]]);
    
    //    // NSLog(@"currutDate %@",currutDate);
    [self calendarSetDate:currutDate];
    headDateLab.text = [self returnFormatterDateString:currutDate];
    NSLog(@"headDateLab.text:%@",headDateLab.text);
}
- (void)viewDidLoad{
    
    dataArrs = [NSMutableArray array];
    self.view.backgroundColor = BLACK_VIEW_COLOR;
    
    //    formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy-MM-dd"];
    //    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    
    startDate2Formatter = [[NSDateFormatter alloc] init];
    [startDate2Formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//CCD +08:00
    [startDate2Formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"_startDate2Str:  %@",_startDate2Str);
    hms=[_startDate2Str substringFromIndex:10];
    NSLog(@"hms  %@",hms);
    NSDate *startDate2 = [startDate2Formatter dateFromString:_startDate2Str];
    hmsArr = [hms componentsSeparatedByString:@":"];
    // NSLog(@"hmsArr  %@",hmsArr);
    // NSLog(@"startDate2  %@",startDate2);
    NSLog(@"_ToDateStr:  %@",_ToDateStr);
    if (_startDate) {
        startDateHMS = [startDate2Formatter dateFromString:[NSString stringWithFormat:@"%@ %@",_startDate,hms]];
    }else startDateHMS = [startDate2Formatter dateFromString:_startDate2Str];
    
    //转换成秒
    if ([_ToDateStr hasSuffix:@"天"]) {
        _ToDateStr=[[_ToDateStr componentsSeparatedByString:@"天"] firstObject] ;
        _ToDateStr = [NSString stringWithFormat:@"%d",_ToDateStr.intValue*24*60*60];
        NSLog(@"_ToDateStr天  %@",_ToDateStr);
    }else if([_ToDateStr componentsSeparatedByString:@":"].count>1){
        NSArray *arr=[_ToDateStr componentsSeparatedByString:@":"];
        int a = [arr[0] intValue]*60 +[arr[1]intValue];
        _ToDateStr=[NSString stringWithFormat:@"%d",a*60];
        NSLog(@"_ToDateStr:  %@",_ToDateStr);
    }
    if (!_startDateMinDate) {
        _startDateMinDate = [startDate2 addTimeInterval:_ToDateStr.intValue];
    }
    NSLog(@"_startDateMinDate:  %@",_startDateMinDate);
    //date头
    {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        headView.backgroundColor = [UIColor whiteColor];
        headDateLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 320, 30)];
        NSDate* tempDate = [NSDate date];
        headDateLab.text = [self returnFormatterDateString:tempDate];//
        NSLog(@"headDateLat.text:%@",headDateLab.text);
        headDateLab.font = [UIFont systemFontOfSize:15];
        headDateLab.textColor = BLUE_SKY_COLOR;
        headDateLab.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:headDateLab];
        
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 11, 20, 20)];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"(日历)03"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(moveCalendarToPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:leftBtn];
        
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(290, 11, 20, 20)];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"(日历)05"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(touchChangeNextMonth) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:rightBtn];
        [self.view addSubview:headView];
        
    }
    
    cellWide = 320.0/ 7;
    
    //week
    {
        NSArray *weekArrs = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
        for (int i=0; i<7; i++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(i*(cellWide), 44, cellWide, 26.5)];
            lab.text = weekArrs[i];
            [lab setFont:[UIFont systemFontOfSize:11]];
            lab.layer.borderWidth = .3;
            lab.layer.borderColor = [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1].CGColor;
            lab.textAlignment = NSTextAlignmentCenter;
            lab.textColor = [UIColor grayColor];
            //lab.backgroundColor = BLACK_VIEW_COLOR;
            [self.view addSubview:lab];
            
        }
    }
    //下bar
    [self addBottomBar];
    
    //days
    dayArrs = [NSMutableArray array];
    selectDays = [NSMutableArray array];
    
    
    
    //日历数据
    currutDate = [startDate2Formatter dateFromString:_startDate2Str];
    
    //初始化日历类，并设置日历类的格式是阳历 若想设置中国日历 设置为NSChineseCalendar
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //设置每周的第一天从星期几开始  设置为 1 是周日，2是周一
    [_calendar setFirstWeekday:1];
    //[_calendar setLocale:[NSLocale currentLocale]];
    //设置每个月或者每年的第一周必须包含的最少天数  设置为1 就是第一周至少要有一天
    [_calendar setMinimumDaysInFirstWeek:1];
    //设置时区，不设置时区获取月的第一天和星期的第一天的时候可能会提前一天。
    [_calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //计算绘制日历需要的数据，我传入当前日期  输入月份或年不同的日期就能得到不同的日历。
    NSLog(@"currutDate  %@",currutDate);
    if (!_checkDate) {
        if ([startDateHMS compare:currutDate]==NSOrderedAscending) {
            NSLog(@"currutDate1 %@",currutDate);
        }else {
            currutDate = startDateHMS;
            NSLog(@"startDateHMS %@",startDateHMS);
            NSLog(@"_ProdType %d",_ProdType.intValue);
            NSLog(@"_startDate %@",_startDate);
            NSLog(@"currutDate2 %@",currutDate);
        }
    }else if (_checkDate)  {
        currutDate = _checkDate;
        NSLog(@"currutDate3 %@",currutDate);
    }
    
    //[self calendarSetDate:currutDate];
    
    
    //headDateLab.text = [self returnFormatterDateString:currutDate];
    
}
- (void)addBottomBar{
    UIImageView*guding=[[UIImageView alloc]initWithFrame:CGRectMake(0,  DeviceHeight-64-45, 320, 45)];
    //    guding.alpha=0.8;
    guding.userInteractionEnabled=YES;
    guding.image=[UIImage imageNamed:@"guding.png"];
    [self.view addSubview:guding];
    //价格和预订
    
    price=[[RTLabel alloc]initWithFrame:CGRectMake(10, 10, 150, 25)];
    price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",_RMB,_dollar];
    price.hidden = YES;
    price.font = [UIFont systemFontOfSize:13.5];
    [guding addSubview:price];
    
    //预订按钮////////////////////////////////////
    orderButton=[UIButton buttonWithType:UIButtonTypeCustom];
    orderButton.layer.cornerRadius=4;
    orderButton.titleLabel.font = [UIFont systemFontOfSize:13.5];
    orderButton.frame=CGRectMake(240,10, 72.5, 25);
    //orderButton.tag = [[dataArray[index] objectForKey:@"ID"] integerValue];
    orderButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"14"]];
    [orderButton addTarget:self action:@selector(goAffirmDate) forControlEvents:UIControlEventTouchUpInside];
    [orderButton setTitle:@"确定" forState:UIControlStateNormal];
    orderButton.enabled=NO;
    [guding addSubview:orderButton];
}
- (void)goAffirmDate{
    if ([self.title isEqualToString:@"订票日期"]) {
        if (_isLookStr) {
            
            SceneryReceverClass *src = [SceneryReceverClass new];
            src.ID=[NSString stringWithFormat:@"%@",_ID];
            src.title = @"景点门票预订";
            src.russianStr = [_dataDicHead valueForKey:@"ViewRUName"];
            src.chineseStr  = [_dataDicHead valueForKey:@"ViewCNName"];
            src.ProdType = _ProdType;
            NSString *Ftitle=@"";
            
            if ([[_dataDic valueForKey:@"Ftitle"] length]>0) {
                Ftitle = [NSString stringWithFormat:@"-%@",[_dataDic valueForKey:@"Ftitle"]];
            }
            NSString *head = [NSString stringWithFormat:@"%@%@",[_dataDic valueForKey:@"ViewName"],Ftitle];
            src.roomTypeStr = head;
            src.payWay =[_dataDic valueForKey:@"OrderType"];
            src.showTime = [NSString stringWithFormat:@"%@",[_dataDicHead valueForKey:@"ShowTime"]];
            src.reseverKnowStr = [_dataDic objectForKey:@"OrderNote"];
            src.roomFacilityStr = [_dataDic valueForKey:@"Other"];
            src.startDate=[_dataDic valueForKey:@"StarTime"];
            src.endDate=[_dataDic valueForKey:@"EndTime"];
            src.checkDate = _checkDate;
            src.RMB = _RMB;
            //src.check_outDate = [self moveCalendarToDayMonth:_checkDate];
            src.dollar = _dollar;
            src.ToDateStr = _ToDateStr;
            src.startDate2Str = _startDate2Str;
            src.startDateMinDate=_startDateMinDate;
            [self.navigationController pushViewController:src animated:NO];
            return;
        }
        SceneryReceverClass *room = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
        room.checkDate = _checkDate;
        room.RMB = _RMB;
        // room.check_outDate = [self moveCalendarToDayMonth:_checkDate];
        room.dollar = _dollar;
        [self.navigationController popToViewController:room animated:NO];
        
    }else{
        //酒店预订
        if (_isLookStr) {
            
            RoomReseverClass * rrc = [RoomReseverClass new];
            if (_isInOrOut.intValue==1) {
                //room.check_outDate = [(DateButton*)selectDays[0] getDate];
                rrc.dayCount = _dayCount;
                rrc.check_outDate=_check_outDate;
                rrc.ID=[NSString stringWithFormat:@"%@",_ID];
                NSLog(@"%@",rrc.ID);
                
            }else {
                rrc.dayCount = @"1";
                rrc.title = @"酒店预订";
                rrc.russianStr = [_dataDicHead valueForKey:@"HotelRUName"];
                // NSLog(@"%@",[dataDic valueForKey:@"HotelRUName"]);
                rrc.chineseStr  = [_dataDicHead valueForKey:@"HotelCNName"];
                rrc.ProdType = _ProdType;
                rrc.ID=[NSString stringWithFormat:@"%@",_ID];
                NSString *Ftitle=@"";
                
                if ([[_dataDic valueForKey:@"Ftitle"] length]>0) {
                    Ftitle = [NSString stringWithFormat:@"-%@",[_dataDic valueForKey:@"Ftitle"]];
                }
                // NSLog(@"Ftitle %@",[NSString stringWithFormat:@"%@%@",_name,Ftitle]);
                rrc.ID=[NSString stringWithFormat:@"%@",_ID];
                NSString *head = [NSString stringWithFormat:@"%@%@",[_dataDic valueForKey:@"RoomName"],Ftitle];
                rrc.roomTypeStr = head;
                rrc.payWay =[_dataDic valueForKey:@"OrderType"];
                rrc.peopleMaxCountStr = [NSString stringWithFormat:@"%@人",[_dataDic  objectForKey:@"MoneyType"]];
                rrc.reseverKnowStr = [_dataDic objectForKey:@"OrderNote"];
                rrc.roomFacilityStr = [_dataDic valueForKey:@"Other"];
                rrc.RMB = [_dataDic valueForKey:@"ZPrice"];
                rrc.dollar = [_dataDic objectForKey:@"Price"];
                rrc.startDate=[_dataDic valueForKey:@"StartDate"];
                rrc.endDate=[_dataDic valueForKey:@"EndDate"];
                rrc.checkDate = _checkDate;
                rrc.RMB = _RMB;
                rrc.check_outDate = [self moveCalendarToDayMonth:_checkDate];
                rrc.dollar = _dollar;
                rrc.ToDateStr = _ToDateStr;
                rrc.startDate2Str = _startDate2Str;
                rrc.startDateMinDate=_startDateMinDate;
            }
            
            [self.navigationController pushViewController:rrc animated:NO];
            return;
            
        }
        RoomReseverClass *room = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
        if (_isInOrOut.intValue==1) {
            //room.check_outDate = [(DateButton*)selectDays[0] getDate];
            room.dayCount = _dayCount;
            room.check_outDate=_check_outDate;
        }else {
            
            room.checkDate = _checkDate;
            room.RMB = _RMB;
            room.check_outDate = [self moveCalendarToDayMonth:_checkDate];
            room.dollar = _dollar;
            
        }
        room.ID=[NSString stringWithFormat:@"%@",_ID];
        
        [self.navigationController popToViewController:room animated:NO];
    }
    
}
//返回下一天
- (NSDate*)moveCalendarToDayMonth:(NSDate*)intoDate{
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setDay:1];
    NSDate *date = [self.calendar dateByAddingComponents:comps toDate:intoDate options:0];
    return date;
}


- (void)touchChangeNextMonth{
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setMonth:1];
    [self calendarSetDate:[self moveCalendarToNextMonth]];
    headDateLab.text   = [self returnFormatterDateString:currutDate];
}
- (NSDate*)moveCalendarToNextMonth {
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setMonth:1];
    currutDate = [self.calendar dateByAddingComponents:comps toDate:currutDate options:0];
    return currutDate;
}

- (void)moveCalendarToPreviousMonth {
    currutDate = [[self DayOfMonthContainingDate:currutDate setDay:1] dateByAddingTimeInterval:-100000];
    [self calendarSetDate:currutDate];
    headDateLab.text = [self returnFormatterDateString:currutDate];
}


//返回日期
- (NSDate *)DayOfMonthContainingDate:(NSDate *)date setDay:(int)day{
    
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
    [comps setDay:day];
    [comps setHour:[hmsArr[0] intValue]];
    [comps setMinute:[hmsArr[1]intValue]];
    [comps setSecond:[hmsArr[2] intValue]];
    // NSLog(@"dateFromComponents %@",[self.calendar dateFromComponents:comps]);
    return [self.calendar dateFromComponents:comps];
    
}


-(void)calendarSetDate:(NSDate *)date
{
    
    if (dayArrs.count>0) {
        for (UIButton *btn in dayArrs) {
            [btn removeFromSuperview];
            //[dayArrs removeObject:btn];
        }
        [dayArrs removeAllObjects];
    }
    
    //获取date所在的月的天数，即monthRange的length
    monthRange = [_calendar rangeOfUnit:NSDayCalendarUnit
                                 inUnit:NSMonthCalendarUnit
                                forDate:date];
    //NSLog(@"monthRange:%d,%d",monthRange.location,monthRange.length);
    //获取date在其所在的月份里的位置
    currentDayIndexOfMonth = [_calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date]  ;
    //NSLog(@"currentIndex:%d",currentDayIndexOfMonth);
    
    NSTimeInterval interval;
    NSDate *firstDayOfMonth;
    //如果firstDayOfMonth和interval可计算，下边这个方法会返回YES，并且由firstDayOfMonth可得到date所在的设置的时间段（NSMonthCalendarUnit）里的第一天
    if ([_calendar rangeOfUnit: NSMonthCalendarUnit startDate:&firstDayOfMonth interval:&interval forDate:date])
    {
        NSLog(@"%@",firstDayOfMonth);
        NSLog(@"%f",interval);
    }
    //获取date所在月的第一天在其所在周的位置，即第几天。
    firstDayIndexOfWeek = [_calendar ordinalityOfUnit:NSDayCalendarUnit
                                               inUnit:NSWeekCalendarUnit
                                              forDate:firstDayOfMonth];
    //画按钮
    [self drawBtn];
    
    
    
}

-(void)drawBtn
{
    //NSLog(@"%@",dataArrs);
    
    NSDate *taday = [startDate2Formatter dateFromString:_startDate2Str];
    //采用系统时间
    //NSDate *taday = [NSDate date];
    // NSLog(@"formatter  %@",taday);
    //为了方便计算按钮的frame，我的i没从0开始
    for (int i = firstDayIndexOfWeek - 1 ; i < monthRange.length + firstDayIndexOfWeek -1 ; i ++)
    {
        DateButton *btn = [[DateButton alloc]init];
        btn.frame = CGRectMake( cellWide * (i%7), 26.5+44+ 45*(i/7), cellWide, 45);
        btn.tag = i + 2 - firstDayIndexOfWeek;
        btn.layer.borderWidth = .4;
        btn.layer.borderColor = [UIColor colorWithRed:217.0/255 green:217.0/255 blue:217.0/255 alpha:1].CGColor;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.date = [self DayOfMonthContainingDate:currutDate setDay:btn.tag];
        btn.dollar = _dollar;
        btn.backgroundColor = BLACK_VIEW_COLOR;
        btn.RMB = _RMB;
        btn.enabled=NO;
        [btn setTitle:[NSString stringWithFormat:@"%d",btn.tag] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [dayArrs addObject:btn];
        [self.view addSubview:btn];
        //选择日期
        if (_ProdType.intValue==2&&dayArrs.count>0) {
            for (NSDictionary *dic in dataArrs) {
                if (_isInOrOut.intValue!=1){
                    NSDate *dicDate = [startDate2Formatter dateFromString:[NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"PDate"],hms]];
                    if ([btn.date compare:dicDate]==NSOrderedSame&&[btn.date compare:_startDateMinDate]!=NSOrderedAscending)
                    {
                        NSString *day = [NSString stringWithFormat:@"%d",btn.tag];
                        NSString* money = [NSString stringWithFormat: @"\n$%@",[dic objectForKey:@"Price"]];
                        NSString* number = [NSString stringWithFormat: @"\n剩%@",[dic objectForKey:@"Number"]];
                        NSString *allStr = [NSString stringWithFormat:@"%@%@%@",day,money,number];
                        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",day,money,number]];
                        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[allStr rangeOfString:day]];
                        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[allStr rangeOfString:money]];
                        [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:[allStr rangeOfString:number]];
                        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[allStr rangeOfString:day]];
                        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:[allStr rangeOfString:money]];
                        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:[allStr rangeOfString:number]];
                        btn.dollar =[dic objectForKey:@"Price"];
                        btn.RMB =[dic objectForKey:@"RPrice"];
                        btn.surplusCount = [dic objectForKey:@"Number"];
                        btn.titleLabel.numberOfLines=0;
                        [btn setBackgroundColor:[UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1]];
                        btn.enabled=YES;
                        [btn setAttributedTitle:str forState:UIControlStateNormal];
                        btn.attributedTittleStr = str;
                        
                    }
                }
            }
        }else if (_ProdType.intValue==3){
            // NSLog(@"_startDate  %@  _endDate  %@",_startDate,_endDate);
            if (_isInOrOut.intValue==0&&(([btn.date compare:startDateHMS]==NSOrderedDescending&&[[startDate2Formatter dateFromString:[NSString stringWithFormat:@"%@ %@",_endDate,hms]] compare:btn.date]==NSOrderedDescending)||[btn.date compare:startDateHMS]==NSOrderedSame||[[startDate2Formatter dateFromString:[NSString stringWithFormat:@"%@ %@",_endDate,hms]] compare:btn.date]==NSOrderedSame)) {
                if ([btn.date compare:_startDateMinDate]!=NSOrderedAscending&&[_startDateMinDate compare:startDateHMS]!=NSOrderedAscending) {
                    [btn setBackgroundColor:[UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1]];
                    btn.enabled=YES;
                }
                
                // NSLog(@"%@",btn.date);
            }
        }else if ([btn.date compare:_startDateMinDate]!=NSOrderedAscending&&[btn.date compare:_startDateMinDate]!=NSOrderedAscending){
            if (_checkDate&&[btn.date compare:_checkDate]==NSOrderedDescending) {
                [btn setBackgroundColor:[UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1]];
                btn.enabled=YES;
            } else if (_isInOrOut.intValue==0){
                [btn setBackgroundColor:[UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1]];
                btn.enabled=YES;
            }
            //NSLog(@"%@",btn.date);
#warning changed...
        }
        [btn addTarget:self action:@selector(nslogBtnTag:)forControlEvents:UIControlEventTouchUpInside];
        
        //今天
        if ([btn.date compare:taday]==NSOrderedSame){
            btn.backgroundColor = [UIColor colorWithRed:255.0/255 green:252.0/255 blue:223.0/255 alpha:1];
        }
        
        if (_isInOrOut.intValue==1) {
            
            if (_checkDate&&[btn.date compare:_checkDate]==NSOrderedDescending) {
                btn.enabled=YES;
                [btn setBackgroundColor:[UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1]];
                
            }
            if (_checkDate&&[btn.date compare:_checkDate]==NSOrderedSame){
                btn.enabled=YES;
                btn.titleLabel.numberOfLines=0;
                [btn setAttributedTitle:[self returnAttributrTittleStr:@"0" tag:btn.tag dollar:btn.dollar] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor colorWithRed:175.0/255 green:219.0/255 blue:1 alpha:1];
                btn.enabled=NO;
                
            }
            if(_check_outDate&&[btn.date compare:_check_outDate]==NSOrderedSame){
                // NSLog(@"_check_outDate %@",_check_outDate);
                btn.backgroundColor = [UIColor colorWithRed:175.0/255 green:219.0/255 blue:1 alpha:1];
                btn.enabled=YES;
                btn.titleLabel.numberOfLines=0;
                [btn setAttributedTitle:[self returnAttributrTittleStr:_isInOrOut tag:btn.tag dollar:btn.dollar] forState:UIControlStateNormal];
                _RMB=btn.RMB;
                _dollar=btn.dollar;
                price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%d</font><font color=white>（$%d)</font>",_RMB.intValue*[_dayCount intValue],_dollar.intValue*[_dayCount intValue]];
                price.hidden=NO;
                [selectDays addObject:btn];
            }
            
        }else{
            if (_checkDate&&[btn.date compare:_checkDate]==NSOrderedSame){
                price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%d</font><font color=white>（$%d)</font>",_RMB.intValue,_dollar.intValue];
                price.hidden=NO;
                btn.backgroundColor = [UIColor colorWithRed:175.0/255 green:219.0/255 blue:1 alpha:1];
                
                btn.titleLabel.numberOfLines=0;
                if ([self.title isEqualToString:@"入住日期"]) {
                    [btn setAttributedTitle:[self returnAttributrTittleStr:@"0" tag:btn.tag dollar:btn.dollar] forState:UIControlStateNormal];
                }
                
                
                [selectDays addObject:btn];
            }
        }
        if (_ProdType.intValue == 4 && (date1Arr.count != 0 || date2Arr.count != 0))
        {
            if (_isInOrOut.intValue==0)
            {
                if (btn.tag == 22)
                {
                    btn.backgroundColor = [UIColor redColor];
                    btn.enabled=NO;
                }
            }
        }

    }
    
}
//- (BOOL)dateIsSameOneDay:(NSDate *)date1 andTwoDay:(NSDate*)date2 andProdType:(NSString*)ProdType  andBtnDate:(NSDate*)btnDate{
//    NSDateComponents *firstDay = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date1];
//    NSDateComponents *twiceDay = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date2];
//
//    return ([firstDay day] == [twiceDay day] &&
//            [firstDay month] == [twiceDay month] &&
//            [firstDay year] == [twiceDay year] &&
//            [firstDay era] == [twiceDay era]);
//}
-(void)nslogBtnTag:(DateButton *)btn
{
    
    if (selectDays.count>0) {
        for (DateButton *selectBtn in selectDays) {
            if ([selectBtn.date compare:[startDate2Formatter dateFromString:_startDate2Str]]==NSOrderedSame) {
                selectBtn.backgroundColor = [UIColor colorWithRed:255.0/255 green:252.0/255 blue:223.0/255 alpha:1];
            }else selectBtn.backgroundColor = [UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1];
            
            if (_ProdType.intValue==2) {
                [selectBtn setAttributedTitle:selectBtn.attributedTittleStr forState:UIControlStateNormal];
            }else [selectBtn setAttributedTitle:nil forState:UIControlStateNormal];
        }
        [selectDays removeAllObjects];
    }
    
    if (_isInOrOut.intValue==1) {
        
        NSTimeInterval secend = [btn.date timeIntervalSinceDate:_checkDate];
        _dayCount = [NSString stringWithFormat:@"%f",secend/(24*60*60)];
        price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%d</font><font color=white>（$%d)</font>",_RMB.intValue*[_dayCount intValue],_dollar.intValue*[_dayCount intValue]];
        _check_outDate=btn.date;
        
        
    }else {
        
        price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%@</font><font color=white>（$%@)</font>",btn.RMB,btn.dollar];
        _checkDate=btn.date;
        _RMB=btn.RMB;
        _dollar=btn.dollar;
        
    }
    btn.titleLabel.numberOfLines=0;
    if ([self.title isEqualToString:@"退房日期"]||[self.title isEqualToString:@"入住日期"]) {
        [btn setAttributedTitle:[self returnAttributrTittleStr:_isInOrOut tag:btn.tag dollar:btn.dollar]forState:UIControlStateNormal];
    }
    
    price.hidden=NO;
    orderButton.enabled=YES;
    orderButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"13"]];
    btn.backgroundColor = [UIColor colorWithRed:175.0/255 green:219.0/255 blue:1 alpha:1];
    [selectDays addObject:btn];
}
- (NSAttributedString*)returnAttributrTittleStr:(NSString*)type tag:(int)tag dollar:(NSString*)count{
    NSString *day = [NSString stringWithFormat:@"%d",tag];
    NSString *money = [NSString stringWithFormat: @"\n$%@",count];
    
    NSString *in_out;//=  @"\n离开";
    if (type.intValue==1) {
        in_out =  @"\n离开";
    }else in_out = @"\n入住";
    //NSString *number = [NSString stringWithFormat: @"\n剩%@",[dic objectForKey:@"Number"]];
    NSString *allStr = [NSString stringWithFormat:@"%@%@%@",day,money,in_out];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",day,money,in_out]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[allStr rangeOfString:day]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[allStr rangeOfString:money]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:34/255.0 green:145/255.0 blue:210/255.0 alpha:1] range:[allStr rangeOfString:in_out]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[allStr rangeOfString:day]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:[allStr rangeOfString:money]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:[allStr rangeOfString:in_out]];
    
    return str;
}

#pragma mark - Calendar helpers
- (NSString *)returnFormatterDateString:(NSDate*)date{
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"YYYY年MM月"];
    return [formatter2 stringFromDate:date];
}
@end
