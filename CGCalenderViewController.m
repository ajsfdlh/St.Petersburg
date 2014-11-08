//
//  CACalenderViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-7-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "CGCalenderViewController.h"
#import "GDataXMLNode.h"
#import "CarAndGuideReseverViewController.h"
#import "JSON.h"
@implementation CGCalenderViewController
backButton
-(void)viewWillAppear:(BOOL)animated{
    //获取网络数据
    if ([self.title isEqualToString:@"选择日期"]&&_ProdType.intValue==1) {
        //
        NSLog(@"_ProdType %@  id %@",_ProdType,_ID);
        NSMutableString*str=RussiaUrl4;
        [str appendString:@"getGuideOrderdatelist"];
        NSString *argStr = [NSString stringWithFormat:@"ID=%@",_ID];
        postRequestYiBu(argStr, str)
    }
    
}
postRequestAgency(datas)
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
   // dicResultYiBu(datas, result, dic)
    dicResultYiBuNoDic(datas, result)
    
    if (result.length>0) {
        
        dataArrs = [NSMutableArray arrayWithArray:[result componentsSeparatedByString:@","]];
       // NSLog(@"dataArrs %@",dataArrs);
        currutDate = [formatter dateFromString:[NSString stringWithFormat:@"%@",dataArrs[0]]];
        NSLog(@"currutDate %@",currutDate);
        [self calendarSetDate:currutDate];
        headDateLab.text = [self returnFormatterDateString:currutDate];
    }
    
}
- (void)viewDidLoad{
   // dataArrs = [NSMutableArray array];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    
    startDate2Formatter = [[NSDateFormatter alloc] init];
    [startDate2Formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//CCD +08:00
    [startDate2Formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"_startDate2Str:  %@",_startDate2Str);
    
    today = [formatter dateFromString:[_startDate2Str substringToIndex:10]];
    NSLog(@"today  %@",today);


    //date头
    {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        headView.backgroundColor = [UIColor whiteColor];
        headDateLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 320, 30)];
        headDateLab.text = [self returnFormatterDateString:[NSDate date]];
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
    
    
    //备注图
    //26.5+44+ 45*(i/7
    {
        sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 26.5+44, 320, self.view.frame.size.height-26.5-40-49-64)];
        [self.view addSubview:sv];
        NSArray *colorArr = @[BLACK_VIEW_COLOR,[UIColor colorWithRed:134.0/255 green:206.0/255 blue:255.0/255 alpha:1],[UIColor colorWithRed:255.0/255 green:115.0/255 blue:135.0/255 alpha:1]];
        NSArray *tittleArr = @[@"不可预订",@"可预订",@"选中日期"];
        for (int i = 0; i<3; i++) {
            UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(10+80*i, 45*6+10, 15, 15)];
            colorView.backgroundColor = colorArr[i];
            [sv addSubview:colorView];
            colorView.layer.borderColor=[UIColor grayColor].CGColor;
            colorView.layer.borderWidth = .5;
            UILabel *tittleLab = [[UILabel alloc] initWithFrame:CGRectMake(30+80*i, 45*6+10, 60, 15)];
            tittleLab.text = tittleArr[i];
            //tittleLab.textColor = colorArr[i];
            tittleLab.font = [UIFont systemFontOfSize:14];
            [sv addSubview:tittleLab];
        }
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 45*6+34, 16, 16)];
        iv.image = [UIImage imageNamed:@"预订须知"];
        [sv addSubview:iv];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(30,  45*6+35, 50, 16)];
        name.font = [UIFont systemFontOfSize:16];
        name.text = @"注意";
        [sv addSubview:name];
        
        UILabel *name2 = [[UILabel alloc] initWithFrame:CGRectMake(10,  45*6+51, 300, 50)];
        name2.font = [UIFont systemFontOfSize:14];
        name2.numberOfLines=2;
        name2.lineBreakMode = UILineBreakModeWordWrap;
        name2.text = @"每个订单最多可预订8天;如果预订不相连的多个日期,间隔不能超过3天";
        
        [sv addSubview:name2];
        sv.contentSize = CGSizeMake(320, 45*6+100);
    }
    //下bar
    [self addBottomBar];
    
    //days
    dayArrs = [NSMutableArray array];
    if (!_selectDays) {
        _selectDays = [NSMutableArray new];
    }
    
    
    
    
    //日历数据
    currutDate = today;
    
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

    if (_ProdType.intValue==2) {
        [self calendarSetDate:currutDate];
        headDateLab.text = [self returnFormatterDateString:currutDate];
    }
    
    
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
    
    if ([self.title isEqualToString:@"选择日期"]) {
      
        CarAndGuideReseverViewController *room = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
        room.selectDays = _selectDays;
        room.RMB = _RMB;
        // room.check_outDate = [self moveCalendarToDayMonth:_checkDate];
        room.dollar = _dollar;
        [self.navigationController popToViewController:room animated:NO];
        
    }
}
//返回下一天
//- (NSDate*)moveCalendarToDayMonth:(NSDate*)intoDate{
//    NSDateComponents* comps = [[NSDateComponents alloc]init];
//    [comps setDay:1];
//    NSDate *date = [self.calendar dateByAddingComponents:comps toDate:intoDate options:0];
//    return date;
//}


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
    
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:day];
//    [comps setHour:[hmsArr[0] intValue]];
//    [comps setMinute:[hmsArr[1]intValue]];
//    [comps setSecond:[hmsArr[2] intValue]];
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
    currentDayIndexOfMonth = [_calendar ordinalityOfUnit:NSDayCalendarUnit
                                                  inUnit:NSMonthCalendarUnit
                                                 forDate:date]  ;
    //NSLog(@"currentIndex:%d",currentDayIndexOfMonth);
    
    NSTimeInterval interval;
    NSDate *firstDayOfMonth;
    //如果firstDayOfMonth和interval可计算，下边这个方法会返回YES，并且由firstDayOfMonth可得到date所在的设置的时间段（NSMonthCalendarUnit）里的第一天
    if ([_calendar rangeOfUnit: NSMonthCalendarUnit startDate:&firstDayOfMonth interval:&interval forDate:date])
    {
        NSLog(@"firstDayOfMonth %@",firstDayOfMonth);
        NSLog(@"interval %f",interval);
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
    
    
    //采用系统时间
    //NSDate *taday = [NSDate date];
    // NSLog(@"formatter  %@",taday);
    //为了方便计算按钮的frame，我的i没从0开始
    for (int i = firstDayIndexOfWeek - 1 ; i < monthRange.length + firstDayIndexOfWeek -1 ; i ++)
    {
        DateButton *btn = [[DateButton alloc]init];
        btn.frame = CGRectMake( cellWide * (i%7), 45*(i/7), cellWide, 45);
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
        [sv addSubview:btn];
         //今天
        if ([btn.date compare:today]==NSOrderedSame){
            btn.backgroundColor = [UIColor colorWithRed:255.0/255 green:252.0/255 blue:223.0/255 alpha:1];
        }
        if (dataArrs.count>0&&_ProdType.intValue==1) {
            for (NSString *freeDateStr in dataArrs) {
                
                if ([btn.date compare:[formatter dateFromString:freeDateStr]]==NSOrderedSame){
                    
                    if ([btn.date compare:today]==NSOrderedSame){
                        
                        btn.backgroundColor = [UIColor colorWithRed:255.0/255 green:252.0/255 blue:223.0/255 alpha:1];
                       
                    }else {
                        //蓝色
                        [btn setTitleColor:[UIColor colorWithRed:0 green:113.0/255 blue:165.0/255 alpha:1] forState:UIControlStateNormal];
                        [btn setBackgroundColor:[UIColor colorWithRed:134.0/255 green:206.0/255 blue:255.0/255 alpha:1]];
                        btn.enabled=YES;
                        [btn addTarget:self action:@selector(nslogBtnTag:)forControlEvents:UIControlEventTouchUpInside];
                        
                    }
                }
               
               
            }
        }else if (_ProdType.intValue==2){
            if ([btn.date compare:today]==NSOrderedDescending) {
                //蓝色
                [btn setTitleColor:[UIColor colorWithRed:0 green:113.0/255 blue:165.0/255 alpha:1] forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor colorWithRed:134.0/255 green:206.0/255 blue:255.0/255 alpha:1]];
                btn.enabled=YES;
                [btn addTarget:self action:@selector(nslogBtnTag:)forControlEvents:UIControlEventTouchUpInside];
            }
            
                    
            
            
        }
       
       
        if (_selectDays.count>0) {
            for (NSDate *selectDate in _selectDays) {
                if ([btn.date compare:selectDate]==NSOrderedSame){
                    [btn setTitleColor:[UIColor colorWithRed:191.0/255 green:0 blue:27.0/255 alpha:1] forState:UIControlStateNormal];
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255 green:115.0/255 blue:135.0/255 alpha:1];
                    btn.enabled = YES;
                }
            }
        }
        
    }
}

