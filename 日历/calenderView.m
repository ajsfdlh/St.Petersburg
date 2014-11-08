//
//  calenderView.m
//  rili
//
//  Created by beginner on 14-10-13.
//  Copyright (c) 2014年 beginner. All rights reserved.
//

#import "calenderView.h"
#define GColor [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]
#define RGColor [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]
#define GaryCo [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1]


@interface calenderView()
{
    
    NSCalendar *gregorian;
    NSInteger _selectedMonth;
    NSInteger _selectedYear;
    NSInteger _selectedDate;
    NSArray *_weekNames;

}
@end

@implementation calenderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)clickON
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.month -= 1;
        self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.2f
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ {[self setNeedsDisplay];}//重绘视图
                    completion:^
     (BOOL finished){
        [self.CVC tappedDate:nil];
        [self.HCVC tappedDate:nil];
        [self.GCCVC tappedDate:nil];
    }];
}

- (void)NEXT
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    components.month += 1;
    self.calendarDate = [gregorian dateFromComponents:components];
    [UIView transitionWithView:self
                      duration:0.2f
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setNeedsDisplay]; }
                    completion:^
     (BOOL finished) {
         [self.CVC tappedDate:nil];
         [self.HCVC tappedDate:nil];
         [self.GCCVC tappedDate:nil];
     }];
}

//static bool flag = NO;
- (void)drawRect:(CGRect)rect
{
    [self setCalendarParameters];
    
    _weekNames = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSCalendarUnitHour) fromDate:self.calendarDate];
//    NSLog(@"%@",components);
//    if (flag == NO)
//    {
//        components.month = 1;
//        self.calendarDate = [gregorian dateFromComponents:components];
//        flag = YES;
//    }
    self.month = components.month;
    self.year = components.year;
    self.day = components.day;
    components.day = 0;
//    NSLog(@"%d",self.week);
//    NSLog(@"%d",self.month);
//    NSLog(@"%d",self.year);
    NSDate *firstDayOfMonth = [gregorian dateFromComponents:components];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    int weekday = [comps weekday];
//    NSLog(@"%d",weekday);
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.calendarDate];
    
    NSInteger columns = 7;
    double width = (double)320/7;
    NSInteger originY = 40;
    NSInteger monthLength = days.length;
    
    
#pragma -mark 年月
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
    titleText.textAlignment = NSTextAlignmentCenter;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"y年M月"];
    NSString *dateString = [format stringFromDate:self.calendarDate];
    [titleText setText:dateString];
    [titleText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]];
    [titleText setTextColor:[UIColor blueColor]];
    [self addSubview:titleText];
    
#pragma -mark Onbutton and nextButton
    UIButton *OnButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    [OnButton setImage:[UIImage imageNamed:@"(日历)03.png"] forState:UIControlStateNormal];
    UIButton *OB = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [OB addTarget:self action:@selector(clickON) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:OB];
    [self addSubview:OnButton];
    
    
    UIButton *nextButton = [[UIButton alloc]initWithFrame:CGRectMake(320 - 10 - 15, 10, 15, 15)];
    [nextButton setImage:[UIImage imageNamed:@"(日历)05.png"] forState:UIControlStateNormal];
    UIButton *NB = [[UIButton alloc]initWithFrame:CGRectMake(320 - 40, 5, 40, 40)];
    [NB addTarget:self action:@selector(NEXT) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:NB];
    [self addSubview:nextButton];
    
    
