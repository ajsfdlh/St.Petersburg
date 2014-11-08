//
//  LineViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-25.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "LineViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
#import <QuartzCore/QuartzCore.h>
//#import "NSData+MBBase64.h"
#import "Data.h"
@interface LineViewController ()

@end

@implementation LineViewController

backButton
-(void)viewDidDisappear:(BOOL)animated
{
    [navActivity removeFromSuperview];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    hideTabbar
    if (_collectID == 0) {
        [self.navigationItem setNewTitle:@"线路列表"];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
}
NetChange(noNetButton)
-(void)endRefresh:(UIRefreshControl*)_refresh
{
    
    if (_refresh.refreshing)
    {
        
        //时间的格式化输出，你还记得吗？自己看了吗？
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d,h:mm:ss a"];
        [_refresh endRefreshing];
    }
    
    
}
postRequestAgencyAndRefeshAndAlert(datas, refresh, remindAlert,navActivity)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    dicResultYiBu(datas, result, dic)
    [navActivity stopAnimating];
    [remindAlert dismissWithClickedButtonIndex:0 animated:YES];//取消
    NSArray*_array=[dic valueForKey:@"ds"];
    
    //    NSLog(@"datas=====%@",result);
    
    
    NSLog(@"dic====%@",dic);
    
    [self endRefresh:refresh];
    
    if (isDisplay==YES)
    {
        
        [dataForSearchArray removeAllObjects];
        if ([[[dic valueForKey:@"ds"]lastObject]valueForKey:@"PTime"])
        {
            dataForSearchArray=[dic valueForKey:@"ds"];
        }
        
        
//[searchPicArray removeAllObjects];
//        for (int i=0; i<dataForSearchArray.count; i++)
//        {
//            
//            
//            
//            
//            NSString*str=[NSString stringWithFormat:@"http://t.russia-online.cn/upload/line/%@",[[dataForSearchArray objectAtIndex:i] valueForKey:@"Pic"]] ;
//            
//            Data*_data=[Data new];
//           // [self downPic:str andData:_data andTag:[[[dataForSearchArray objectAtIndex:i]valueForKey:@"ID"] integerValue] andPath:@"" andTableView:searchDisplayC.searchResultsTableView];
//            
//            
//            [searchPicArray addObject:_data];
//            
//        }
        
        
        [searchDisplayC.searchResultsTableView reloadData];
        return;
    }
    
    
    
    if([[_array lastObject]valueForKey:@"Row"])
    {
        if (_loadingMore==NO)
        {
            
            
            [lineArray removeAllObjects];
            lineArray=[dic valueForKey:@"ds"];
//            [picArray removeAllObjects];
//            for (int i=0; i<lineArray.count; i++)
//            {
//                
//                
//                
//                NSString*str=[NSString stringWithFormat:@"http://t.russia-online.cn/upload/line/%@",[[lineArray objectAtIndex:i] valueForKey:@"Pic"]] ;
//                
//                Data*_data=[Data new];
//                [self downPic:str andData:_data andTag:[[[lineArray objectAtIndex:i]valueForKey:@"ID"] integerValue] andPath:@"line" andTableView:_tabView];
//                
//                
//                [picArray addObject:_data];
//                
//            }
            
            
            
            if (isSave==10)
            {
                [lineArray writeToFile:[self filePath:@"getTourLineList"] atomically:YES];
            }
            
            
        }

            
            if (isSave==10)
            {
                [lineArray writeToFile:[self filePath:@"getTourLineList"] atomically:YES];
            }
            
            
            
            [self  loadDataEnd:@"上拉显示更多" ];
        }
        
        
        
        
        
        
    
    else
    {
        if (_loadingMore==NO)
        {
            [lineArray removeAllObjects];
        }
        else
        {
            
            [self  loadDataEnd:@"" ];
        }
        
        
    }
    
    
    [_tabView reloadData];
    
}