-(void)nslogBtnTag:(DateButton *)btn
{
    
    _addDays = [NSMutableArray array];
    _removerDays= [NSMutableArray array];

    if (_selectDays.count) {
        
        NSLog(@"btn  %@  ",btn.date);
        for (NSDate *selectDate  in _selectDays) {
            
            if ([selectDate compare:btn.date]==NSOrderedSame) {
                
                [btn setTitleColor:[UIColor colorWithRed:0 green:113.0/255 blue:165.0/255 alpha:1] forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor colorWithRed:134.0/255 green:206.0/255 blue:255.0/255 alpha:1]];
                [_removerDays addObject:selectDate];
                
            }else if (_addDays.count==0&&_selectDays.count<8){
                
                //红色
                [btn setTitleColor:[UIColor colorWithRed:191.0/255 green:0 blue:27.0/255 alpha:1] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor colorWithRed:255.0/255 green:115.0/255 blue:135.0/255 alpha:1];
                [_addDays addObject:btn.date];
                
            }
        }
        
    }else{
        
        [btn setTitleColor:[UIColor colorWithRed:191.0/255 green:0 blue:27.0/255 alpha:1] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:255.0/255 green:115.0/255 blue:135.0/255 alpha:1];
        [_addDays addObject:btn.date];
        
    }
    

    //NSLog(@"[_selectDays sortedArrayUsingSelector:@selector(compare:)]  %@",[_selectDays sortedArrayUsingSelector:@selector(compare:)]);
    if (_removerDays.count) {
        
        [_selectDays removeObject:_removerDays[0]];
        
    }else if (_addDays.count&&_selectDays.count<8){
        
        [_selectDays addObjectsFromArray:_addDays];
        
    }else if (_selectDays.count>7) {
        
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"最多可预订8天" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [av show];
        return;
        
    }
    //判断间隔天数
    if (_selectDays.count>0) {
        NSArray *compareArr = [_selectDays sortedArrayUsingSelector:@selector(compare:)];
        for (int i = 0; i < compareArr.count; i++) {
            
            if (i+1<compareArr.count&&[[compareArr[i] addTimeInterval:3*24*60*60] compare:compareArr[i+1]]==NSOrderedAscending) {
                if (_removerDays.count) {
                    
                    //红色
                    [btn setTitleColor:[UIColor colorWithRed:191.0/255 green:0 blue:27.0/255 alpha:1] forState:UIControlStateNormal];
                    btn.backgroundColor = [UIColor colorWithRed:255.0/255 green:115.0/255 blue:135.0/255 alpha:1];
                    [_selectDays addObjectsFromArray:_removerDays];
                    
                }else if (_addDays.count&&_selectDays.count<8){
                    [btn setTitleColor:[UIColor colorWithRed:0 green:113.0/255 blue:165.0/255 alpha:1] forState:UIControlStateNormal];
                    [btn setBackgroundColor:[UIColor colorWithRed:134.0/255 green:206.0/255 blue:255.0/255 alpha:1]];
                    [_selectDays removeObject:_addDays[0]];
                }
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"最多间隔为3天" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [av show];
                return;
                
            }
        }
    }

    price.text=[NSString stringWithFormat: @"<font size=20 color=orange >￥%d</font><font color=white>（$%d)</font>",[btn.RMB intValue]*_selectDays.count,[btn.dollar intValue]*_selectDays.count];
    //_checkDate=btn.date;
    _RMB=btn.RMB;
    _dollar=btn.dollar;
    
    price.hidden=NO;
    orderButton.enabled=YES;
    orderButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"13"]];
    NSLog(@"_selectDays %@",_selectDays);
    
}


#pragma mark - Calendar helpers
- (NSString *)returnFormatterDateString:(NSDate*)date{
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    [formatter2 setDateFormat:@"YYYY年MM月"];
    return [formatter2 stringFromDate:date];
}
@end