#pragma - mark 日期
    for (int i = 0; i< _weekNames.count; i ++)
    {
        UIButton *weekNameLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        weekNameLabel.backgroundColor = RGColor;
        [weekNameLabel setTitle:[_weekNames objectAtIndex:i] forState:UIControlStateNormal];
        [weekNameLabel setFrame:CGRectMake((width*(i%columns)), originY, width, 20)];
        [weekNameLabel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [weekNameLabel.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
        weekNameLabel.userInteractionEnabled = NO;
        [self addSubview:weekNameLabel];
    }
    if (weekday == 7)
    {
        weekday =0;
    }

    for (NSInteger i= 0; i<monthLength; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([self.GCCVC.guideType integerValue] == 1)
        {
            button.backgroundColor = GaryCo;
            button.userInteractionEnabled = NO;
        }
        else if (_selectedYear > self.year)
        {
            button.backgroundColor = GaryCo;
        }
//        else if (_selectedYear == self.year &&_selectedMonth == self.month && _selectedDate == i + 1)
//        {
//            button.backgroundColor = [UIColor orangeColor];
//        }
        else if (_selectedYear == self.year && _selectedMonth > self.month)
        {
            button.backgroundColor = GaryCo;
        }
        else if (_selectedYear == self.year &&_selectedMonth == self.month && _selectedDate >= i + 2)
        {
            button.backgroundColor = GaryCo;
        }
        else
        {
            if ([self.HCVC.prodType integerValue] == 2 || [self.HCVC.prodType integerValue] == 3 || [self.HCVC.prodType integerValue] == 1|| [self.HCVC.prodType integerValue] == 4)
            {
                button.backgroundColor = GaryCo;
            }
            else
            {
                button.backgroundColor = GColor;
            }
            if (_selectedYear == self.year &&_selectedMonth == self.month && _selectedDate == i + 1)
            {
                button.backgroundColor = GaryCo;
            }
        }
        button.tag = i+1;
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
        if (self.CVC != nil)
        {
            [self addBtnTargetWithCalerderView:self.CVC andButton:button];
        }
        else if(self.HCVC != nil)
        {
            [self addBtnTargetWithCalerderView:self.HCVC andButton:button];
        }
        else if(self.GCCVC != nil)
        {
            [self addBtnTargetWithCalerderView:self.GCCVC andButton:button];
        }
        self.HCVC.lastDay = monthLength;
        [button setFrame:CGRectMake(width *((i+weekday)%columns), originY+20+width *((i+weekday)/columns), width, width)];
        [self addSubview:button];
    }

    
#pragma -mark 上个月的日子
    components.month -=1;
    NSDate *previousMonthDate = [gregorian dateFromComponents:components];
    NSRange previousMonthDays = [c rangeOfUnit:NSDayCalendarUnit
                                        inUnit:NSMonthCalendarUnit
                                       forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekday;

    
    for (int i=0; i<weekday; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.text = [NSString stringWithFormat:@"%d",maxDate+i+1];
        [button setTitle:[NSString stringWithFormat:@"%d",maxDate+i+1] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(width*(i%columns), originY+20+width *(i/columns), width, width)];
        [button setTitleColor:[UIColor colorWithRed:229.0/255.0 green:231.0/255.0 blue:233.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
        [button setEnabled:NO];
        [self addSubview:button];
    }
    
#pragma -mark 下个月的日子
    NSInteger remainingDays = (monthLength + weekday) % columns;
    if (remainingDays == 0)
    {
        monthLength -= 7;
    }
    if(remainingDays >0)
    {
        for (int i=remainingDays; i<columns; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.text = [NSString stringWithFormat:@"%d",(i+1)-remainingDays];
            [button setTitle:[NSString stringWithFormat:@"%d",(i+1)-remainingDays] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(width*((i) %columns), originY+20+width *((monthLength+weekday)/columns), width, width)];
            UIView *columnView = [[UIView alloc]init];
            [columnView setBackgroundColor:[UIColor grayColor]];
            [button setTitleColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0f]];
            [button setEnabled:NO];
            [self addSubview:button];
            
        }
    }
        
#pragma -mark 加粗边缘
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    [lineView setFrame:CGRectMake(0, originY, 320, 0.5)];
    [self addSubview:lineView];
    
    for (int i = 0; i<columns + 1; i ++)
    {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        [lineView setFrame:CGRectMake(width*(i%columns), originY, 0.5, 20 + width *(int)(((monthLength+weekday)/columns) + 1))];
        
        [self addSubview:lineView];
    }
    
    if (self.CVC != nil)
    {
        self.frame = CGRectMake(0, 0, self.frame.size.width,40 + 20 + width *(int)(((monthLength+weekday)/columns) + 1));
//        NSLog(@"%@",NSStringFromCGRect(self.frame));

        self.CVC.underView.frame = CGRectMake(0, 40 + 20 + width *(int)(((monthLength+weekday)/columns) + 1), 320, 120);
//        NSLog(@"%@",NSStringFromCGRect(self.CVC.underView.frame));
        self.CVC.ScrollV.contentSize = CGSizeMake( 0 ,40 + 20 + width *(int)(((monthLength+weekday)/columns) + 1)+ 150 - 20);
    }
    if (self.HCVC != nil)
    {
        self.frame = CGRectMake(0, 0, self.frame.size.width,40 + 20 + width *(int)(((monthLength+weekday)/columns) + 1));
        
        //        NSLog(@"%@",NSStringFromCGRect(self.CVC.underView.frame));
    }
    if (self.GCCVC != nil)
    {
        self.frame = CGRectMake(0, 0, self.frame.size.width,40 + 20 + width *(int)(((monthLength+weekday)/columns) + 1));
        //        NSLog(@"%@",NSStringFromCGRect(self.frame));
        
        self.GCCVC.underView.frame = CGRectMake(0, 40 + 20 + width *(int)(((monthLength+weekday)/columns) + 1), 320, 105);
        //        NSLog(@"%@",NSStringFromCGRect(self.CVC.underView.frame));
        self.GCCVC.ScrollV.contentSize = CGSizeMake( 0 ,40 + 20 + width *(int)(((monthLength+weekday)/columns) + 1)+ 126 - 20);
    }
    for (int i = 0; i<(((monthLength+weekday)/columns) + 2); i ++)
    {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        [lineView setFrame:CGRectMake(0, originY + 20 + i *width, 320, 0.5)];
        [self addSubview:lineView];
    }
    
}


- (void)addBtnTargetWithCalerderView:(UIViewController *)calerderView andButton:(UIButton *)button
{
    if (calerderView != nil)
    {
        [button addTarget:calerderView action:@selector(tappedDate:) forControlEvents:UIControlEventTouchUpInside];
    }
}


-(void)setCalendarParameters
{
    if(gregorian == nil)
    {
        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        _selectedDate  = components.day;
        _selectedMonth = components.month;
        _selectedYear = components.year;
    }
}

- (void)GetData
{
    if (self.CVC != nil)
    {
        [self.CVC tappedDate:nil];
    }
    if (self.HCVC != nil)
    {
        [self.HCVC tappedDate:nil];
    }
    if (self.GCCVC != nil)
    {
        [self.GCCVC tappedDate:nil];
    }
}

- (void)tappedDate:(UIButton *)sender
{
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