- (void)hiddedFilterView{
    filterView.hidden = YES;
}
-(void)creatFilter
{
    
    filterView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 500)];
    UIImageView*imageAngel=[[UIImageView alloc]initWithFrame:CGRectMake(288, -7, 7.5, 7.5)];
    imageAngel.image=[UIImage imageNamed:@"entainmentAngel.png"];
    [filterView addSubview:imageAngel];
    
    UIView *hidView = [[UIView alloc]initWithFrame:CGRectMake(0, 361, 320, 140)];
    //hidView.backgroundColor=[UIColor colorWithWhite:1 alpha:.5];
    UITapGestureRecognizer *hiddedFilterView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddedFilterView)];
    [hidView addGestureRecognizer:hiddedFilterView];
    [filterView addSubview:hidView];
    filterView.hidden=YES;
    filterView.tag=3;
    filterView.backgroundColor=[UIColor colorWithWhite:1 alpha:.5];
    [self.view addSubview:filterView];
    
    UIImageView*leftView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 270)];
    leftView.userInteractionEnabled=YES;
    leftView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"lineGray3.png"]];
    [filterView addSubview:leftView];
    
    UIImageView*bottom=[[UIImageView alloc]initWithFrame:CGRectMake(0, 270, 320, 50)];
    bottom.userInteractionEnabled=YES;
    bottom.backgroundColor=[UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1];
    
    UIView*bottomBlue=[[UIView alloc]initWithFrame:CGRectMake(0, 46, 320, 4)];
    bottomBlue.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    [bottom addSubview:bottomBlue];
    for (int i=0; i<2; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=110+i;
        [button addTarget:self action:@selector(filter:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius=4;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame=CGRectMake(100+i*150, 10, 59, 25);
        if (i==0)
        {
            button.backgroundColor=[UIColor grayColor];
            [button setTitle:@"清空" forState:UIControlStateNormal];
        }
        if (i==1)
        {
            button.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"LineDetail_reserve.png"]];
            [button setTitle:@"确定" forState:UIControlStateNormal];
        }
        
        [bottom addSubview:button];
    }
    
    
    [filterView addSubview:bottom];
    
    
    
    array=[NSArray arrayWithObjects:@"选择类型",@"选择天数",@"价格范围", nil];
    
    
    for (int i=0; i<array.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=100+i;
        button.frame=CGRectMake(0, 0+46*i, 100, 46);
        [button addTarget:self action:@selector(tttt:) forControlEvents:UIControlEventTouchUpInside];
        [leftView addSubview:button];
        
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 46)];
        lable.tag=130+i;
        lable.text=[array objectAtIndex:i];
        lable.font=[UIFont boldSystemFontOfSize:17];
        lable.textAlignment=NSTextAlignmentCenter;
        [button addSubview:lable];
        
        if (i!=0)
        {
            [button setBackgroundImage:[UIImage imageNamed:@"leftSelect"] forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            button.backgroundColor=[UIColor whiteColor];
        }
        
        
    }
    UIImageView *rightLine = [[UIImageView alloc]initWithFrame:CGRectMake(99.5, 138, .5, 132)];
    rightLine.image = [UIImage imageNamed:@"lineGray2"];
    [leftView addSubview:rightLine];
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"filter"])
    {
        
        
    }
}
-(void)filter:(UIButton*)sender
{
    
    if (sender.tag==111)
    {
        linetypeStr=[NSMutableString stringWithString:@""];
        linetypeArray=[NSMutableArray arrayWithArray:oldLinetypeArray];
        if ([[linetypeArray lastObject] length]>0)
        {
            
            for (int i=0; i<linetypeArray.count; i++)
            {
                if (i!=linetypeArray.count-1)
                {
                    [linetypeStr appendFormat:@"%@,",[linetypeArray objectAtIndex:i]];
                }
                else
                {
                    [linetypeStr appendFormat:@"%@",[linetypeArray objectAtIndex:i]];
                    
                }
            }
        }
       // NSLog(@"linetypeStr======%@",linetypeStr);
        
        linedays=oldLineDays;
        lowprice=oldLowprice;
        higprice=oldHigprice;
        
        NSString*canshu=[NSString stringWithFormat:@"cityid=%d&title=%@&linetype=%@&linedays=%d&lowprice=%d&higprice=%d&orderbystr=%d&pagesize=%d&pageindex=%d",2,@"",linetypeStr,linedays,lowprice,higprice,orderbystr,10,0];
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getTourLineList";
        [urlDomain appendString:urlMethod];
        [navActivity startAnimating];
        postRequestYiBu(canshu, urlDomain)
        index1=0;
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:34];
        imageView.image=[UIImage imageNamed:@"001.png"];
        
        filterView.hidden=YES;
    }
    if (sender.tag==110)
    {
        if (sendTag==101)
        {
            oldLineDays=0;
            UILabel*lable=(UILabel*)[self.view viewWithTag:160];
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:170];
            imageView.image=[UIImage imageNamed:@"pitchUp.png"];
            
            for (int i=1; i<6; i++)
            {
                UILabel*lable1=(UILabel*)[self.view viewWithTag:i+160];
                lable1.textColor=[UIColor blackColor];
                
                UIImageView*imageView2=(UIImageView*)[self.view viewWithTag:i+170];
                imageView2.image=[UIImage imageNamed:@""];
                
            }
            
            
            
        }
        
        if (sendTag==102)
        {
            
            oldLowprice=0;
            oldHigprice=0;
            
            UILabel*lable1=(UILabel*)[self.view viewWithTag:201];
            UILabel*lable2=(UILabel*)[self.view viewWithTag:202];
            lable1.text=[NSString stringWithFormat:@"¥0"];
            lable2.text=[NSString stringWithFormat:@"不限"];
            
            NMRangeSlider*_slider=(NMRangeSlider*)[self.view viewWithTag:700];
            [_slider setLowerValue:0 upperValue:20000 animated:YES];
            
        }
        
        if (sendTag==100)
        {
            
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:270];
            imageView.image=[UIImage imageNamed:@"pitchUp.png"];
            UILabel*lable=(UILabel*)[self.view viewWithTag:260];
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            
            
            for (int i=1; i<arrayType.count+1; i++)
            {
                UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:i%(arrayType.count+1)+270];
                imageView1.image=[UIImage imageNamed:@""];
                
                UILabel*lable1=(UILabel*)[self.view viewWithTag:i%(arrayType.count+1)+260];
                lable1.textColor=[UIColor blackColor];
                
            }
            
            linetypeStr=[NSMutableString stringWithString:@""];
            oldLinetypeArray=[NSMutableArray new];
            
        }
    }
    
}
-(void)tttt:(UIButton*)sender
{
    
    
    if (sender.tag>=100&&sender.tag<=100+array.count-1)
    {
        sendTag=sender.tag;
        UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+30];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        
        for (int i=1; i<array.count; i++)
        {
            UIButton*button=(UIButton*)[self.view viewWithTag:(sender.tag-100+i)%array.count+100];
            
            [button setBackgroundImage:[UIImage imageNamed:@"leftSelect"] forState:UIControlStateNormal];
            UILabel*lable2=(UILabel*)[self.view viewWithTag:(sender.tag-100+i)%array.count+100+30];
            lable2.textColor=[UIColor blackColor];
        }
    }
    
    switch (sender.tag)
    {
        case 100:
        {
            
            [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            [SelectPrice removeFromSuperview];
            //                [SelectData removeFromSuperview];
            [SelectDay removeFromSuperview];
            [filterView addSubview:SelectType];
            
            
        }
            break;
        case 101:
        {
            
            [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            [SelectPrice removeFromSuperview];
            //            [SelectData removeFromSuperview];
            [SelectType removeFromSuperview];
            [filterView addSubview:SelectDay];
            
            
        }
            break;
        case 102:
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            [SelectData removeFromSuperview];
            [SelectDay removeFromSuperview];
            [SelectType removeFromSuperview];
            [filterView addSubview:SelectPrice];
            
        }
            break;
        case 103:
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"leftSelect2"] forState:UIControlStateNormal];
            [SelectData removeFromSuperview];
            [SelectDay removeFromSuperview];
            [SelectType removeFromSuperview];
            [filterView addSubview:SelectPrice];
            
            
        }
            break;
            
        case 60:
        {
//            CalenderViewController*calendarController=[CalenderViewController new];
//            
//            calendarController.TapCount=2;
//            calendarController.tag=1;
//            //[calendarController setDelegate:self];
//            //        [calendarController.navigationItem setHidesBackButton:YES];
//            calendarController.fromDate=self.FromDate;
//            calendarController.toDate=self.ToDate;
//            [calendarController setBeginDate:[NSDate date]];
//            [calendarController setEndDate:[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24*30]];
//            //    [calendarController setFromDate:fromDate];
//            //    [calendarController setToDate:toDate];
//            [self.navigationController pushViewController:calendarController animated:NO];
            
            
        }
            break;
        case 61:
        {
            
            RTLabel*lable=(RTLabel*)[self.view viewWithTag:63];
           // NSLog(@"length=====%d",lable.text.length);
            if (lable.text.length!=30)
            {
//                CalenderViewController*calendarController=[CalenderViewController new];
//                
//                calendarController.TapCount=2;
//                calendarController.tag=1;
//                //[calendarController setDelegate:self];
//                //        [calendarController.navigationItem setHidesBackButton:YES];
//                calendarController.fromDate=self.FromDate;
//                calendarController.toDate=self.ToDate;
//                [calendarController setBeginDate:[NSDate date]];
//                [calendarController setEndDate:[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24*30]];
//                //    [calendarController setFromDate:fromDate];
//                //    [calendarController setToDate:toDate];
//                [self.navigationController pushViewController:calendarController animated:NO];
            }
            
            
            
            
        }
            break;
            
            
        default:
            break;
    }
}

-(void)xiala:(UIButton*)sender
{

    UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
    lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    
    
    
    [sender setImage:[UIImage imageNamed:@"sectionGray.png"] forState:UIControlStateNormal];
    
    for (int i=1; i<5; i++)
    {
        UIButton*button=(UIButton*)[self.view viewWithTag:(sender.tag-10+i)%5+10];
        [button setImage:[UIImage imageNamed:@"sectionWhite.png"] forState:UIControlStateNormal];
    }
    
    
    isSave=sender.tag;
    for (int i=1; i<5; i++)
    {
        UILabel*lable1=(UILabel*)[self.view viewWithTag:(sender.tag-10+i)%5+20];
        lable1.textColor=[UIColor grayColor];
    }
    
    UIImageView*imageView=(UIImageView*)[self.view viewWithTag:33];
    if (sender.tag!=14)
    {
        if (sender.tag==10)
        {
            orderbystr=0;
        }
        if (sender.tag==11)
        {
            orderbystr=1;
        }
        if (sender.tag==12)
        {
            orderbystr=2;
        }
        
        if (sender.tag==13)
        {
            
            if (imageView.image==[UIImage imageNamed:@"price_04.png"])
            {
                imageView.image=[UIImage imageNamed:@"price_02.png"];
                orderbystr=4;//上
                
                
            }
            else
            {
                orderbystr=3;
                
                imageView.image=[UIImage imageNamed:@"price_04.png"];//下
                
            }
            
            
            
            
        }
        NSString*canshu=[NSString stringWithFormat:@"cityid=%d&title=%@&linetype=%@&linedays=%d&lowprice=%d&higprice=%d&orderbystr=%d&pagesize=%d&pageindex=%d",2,@"",linetypeStr,linedays,lowprice,higprice,orderbystr,lineArray.count,0];
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getTourLineList";
        [urlDomain appendString:urlMethod];
        
        postRequestYiBu(canshu, urlDomain)
        [navActivity startAnimating];
        index1=0;
//        [picArray removeAllObjects];
        if (filterView.hidden==NO)
        {
            filterView.hidden=YES;
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:34];
            imageView.image=[UIImage imageNamed:@"001.png"];
            [stockForKVO setValue:[NSNumber numberWithBool:filterView.hidden] forKey:@"filter"];
            [self viewHidden];
            
        }
        
        
    }else{
        if (imageView.image==[UIImage imageNamed:@"price_04.png"])
        {
            imageView.image=[UIImage imageNamed:@"price_03.png"];
            
            
        }
        else if (imageView.image==[UIImage imageNamed:@"price_02.png"])
        {
            
            imageView.image=[UIImage imageNamed:@"price_01.png"];//下
            
        }
    }
    
    
    
    
    
    
    if (sender.tag==14)
    {
        if (filterView.hidden==YES)
        {
            filterView.hidden=NO;
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:34];
            imageView.image=[UIImage imageNamed:@"002.png"];
            
        }
        
        else
        {
            
            filterView.hidden=YES;
            UIImageView*imageView=(UIImageView*)[self.view viewWithTag:34];
            imageView.image=[UIImage imageNamed:@"001.png"];
            [self viewHidden];
            
        }
        
        
        
    }
    
    
    
}
-(void)viewHidden
{
    
    oldLineDays=linedays;
    
    UILabel*lable=(UILabel*)[self.view viewWithTag:oldLineDays+160];
    lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    UIImageView*imageView=(UIImageView*)[self.view viewWithTag:oldLineDays+170];
    imageView.image=[UIImage imageNamed:@"pitchUp.png"];
    
    for (int i=1; i<6; i++)
    {
        UILabel*lable1=(UILabel*)[self.view viewWithTag:(oldLineDays+i)%6+160];
        lable1.textColor=[UIColor blackColor];
        
        UIImageView*imageView2=(UIImageView*)[self.view viewWithTag:(oldLineDays+i)%6+170];
        imageView2.image=[UIImage imageNamed:@""];
        
    }
    
    
    oldLowprice=lowprice;
    oldHigprice=higprice;
    
    UILabel*lable1=(UILabel*)[self.view viewWithTag:201];
    UILabel*lable2=(UILabel*)[self.view viewWithTag:202];
    lable1.text=[NSString stringWithFormat:@"¥%d",oldLowprice];
    lable2.text=[NSString stringWithFormat:@"¥%d",oldHigprice];
    
    NMRangeSlider*_slider=(NMRangeSlider*)[self.view viewWithTag:700];
    [_slider setLowerValue:oldLowprice upperValue:oldHigprice animated:YES];
    
    if (oldHigprice==0)
    {
        lable2.text=[NSString stringWithFormat:@"不限"];
        [_slider setLowerValue:oldLowprice upperValue:20000 animated:YES];
    }
    oldLinetypeArray=[NSMutableArray new];
    oldLinetypeArray=[NSMutableArray arrayWithArray:linetypeArray];
    
    for (int i=0; i<arrayType.count+1; i++)
    {
        UILabel*lable=(UILabel*)[self.view viewWithTag:260+i];
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:270+i];
        lable.textColor=[UIColor blackColor];
        imageView.image=[UIImage imageNamed:@""];
        
    }
    
    if (oldLinetypeArray.count==0)
    {
        UILabel*lable=(UILabel*)[self.view viewWithTag:260];
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:270];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
    }
    
    
    NSMutableArray*_array=[NSMutableArray new];
    for (int i=0; i<arrayType.count; i++)
    {
        [_array addObject:[arrayType objectAtIndex:i]];
    }
//    for (int i=0; i<_array.count; i++)
//    {
//        NSLog(@"_array===%@",[_array objectAtIndex:i]);
//    }
    
    for (int i=0; i<oldLinetypeArray.count; i++)
    {
        int a=[_array indexOfObject:[oldLinetypeArray objectAtIndex:i]];
     //   NSLog(@"a======%d",a);
        UILabel*lable=(UILabel*)[self.view viewWithTag:261+a];
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:271+a];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        
        
        
        
    }
    
//    NSLog(@"count=====%d",oldLinetypeArray.count);
    
    
}
-(void)creatSelectData
{
    
    SelectData=[[UIView alloc]initWithFrame:CGRectMake(100, 0, 220, 280)];
    NSArray*array4=[NSArray arrayWithObjects:@"<font color=gray>从</font> 选择日期",@"<font color=gray>到</font> 选择日期", nil];
    for (int i=0; i<2; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=60+i;
        [button addTarget:self action:@selector(tttt:) forControlEvents:UIControlEventTouchUpInside];
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
        
        
        UIView*link=[[UIView alloc]initWithFrame:CGRectMake(0, 45, 220, 1)];
        link.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [button addSubview:link];
        //        entainmentData.png
        UIImageView*data=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 20, 20)];
        data.image=[UIImage imageNamed:@"entainmentData.png"];
        [button addSubview:data];
        
        RTLabel*lable=[[RTLabel alloc]initWithFrame:CGRectMake(20, 0, 220, 0)];
        lable.tag=63+i;
        lable.userInteractionEnabled=NO;
        lable.text=[array4 objectAtIndex:i];
        CGSize size=[lable optimumSize];
        lable.frame=CGRectMake(20, (46.0-size.height)/2, 220, size.height);
        [button addSubview:lable];
        [SelectData addSubview:button];
        
        
        
        
    }
    
    
    
    
    
}

-(void)creatSection
{
    
    NSArray*_array=[NSArray arrayWithObjects:@"默认",@"喜欢",@"点评", @"价格",@"筛选",nil];
    
    for (int i=0; i<5; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"sectionWhite.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"sectionGray.png"] forState:UIControlStateHighlighted];
        
        if (i==0)
        {
            [button setImage:[UIImage imageNamed:@"sectionGray.png"] forState:UIControlStateNormal];
        }
        //        [button setBackgroundColor:[UIColor blackColor]];
        button.frame=CGRectMake(i* (DeviceWidth/_array.count), 0, DeviceWidth/_array.count, 40);
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(27, 0, 30, 40)];
        lable.textColor=[UIColor grayColor];
        button.tag=10+i;
        lable.font=[UIFont systemFontOfSize:13];
        lable.tag=20+i;
        lable.text=[_array objectAtIndex:i];
        [button addSubview:lable];
        
        [button addTarget:self action:@selector(xiala:) forControlEvents:UIControlEventTouchUpInside];
        //        [button setImage:[UIImage imageNamed:@"more_ recomm.png"] forState:UIControlStateNormal];
        [self.view addSubview:button];
        if (i==0||i==1||i==2)
        {
            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(8, 10, 19,19)];
            imageview.image=[UIImage imageNamed:[NSString stringWithFormat:@"hotel_0%d",i+1]];
            [button addSubview:imageview];
            imageview.tag=30+i;
            
            if (i==0)
            {
                lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            }
            
        }
        
        if (i==3)
        {
            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(40, 10, 19, 19)];
            imageview.image=[UIImage imageNamed:@"price_03.png"];
            [button addSubview:imageview];
            imageview.tag=30+i;
            lable.frame=CGRectMake(15, 0, 30, 40);
            
        }
        
        if (i==4)
        {
            UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(44, 14, 11, 11)];
            imageview.image=[UIImage imageNamed:@"001.png"];
            [button addSubview:imageview];
            imageview.tag=30+i;
            lable.frame=CGRectMake(15, 0, 30, 40);
        }
        
        
    }
    
    
    
    
}

- (void)loadPic_tableViewDataArray:(NSMutableArray*)mainDataArr objectAtIndex:(int)indexTag objectForKey:(NSString*)dicKey picHeadUrlStr:(NSMutableString*)picUrl picUrlPathStr:(NSString*)picPathStr PicLoadName:(NSString*)name headView:(UIImageView *)headView{
    
    if (mainDataArr.count>0&&[[[mainDataArr objectAtIndex:indexTag] objectForKey:dicKey] length]>4) {
        NSLog(@"[[_dataArr objectAtIndex:indexPath.row] objectForKey:Pic]   %@",[[mainDataArr objectAtIndex:indexTag] objectForKey:dicKey]);
        NSData *pathData = [NSData dataWithContentsOfFile:PathOfFile(name)];
        
        if (pathData.length==0) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSString *urlStr = [NSString stringWithFormat:@"%@%@/%@",picUrl,picPathStr,[[mainDataArr objectAtIndex:indexTag] objectForKey:dicKey]];
                //NSLog(@"picurl %@",urlStr);
                NSURL *url = [NSURL URLWithString:urlStr];
                NSData *data = [NSData dataWithContentsOfURL:url];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data) {
                        [data writeToFile:PathOfFile(name) atomically:YES];
                        headView.image = [UIImage imageWithData:data];
                        
                    }
                });
            });
        }else headView.image = [UIImage imageWithData:pathData];
        
    }
}
#pragma mark-文字保存的路径
-(NSString *)filePath:(NSString*)text
{
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    
    //[[NSFileManager defaultManager]   createDirectoryAtPath:[NSString stringWithFormat:@"%@/myData",docPath] withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *path = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"myData/%@",text]];
   // NSLog(@"filePath %@",path);
    
    
    return path;
}


-(void)creatSelectDay
{
    NSArray*arrayday=[NSArray arrayWithObjects:@"全部",@"1日游",@"2~3天",@"4~5天",@"6~10天",@"10天以上", nil];
    
    SelectDay=[[UIScrollView alloc]initWithFrame:CGRectMake(100, 0, 220, 270)];
    SelectDay.backgroundColor = [UIColor whiteColor];
    float f=0;
    for (int i=0; i<arrayday.count; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=150+i;
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(chooseDay:) forControlEvents:UIControlEventTouchUpInside];
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
        
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 46)];
        lable.tag=160+i;
        lable.font = [UIFont systemFontOfSize:17];
        lable.text=[arrayday objectAtIndex:i];
        [button addSubview:lable];
        
        UIImageView*select=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 18, 18)];
        select.tag=170+i;
        if (i==0)
        {
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            select.image=[UIImage imageNamed:@"pitchUp.png"];
        }
        
        [button addSubview:select];
        
        
        [SelectDay addSubview:button];
        
        
        
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView.image=[UIImage imageNamed:@"lineGray"];
        
        [button addSubview:imageView];
        
        
        f+=button.frame.size.height;
        
        
        SelectDay.contentSize=CGSizeMake(220, f+20);
        
    }
}
-(void)chooseDay:(UIButton*)sender
{
    
    oldLineDays=sender.tag-150;
    UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
    lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
    UIImageView*imageView=(UIImageView*)[self.view viewWithTag:sender.tag+20];
    imageView.image=[UIImage imageNamed:@"pitchUp.png"];
    
    for (int i=1; i<6; i++)
    {
        UILabel*lable1=(UILabel*)[self.view viewWithTag:(sender.tag-150+i)%6+160];
        lable1.textColor=[UIColor blackColor];
        
        UIImageView*imageView2=(UIImageView*)[self.view viewWithTag:(sender.tag-150+i)%6+170];
        imageView2.image=[UIImage imageNamed:@""];
        
    }
    
    
    
    
}
-(void)creatSelectType
{
    arrayType=[NSMutableArray arrayWithObjects:@"经典游",@"亲子游",@"半自助游",@"艺术/文化探索游",@"博物馆之旅",@"婚纱/蜜月游",@"公务/商务游",@"VIP尊享游",@"其他", nil];
    SelectType=[[UIScrollView alloc]initWithFrame:CGRectMake(100, 0, 220, 270)];
    SelectType.backgroundColor = [UIColor whiteColor];
    float f=0;
    for (int i=0; i<arrayType.count+1; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=250+i;
        button.frame=CGRectMake(0, 0+46*i, 220, 46);
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 46)];
        lable.tag=260+i;
        if (i==0)
        {
            lable.text=@"全部";
        }
        else
        {
            lable.text=[arrayType objectAtIndex:i-1];
        }
        [button addSubview:lable];
        [SelectType addSubview:button];
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45.5, 220, .5)];
        imageView.image=[UIImage imageNamed:@"lineGray.png"];
        [button addSubview:imageView];
        
        
        f+=button.frame.size.height;
        UIImageView*select=[[UIImageView alloc]initWithFrame:CGRectMake(180, 13, 18, 18)];
        select.tag=270+i;
        if (i==0)
        {
            select.image=[UIImage imageNamed:@"pitchUp.png"];
            lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        }
        
        [button addSubview:select];
        
        
        
    }
    SelectType.contentSize=CGSizeMake(220, f+20);
    
    [filterView addSubview:SelectType];
    
    
    
    
}
-(void)chooseType:(UIButton*)sender
{
    
    if (sender.tag==250)
    {
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:270];
        imageView.image=[UIImage imageNamed:@"pitchUp.png"];
        UILabel*lable=(UILabel*)[self.view viewWithTag:260];
        lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
        
        
        for (int i=1; i<arrayType.count+1; i++)
        {
            UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:(sender.tag-250+i)%(arrayType.count+1)+270];
            imageView1.image=[UIImage imageNamed:@""];
            
            UILabel*lable1=(UILabel*)[self.view viewWithTag:(sender.tag-250+i)%(arrayType.count+1)+260];
            lable1.textColor=[UIColor blackColor];
            
        }
        
        linetypeStr=[NSMutableString stringWithString:@""];
        oldLinetypeArray=[NSMutableArray new];
    }
    else
    {
        UIImageView*imageView1=(UIImageView*)[self.view viewWithTag:270];
        imageView1.image=[UIImage imageNamed:@""];
        
        UILabel*lable1=(UILabel*)[self.view viewWithTag:260];
        lable1.textColor=[UIColor blackColor];
        
        
        
        UIImageView*imageView=(UIImageView*)[self.view viewWithTag:sender.tag+20];
        
        UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag+10];
        
        
        
        if (  imageView.image==[UIImage imageNamed:@"pitchUp.png"])
        {
            if (oldLinetypeArray.count>1)
            {
                imageView.image=[UIImage imageNamed:@""];
                [oldLinetypeArray removeObject:[arrayType objectAtIndex:sender.tag-250-1] ];
                lable.textColor=[UIColor blackColor];
                
            }
        }
        else
        {
            if (oldLinetypeArray.count<6)
            {
                imageView.image=[UIImage imageNamed:@"pitchUp.png"];
                [oldLinetypeArray addObject:[arrayType objectAtIndex:sender.tag-250-1] ];
                lable.textColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"blueBackGround.png"]];
            }
        }
        
        
    }
    
}
-(void)getTourLineList
{
    
    [navActivity startAnimating];
    
    Reachability*rea2 =[Reachability reachabilityWithHostName:@"www.baidu.com"];if ([rea2  currentReachabilityStatus]==NotReachable){noNetButton.hidden=NO;}else{noNetButton.hidden=YES;}
    
    if (self.collectID==0)
    {
        NSString*canshu2=[NSString stringWithFormat:@"cityid=%d&title=%@&linetype=%@&linedays=%d&lowprice=%d&higprice=%d&orderbystr=%d&pagesize=%d&pageindex=%d",2,@"",@"",0,0,0,0,LoadCount,0];
        
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getTourLineList";
        [urlDomain appendString:urlMethod];
        postRequestYiBu(canshu2, urlDomain)
        
    }
    else
    {
        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
        NSString*userid=[NSString stringWithFormat:@"%d",[defaults integerForKey:@"QuseID"]];
        
        NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d",2],@"cityid",[NSString stringWithFormat:@"%d",self.collectID],@"typeid",userid,@"userid", [NSString stringWithFormat:@"%d",LoadCount],@"pagesize", [NSString stringWithFormat:@"%d",index1],@"pageindex", nil];
        
        NSMutableString*str=RussiaUrl4
        [QYHMeThod YiBuRequestandMethod:@"getUserCollectList" andDomain:str andHttpMethod:@"POST" andArgument:dic andDelegate:self];
        
        
        
        
    }
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"_count  %d",_count);
    
    navActivity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    navActivity.frame=CGRectMake(65+(8-4)*10, (44- navActivity.frame.size.height)/2, navActivity.frame.size.width,  navActivity.frame.size.height);
    [self.navigationController.navigationBar addSubview:navActivity];
    
    
    
//    picArray=[NSMutableArray new];
//    [picArray removeAllObjects];
//    
//    NSLog(@"count====%d",picArray.count);
//    searchPicArray=[NSMutableArray new];
//    [searchPicArray removeAllObjects];
    
//    UIImage*image2=[UIImage imageNamed:@"pitchUp.png"];
//    NSData*data2=UIImagePNGRepresentation(image2);
//    str11 = [data2 base64Encoding];
//    
//    NSLog(@"data2String====%@",[data2 base64Encoding]);
    tag=0;
    isSave=10;
    _loadingMore=NO;
    remindAlert=[[UIAlertView alloc]initWithTitle:@"正在加载..." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    act=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    act.frame=CGRectMake(120, 48, 37, 37);
    [remindAlert addSubview:act];
    
    
    
    lineArray=[NSMutableArray new];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray*useArray;
    if([fm fileExistsAtPath:[self filePath:@"getTourLineList"]])
    {
        useArray=[NSArray arrayWithContentsOfFile:[self filePath:@"getTourLineList"]];
    }
    
    
    lineArray=[NSMutableArray arrayWithArray:useArray];
    
    if (self.collectID==0)
    {
        [self creatSection];
    }
    
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, 320, DeviceHeight-64-40) style:UITableViewStylePlain];
    if (self.collectID!=0)
    {
        _tabView.frame=CGRectMake(0,0, 320, DeviceHeight-64);
        
    }
    _tabView.delegate=self;
    _tabView.dataSource=self;
    _tabView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _tabView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tabView];
    _tabView.tableFooterView=[self createTableFooter:@"上拉显示更多"];
    noNetButton=NoNetButton(noNetButton);
    
    
    [self performSelector:@selector(getTourLineList) withObject:nil afterDelay:0];
    //        [act startAnimating];
    //
    //        [remindAlert show];
    
    
    
    lineTypeDic=[NSMutableDictionary new];
    
    linetypeStr=[NSMutableString stringWithString:@""];
    linetypeArray=[NSMutableArray new];
    oldLinetypeArray=[NSMutableArray new];
    linedays=0;
    
    lowprice=0;
    higprice=0;
    orderbystr=0;
    
    isSelect=NO;
    sendTag=100;
    isDisplay=NO;
    self.view.backgroundColor=GroupColor;
    
    
    
    
    
    [self creatFilter];
    [self creatSelectPrice];
    //    [self creatSelectData];
    [self creatSelectType];
    [self creatSelectDay];
    //    [self creatSelectType];
    
    refresh=[[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    refresh.tintColor=[UIColor clearColor];
    refresh.attributedTitle=[[NSAttributedString alloc] initWithString:@""];
    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [_tabView addSubview:refresh];
    
    
    UIButton *backbutton2 = [[UIButton alloc]init] ;
    
    float height=20;
    backbutton2.frame=CGRectMake(0, (44-height)/2, height, height) ;
    
    backbutton2.titleLabel.font=[UIFont systemFontOfSize:14];
    [backbutton2 addTarget:self action:@selector(seach) forControlEvents:UIControlEventTouchUpInside];
    [backbutton2 setImage:[UIImage imageNamed:@"hotel_search.png"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:backbutton2] ;
    if (self.collectID==0)
    {
        self.navigationItem.rightBarButtonItem =backItem2;
    }
    
    [self creatSearchBar];
    
    
    
    
    
    
    
	// Do any additional setup after loading the view.
}
GO_NET
-(void)seach
{
    
    searchDisplayC.searchResultsDataSource=self;
    searchDisplayC.searchResultsDelegate=self;
    self.navigationController.navigationBar.hidden=YES;
    self.navigationItem.hidesBackButton=YES;
    [self.view addSubview:searchBar];
    [searchBar becomeFirstResponder];
    
    
}

-(void)creatSearchBar
{
    
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    searchBar.tintColor=[UIColor brownColor];
    searchBar.placeholder=@"搜索";
    searchDisplayC=[[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    searchDisplayC.searchResultsTableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    searchDisplayC.searchResultsTableView.separatorColor=[UIColor clearColor];
    
    searchDisplayC.delegate=self;
    
    
}
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    
    [searchBar resignFirstResponder];
    [searchBar removeFromSuperview];
    
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate

{
    
    // 下拉到最底部时显示更多数据
    
    if(!_loadingMore && scrollView.contentOffset.y > ((scrollView.contentSize.height - scrollView.frame.size.height+10)))
        
    {
        
        [self loadDataBegin];
        
    }
    
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    isDisplay=NO;
   // NSLog(@"%s",__func__);
    return YES;
}

-(void)creatSelectPrice
{
    SelectPrice=[[UIView alloc]initWithFrame:CGRectMake(100, 0, 220, 270)];
    SelectPrice.backgroundColor = [UIColor whiteColor];
    slider=[[NMRangeSlider alloc]initWithFrame:CGRectMake(10, 60, 200, 15)];
    [slider addTarget:self action:@selector(progress:)  forControlEvents:UIControlEventValueChanged ];
    [SelectPrice addSubview:slider];
    
    //    UISlider
    UIImage* image = nil;
    
    image = [UIImage imageNamed:@"line_trackGray.png"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 3.0, 0.0, 3.0)];
    slider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"line_trackBlue.png"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 3.0, 0.0, 3.0)];
    slider.trackImage = image;
    
    image = [UIImage imageNamed:@"line_circle.png"];
    slider.lowerHandleImageNormal = image;
    slider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"line_circle.png"];
    slider.lowerHandleImageHighlighted = image;
    slider.upperHandleImageHighlighted = image;
    
    slider.minimumRange=2000;
    slider.minimumValue=0;
    slider.maximumValue=20000;
    slider.upperValue=20000;
    slider.lowerValue=0;
    slider.stepValue=2000;
    slider.continuous=NO;
    slider.tag = 700 ;
    
    UILabel*lowPrice=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 20) ];
    [SelectPrice addSubview:lowPrice];
    lowPrice.tag=201;
    lowPrice.text=@"¥0";
    lowPrice.textColor=[UIColor blueColor];
    lowPrice.font=[UIFont systemFontOfSize:15];
    
    UILabel*upperPrice=[[UILabel alloc]initWithFrame:CGRectMake(180, 20, 80, 20) ];
    [SelectPrice addSubview:upperPrice];
    upperPrice.text=@"不限";
    upperPrice.tag=202;
    upperPrice.textColor=[UIColor blueColor];
    upperPrice.font=[UIFont systemFontOfSize:15];
    
}

-(void)refreshData
{
    [navActivity startAnimating];
    
    index1=0;
    
    if (self.collectID==0)
    {
        NSString*canshu=[NSString stringWithFormat:@"cityid=%d&title=%@&linetype=%@&linedays=%d&lowprice=%d&higprice=%d&orderbystr=%d&pagesize=%d&pageindex=%d",2,@"",linetypeStr,linedays,lowprice,higprice,orderbystr,LoadCount,0];
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getTourLineList";
        [urlDomain appendString:urlMethod];
        postRequestYiBu(canshu, urlDomain)
        
    }
    else
    {
        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
        NSString*userid=[NSString stringWithFormat:@"%d",[defaults integerForKey:@"QuseID"]];
        
        NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d",2],@"cityid",[NSString stringWithFormat:@"%d",self.collectID],@"typeid",userid,@"userid", [NSString stringWithFormat:@"%d",LoadCount],@"pagesize", [NSString stringWithFormat:@"%d",index1],@"pageindex", nil];
        NSMutableString*str=RussiaUrl4
        [QYHMeThod YiBuRequestandMethod:@"getUserCollectList" andDomain:str andHttpMethod:@"POST" andArgument:dic andDelegate:self];
        
        
        
        
    }
    
    
    
    
    
}


-(void)progress:(NMRangeSlider*)sender
{
    UILabel*lable1=(UILabel*)[self.view viewWithTag:201];
    UILabel*lable2=(UILabel*)[self.view viewWithTag:202];
    lable1.text=[NSString stringWithFormat:@"¥%d",(int)sender.lowerValue];
    lable2.text=[NSString stringWithFormat:@"¥%d",(int)sender.upperValue];
    
    
    oldLowprice=(int)sender.lowerValue;
    oldHigprice=(int)sender.upperValue;
    if (sender.upperValue==20000.0)
    {
        lable2.text=@"不限";
        oldHigprice=0;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 260;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==searchDisplayC.searchResultsTableView)
    {
        
        if (isDisplay==NO)
        {
           // NSLog(@"text=======%@",searchBar.text);
            
            NSString*canshu2=[NSString stringWithFormat:@"cityid=%d&title=%@&linetype=%@&linedays=%d&lowprice=%d&higprice=%d&orderbystr=%d&pagesize=%d&pageindex=%d",2,searchBar.text,@"",0,0,0,0,LoadCount,0];
            
            NSMutableString*urlDomain=RussiaUrl2
            NSString *urlMethod=@"getTourLineList";
            [urlDomain appendString:urlMethod];
            postRequestYiBu(canshu2, urlDomain)
            isDisplay=YES;
            
            
        }
        if ([[dataForSearchArray lastObject]valueForKey:@"ID"])
        {
            return   dataForSearchArray.count;
            
        }
        else
            return 0;
    }
    
    
    
    if ([[lineArray lastObject]valueForKey:@"Row"])
    {
        return lineArray.count;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*str=@"cell";
    LineCustomCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[LineCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    if (lineArray.count>0) {
        if (tableView==searchDisplayC.searchResultsTableView)
        {
            cell.head.text=[[dataForSearchArray objectAtIndex:indexPath.row]valueForKey:@"Title"];
            
            
            if (![[NSString stringWithFormat:@"%@",[[dataForSearchArray objectAtIndex:indexPath.row]valueForKey:@"LPrice"]]   isEqualToString:@""])
            {
                cell.price.text=[NSString stringWithFormat:@"$<font size=16 color=orange>%@</font>",[[dataForSearchArray objectAtIndex:indexPath.row]valueForKey:@"LPrice"]];
            }
            else
            {
                cell.price.text=@"";
                
            }
            
            int a=[[[dataForSearchArray objectAtIndex:indexPath.row]valueForKey:@"LineDays"]intValue];
            cell.intrdouce.text=[NSString stringWithFormat:@"%d天 %@",a,[[dataForSearchArray objectAtIndex:indexPath.row]valueForKey:@"LineType"]];
        }
        else
        {
            cell.head.text=[[lineArray objectAtIndex:indexPath.row]valueForKey:@"Title"];

            
            
            if (![[NSString stringWithFormat:@"%@",[[lineArray objectAtIndex:indexPath.row]valueForKey:@"LPrice"]]   isEqualToString:@""])
            {
                cell.price.text=[NSString stringWithFormat:@"$<font size=16 color=orange>%@</font>",[[lineArray objectAtIndex:indexPath.row]valueForKey:@"LPrice"]];
                
            }
            else
            {
                cell.price.text=@"";
                
            }
            
            
            
            int a=[[[lineArray objectAtIndex:indexPath.row]valueForKey:@"LineDays"]intValue];
            cell.intrdouce.text=[NSString stringWithFormat:@"%d天 %@",a,[[lineArray objectAtIndex:indexPath.row]valueForKey:@"LineType"]];
        }
      
        [self loadPic_tableViewDataArray:lineArray objectAtIndex:indexPath.row objectForKey:@"Pic" picHeadUrlStr:PicUrl picUrlPathStr:@"line/big" PicLoadName:cell.head.text headView:cell._imageView];

    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LineCustomCell *cell = (LineCustomCell*)[tableView cellForRowAtIndexPath:indexPath];
    EntainDetailViewController*detail=[EntainDetailViewController new];
    detail.classID=2;
    detail.navName=@"线路介绍";
    detail.fromeImage = cell._imageView.image;
    detail.hotelID=[[[lineArray objectAtIndex:indexPath.row]valueForKey:@"ID"] integerValue];
    [self.navigationController pushViewController:detail animated:NO];
}
- (void) loadDataBegin

{
    
    if (_loadingMore == NO)
        
    {
        
        _loadingMore = YES;
        
        UILabel*lable=(UILabel*)[self.view viewWithTag:2];
        lable.text=@"";
        UIActivityIndicatorView *tableFooterActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150.0f, 10.0f, 20.0f, 20.0f)];
        
        [tableFooterActivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        
        [tableFooterActivityIndicator startAnimating];
        [_tabView.tableFooterView addSubview:tableFooterActivityIndicator];
        [self loadDataing];
        
    }
    
}


// 加载数据中

- (void) loadDataing

{
    index1++;
    if (self.collectID==0)
    {
        NSString*canshu=[NSString stringWithFormat:@"cityid=%d&title=%@&linetype=%@&linedays=%d&lowprice=%d&higprice=%d&orderbystr=%d&pagesize=%d&pageindex=%d",2,@"",linetypeStr,linedays,lowprice,higprice,orderbystr,LoadCount,index1];
        NSMutableString*urlDomain=RussiaUrl2
        NSString *urlMethod=@"getTourLineList";
        [urlDomain appendString:urlMethod];
        
        postRequestYiBu(canshu, urlDomain)
        
        
    }
    else
    {
        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
        NSString*userid=[NSString stringWithFormat:@"%d",[defaults integerForKey:@"QuseID"]];
        NSDictionary*dic=[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d",2],@"cityid",[NSString stringWithFormat:@"%d",self.collectID],@"typeid",userid,@"userid", [NSString stringWithFormat:@"%d",LoadCount],@"pagesize", [NSString stringWithFormat:@"%d",index1],@"pageindex", nil];
        NSMutableString*str=RussiaUrl4
        [QYHMeThod YiBuRequestandMethod:@"getUserCollectList" andDomain:str andHttpMethod:@"POST" andArgument:dic andDelegate:self];
    }
    
}


// 加载数据完毕
- (void) loadDataEnd:(NSString*)text

{
    
    _loadingMore = NO;
    [self createTableFooter:text];
    
}


// 创建表格底部

- (UIView*) createTableFooter:(NSString*)text
{
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _tabView.bounds.size.width, 40.0f)];
    UILabel *loadMoreText = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320, 40.0f)];
    loadMoreText.tag=2;
    [loadMoreText setCenter:tableFooterView.center];
    [loadMoreText setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    loadMoreText.textAlignment=NSTextAlignmentCenter;
    [tableFooterView addSubview:loadMoreText];
    _tabView.tableFooterView=tableFooterView;
    return tableFooterView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
