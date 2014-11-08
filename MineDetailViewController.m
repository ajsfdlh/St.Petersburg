
//  MineDetailViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MineDetailViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
@interface MineDetailViewController ()
{
    NSURLConnection *conn;
    NSMutableData *mdata;
}
@end

@implementation MineDetailViewController


-(void)viewWillAppear:(BOOL)animated
{
    hideTabbar
    [self.navigationItem setNewTitle:self.pageTitle];
    
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int b=[defaults integerForKey:QUSE_ID];
    
    NSString *str=nil;
//    NSLog(@"b==%d",b);
  
        str=[NSString stringWithFormat:@"uid=%d",b];//设置参数
        self.useID=b;
    
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2)
    {
        NSMutableString *urlDomain = RussiaUrl;
                NSString*urlMethod=@"getServiceUserInfo";
                [urlDomain appendString:urlMethod];
        postRequestYiBu(str, urlDomain)
       
    }else{
        NSMutableString*urlDomain=RussiaUrl
        NSString*urlMethod=@"getUserInfo";
        [urlDomain appendString:urlMethod];
        postRequestYiBu(str, urlDomain)
    }

    
    
}
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    array=[NSArray arrayWithObjects:@"邮箱",@"手机号",@"性别", @"出生日期",@"所在地",@"详细地址",@"邮政编码",@"个人介绍",nil];

    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    [self.view addSubview:scrollView];
    scrollView.contentSize=CGSizeMake(320, 540);
    UIView*memberCenter=[[UIView alloc]init];
    memberCenter.frame=CGRectMake(0, 0, 320, 600);
    scrollView.userInteractionEnabled = YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.backgroundColor=[UIColor groupTableViewBackgroundColor];

    UIButton*memberCenter_name=[UIButton buttonWithType:UIButtonTypeCustom];
    memberCenter_name.userInteractionEnabled=NO;
    memberCenter_name.tag=1000;
    memberCenter_name.frame=CGRectMake(0, 10, 320, 70);
    memberCenter.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [memberCenter_name setImage:[UIImage imageNamed:@"memeber_headBack.png"] forState:UIControlStateNormal];
    
    [scrollView addSubview:memberCenter_name
     ];
    
    name_image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
//    name_image.backgroundColor=[UIColor blueColor];
    name_image.image=_severiceImage;
#pragma - mark 上传图片
    [self connectionURL];


    
    [memberCenter_name addSubview:name_image];
    
    name_string=[[UILabel alloc]initWithFrame:CGRectMake(55, 15, 250, 16)];
    //name_string.backgroundColor = [UIColor redColor];
    name_string.textColor = [UIColor colorWithRed:30.0/255 green:98.0/255 blue:167.0/255 alpha:1];
    name_string.font = [UIFont systemFontOfSize:15.5];
    name_string.text=[[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
    [memberCenter_name addSubview: name_string];
    
    name_style=[[UILabel alloc]initWithFrame:CGRectMake(55, 35, 100, 15)];
    
    name_style.text=self.name_style2;
    name_style.textColor = [UIColor grayColor];
    name_style.userInteractionEnabled=NO;
    name_style.font = [UIFont systemFontOfSize:14];
    [memberCenter_name addSubview:name_style];
    
    UIImageView*button1=[UIImageView new];
    button1.image=[UIImage imageNamed:@"mine_newsAndSet.png"];
    button1.userInteractionEnabled = YES;
    
    
    button1.tag=110;
    
    [scrollView addSubview:button1];
    
    UILabel*lable1=[[UILabel alloc]initWithFrame:CGRectMake(35, 0, 100, 40)];
    lable1.text=@"修改密码";
    [button1 addSubview:lable1];
    UIImageView *password = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];
    password.image = [UIImage imageNamed:@"password"];
    [button1 addSubview:password];
    
    UIImageView*button2=[UIImageView new];
    button2.image=[UIImage imageNamed:@"twoLongLine.png"];
    button2.backgroundColor = [UIColor whiteColor];
    button2.userInteractionEnabled = YES;
    
    
    button2.tag=111;
    [scrollView addSubview:button2];
    
    UILabel*lable2=[[UILabel alloc]initWithFrame:CGRectMake(130, 0, 70, 40)];
    //lable2.textColor=[UIColor whiteColor];
    lable2.text=@"退出登录";
    [button2 addSubview:lable2];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2) {
//        NSLog(@"客服页面");
        for (int i=0; i<2; i++) {
            UIImageView*button=[UIImageView new];
   
            
            button.image=[UIImage imageNamed:@"member_centerCenter"];
//            else button.image=[UIImage imageNamed:@"member_centerUpNo.png"];
            button.userInteractionEnabled = YES;
            
            button.frame=CGRectMake(0, 90+i*40, 320, 40);
            button.tag=200+i;
            
            [scrollView addSubview:button];
            
            
            UILabel*lable1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
            lable1.textColor=[UIColor grayColor];
            lable1.text=[array objectAtIndex:i];
            [button addSubview:lable1];
            
            
            UILabel*lable2=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 185, 40)];
            if ([[dataArray lastObject]length]>0)
            {
                lable2.text=[dataArray objectAtIndex:i];
            }
            
            lable2.tag=300+i;
            lable2.numberOfLines=1;
            //lable2.backgroundColor=[UIColor blueColor];
//            NSLog(@"%@lable2",self.textArray);
            [button addSubview:lable2];
            
        }
        button1.frame=CGRectMake(0, 180, 320, 40);
        button2.frame=CGRectMake(0, 230, 320, 40);

        //button2.userInteractionEnabled=NO;
    } else {
        NSLog(@"用户页面");
        for (int i=0; i<8; i++)
    {
        
        UIImageView*button=[UIImageView new];
        if (i==0)
        {
            button.image=[UIImage imageNamed:@"member_centerUpNo.png"];
        }
        else if(i==7)
        {
            button.image=[UIImage imageNamed:@"member_centerDown.png"];
        }
        else
        {
            button.image=[UIImage imageNamed:@"member_centerCenter.png"];
            
        }           
        button.userInteractionEnabled = YES;
        
        button.frame=CGRectMake(0, 90+i*40, 320, 40);
        button.tag=200+i;
        
        [scrollView addSubview:button];
        
        
        UILabel*lable1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
        lable1.textColor=[UIColor grayColor];
        lable1.text=[array objectAtIndex:i];
        
        [button addSubview:lable1];
        
        UILabel*lable2=[[UILabel alloc]initWithFrame:CGRectMake(100, 0, 185, 40)];
        if ([[dataArray lastObject]length]>0)
        {
            lable2.text=[dataArray objectAtIndex:i+1];
        }
        
        lable2.tag=300+i;
        lable2.numberOfLines=1;
        //lable2.backgroundColor=[UIColor blueColor];
//        NSLog(@"%@lable2",self.textArray);
        
        [button addSubview:lable2];
    }
        button1.frame=CGRectMake(0, 420, 320, 40);
        button2.frame=CGRectMake(0, 470, 320, 40);

    }
}

- (void)connectionURL
{
//    name_image.image=[UIImage imageNamed:@"defaultSmall.gif"];

    NSURL *url = [[NSURL alloc]initWithString:@"http://t.russia-online.cn/ListServicet.asmx/FileUploadImage"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    name_image.image = [UIImage imageNamed:@"酒店订单_01.png"];
    NSData *imageData = UIImagePNGRepresentation(name_image.image);

    NSLog(@"%@",imageData);

//    Byte *imgByte = (Byte *)[imageData bytes];
//    NSLog(@"%s" , imgByte);


    NSString *str = [NSString stringWithFormat:@"ImagefileName=twoLongLine.png&FileStream=%@",imageData];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}


//thouchesBegan 获取到touch的时间点
- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    self.touchTimer = [touch timestamp];
    NSLog(@"%s",__func__);
    
    
}


//touchesEnded，touch事件完成，根据此时时间点获取到touch事件的总时间，
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
    NSLog(@"sssssss%f",self.touchTimer);
    UITouch *touch = [touches anyObject];
    self.touchTimer = [touch timestamp]-self.touchTimer;
    NSLog(@"----%f",self.touchTimer);
    
    NSUInteger tapCount = [touch tapCount];
//    CGPoint touchPoint = [touch locationInView:scrollView];
    UIView*view=touch.view;
    //判断单击事件，touch时间和touch的区域
  
    if (tapCount == 1 && self.touchTimer <=0.2 &&[view isMemberOfClass:[UIImageView class]])
    {
        UIImageView*iamge=(UIImageView*)[self.view viewWithTag:view.tag];
        if (iamge.tag==200&&[[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2) {
            iamge.image=[UIImage imageNamed:@"member_centerCenter_h"];
        }
        
        if (iamge.tag!=200)
        {
            if (iamge.tag==207)
            {
                 iamge.image=[UIImage imageNamed:@"member_centerDown_h.png"];
            }
            else
            {
             iamge.image=[UIImage imageNamed:@"member_centerCenter_h"];
            
            }
           
        }

        [self performSelector:@selector(touch:) withObject:iamge afterDelay:0.1];
     
        
        //        [self touch];
        //进行单击的跳转等事件
    }
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    datas=[[NSMutableData alloc]init];
    mdata = [[NSMutableData alloc]init];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (conn != connection)
    {
        [datas appendData:data];
    }
    if (connection == conn)
    {
        [mdata appendData:data];
        NSLog(@"sssss%@",mdata);
    }
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"000000000");
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *image = [[NSString alloc]initWithData:mdata encoding:NSUTF8StringEncoding];
    NSLog(@"image = %@",image);
    
    dicResultYiBu(datas, result, dic)
    NSLog(@"%@",dic);
    if (result.length>11)
    {
         dic3=[[dic valueForKey:@"ds"]lastObject];
        NSLog(@"%@",dic3);
    }
    else
    {
        
        dic3=nil;
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2)
        {
            name_style.text=@"客服";
        }
    }
   
    


    if (dic3)
    {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2) {
            name_style.text=@"客服";
            dataArray = [NSMutableArray arrayWithObjects:[dic3 valueForKey:@"Email"],[dic3 valueForKey:@"Mobile"], nil];
            NSLog(@"%@",dataArray);
            for (int i=1; i<3; i++)
            {
                UILabel*lable=(UILabel*)[self.view viewWithTag:300+i-1];
                lable.text=[dataArray objectAtIndex:i-1];
            }
        }else{
            dataArray=[NSMutableArray arrayWithObjects:
                       [dic3 valueForKey:@"ImgTouX"],
                       [dic3 valueForKey:@"Email"],
                       [dic3 valueForKey:@"Mobile"],
                       [dic3 valueForKey:@"Gender"],
                       [dic3 valueForKey:@"Birthday"],
                       [dic3 valueForKey:@"Location"],
                       [dic3 valueForKey:@"Address"],
                       [dic3 valueForKey:@"Zip"],
                       [dic3 valueForKey:@"Introduce"], nil];
//            NSLog(@"%@",dataArray);
            for (int i=0; i<8; i++)
            {
                UILabel*lable=(UILabel*)[self.view viewWithTag:300+i];
                lable.text=[dataArray objectAtIndex:i+1];
                
            }
            switch ([[dic3 valueForKey:GUIDE_ID]intValue])
            {
                case 0:
                    name_style.text=@"普通会员";
                    break;
                case 1:
                    name_style.text=@"导游会员";
                    break;
                case 2:
                    name_style.text=@"司兼导(租车)会员";
                    break;
                case 3:
                    name_style.text=@"导游兼翻译会员";
                    break;
                case 4:
                    name_style.text=@"导游兼翻译(带车)会员";
                    break;
                default:
                    break;
            }
        }
        
        

    }else dataArray=nil;
    
   


}
-(void)touch:(id)sender
{
      UIImageView*iamgeView=(UIImageView*)sender;
    
    if (iamgeView.tag!=200)
    {
        if (iamgeView.tag==207)
        {
            iamgeView.image=[UIImage imageNamed:@"member_centerDown.png"];
        }
        else
        {
            iamgeView.image=[UIImage imageNamed:@"member_centerCenter"];
            
        }
        
    }
    if (iamgeView.tag==200&&[[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2)  iamgeView.image=[UIImage imageNamed:@"member_centerCenter"];
    NSLog(@"%d",iamgeView.tag);
       switch (iamgeView.tag)
    {
        case 110:
        {
            ModificViewController*second=[ModificViewController new];
            
            [self.navigationController pushViewController:second animated:NO];
            
//            UILabel*lable=(UILabel*)[self.view viewWithTag:111];
            second.pageTitle=@"修改密码";
//            second.phoneNum=lable.text;
            second.useID=self.useID;
//            [second setBlock:^(NSString *text)
//             {
//                 
//                 lable.text=text;
//                 
//             }];
            
        }
            
            break;
        case 200:
        {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2) {
                ModificViewController*second=[ModificViewController new];
                
                [self.navigationController pushViewController:second animated:NO];
                
                UILabel*lable=(UILabel*)[self.view viewWithTag:300];
                second.pageTitle=@"修改邮箱";
                second.mailNum=lable.text;
               if ([[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2)
               {
                   second.phoneNum=[(UILabel*)[self.view viewWithTag:301] text];
                   NSLog(@"[(UILabel*)[self.view viewWithTag:301] text]  %@",[(UILabel*)[self.view viewWithTag:301] text]);
               }
                second.useID=self.useID;
                [second setBlock:^(NSString *text)
                 {
                     
                     lable.text=text;
                     
                 }];
            }
         
            
        }
            break;
        case 201:
        {
            ModificViewController*second=[ModificViewController new];
            
            [self.navigationController pushViewController:second animated:NO];

            UILabel*lable=(UILabel*)[self.view viewWithTag:301];
            second.pageTitle=@"修改手机号";
            second.phoneNum=lable.text;
           if ([[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID] intValue]==2)
               second.mailNum = [(UILabel*)[self.view viewWithTag:300] text];
            
            second.useID=self.useID;
            [second setBlock:^(NSString *text)
            {
               
                lable.text=text;
                
            }];
         
        }
            break;
        case 202:
        {
            
            UIActionSheet*actionSheet=[[UIActionSheet alloc]initWithTitle:@"性别修改" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"男士" otherButtonTitles:@"女士",@"保密" ,nil];
            [actionSheet showInView:self.view];
            

            
          
        }
            break;
        case 203:
        {
            
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, DeviceHeight-266-40, 320, 200+40)];
            view.tag=10000;
            [self.view addSubview:view];
            UIButton*button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.tag=209;
            button.frame=CGRectMake(250, 5, 50, 30);
            [button setTitle:@"确定" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(pickData:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
            
            
            view.backgroundColor=[UIColor groupTableViewBackgroundColor];
            UIDatePicker*dataPicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, 320, 200)];
            
            dataPicker.tag=100;
            
             NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示3
            dataPicker.locale = locale;
//            dataPicker.locale=china;
//            dataPicker.calendar
//            dataPicker.backgroundColor=[UIColor blackColor];
            dataPicker.date=[NSDate date];
            dataPicker.datePickerMode=UIDatePickerModeDate;
            
            [view addSubview:dataPicker];
            
            NSLog(@"%@",dataPicker.date);
            
        }
            break;
        case 204:
        {
            CountryViewController*country1=[CountryViewController new];
            country1.title=@"修改地址";
    [self.navigationController pushViewController:country1 animated:NO];

            
            
        }
            break;

        case 205:
        {
            
            ModificViewController*second=[ModificViewController new];
            
            [self.navigationController pushViewController:second animated:NO];
            
            UILabel*lable=(UILabel*)[self.view viewWithTag:305];
            second.pageTitle=@"修改详细地址";
            second.phoneNum=lable.text;
            second.useID=self.useID;
            [second setBlock:^(NSString *text)
             {
                 
                 lable.text=text;
                 
             }];

            
        }
            break;
        case 206:
        {
            
            ModificViewController*second=[ModificViewController new];
            
            [self.navigationController pushViewController:second animated:NO];
            
            UILabel*lable=(UILabel*)[self.view viewWithTag:306];
            second.pageTitle=@"修改邮政编码";
            second.phoneNum=lable.text;
            second.useID=self.useID;
            [second setBlock:^(NSString *text)
             {
                 
                 lable.text=text;
                 
             }];
            
            
        }
            break;
        case 207:
        {
            
            ModificViewController*second=[ModificViewController new];
            
            [self.navigationController pushViewController:second animated:NO];
            
            UILabel*lable=(UILabel*)[self.view viewWithTag:307];
            second.pageTitle=@"修改个人介绍";
            second.phoneNum=lable.text;
            second.useID=self.useID;
            [second setBlock:^(NSString *text)
             {
                 
                 lable.text=text;
                 
             }];
            
            
        }
            break;

        case 111:
        {
        
        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:QUSE_ID];
        [defaults removeObjectForKey:USER_NAME];
        [defaults removeObjectForKey:GUIDE_ID];
        [defaults removeObjectForKey:TYPE_ID];
        [defaults removeObjectForKey:name_string.text];
        [defaults synchronize];
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] numberGo];
        [self.navigationController popToRootViewControllerAnimated:NO];

            
            
        }
            break;

        default:
            break;
    }

}
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component==0)
    {
        return 2;
    }
    else if(component==1)
    
    {
        
        return [provinces count];
    }
    
//      NSArray* cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
//       NSString* state = [[provinces objectAtIndex:0] objectForKey:@"state"];
//        self.locate.city = [cities objectAtIndex:0];
//
//        return [feelings_ count];
    
    else
        return [city count];

    
}

#pragma mark Picker Delegate Protocol

//设置当前行的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component==0)
    {
       self.local1=[country objectAtIndex:row];
        return [country objectAtIndex:row];
    }
//    if(component==1)
//    {
//        [provinces objectAtIndex:row];
//    }
    if(component==2)
    {
         self.local2=[city objectAtIndex:row];
         return [city objectAtIndex:row];
    }
    self.local3=[provinces objectAtIndex:row];
    return  [provinces objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component

{
    // 如果选取的是第一个选取器
    if (component == 0)
    {
        // 得到第一个选取器的当前行
     //   NSString *selectedState =[country  objectAtIndex:row];
        
        // 根据从pickerDictionary字典中取出的值，选择对应第二个中的值
//         a=[country indexOfObject:selectedState];
        
        [provinces removeAllObjects];
    for (int i=0; i<[[allArray objectAtIndex:row]  count]; i++)
        {
            [provinces addObject:[[[allArray objectAtIndex:row] objectAtIndex:i] objectForKey:@"state"]];
        }
//            provinces=[provinces objectAtIndex:row];
        
//          city=[[[allArray objectAtIndex:row] objectAtIndex:row]objectForKey:@"cities"];
//        singData=array;
        
        
        [pickerView selectRow:row inComponent:0 animated:YES];
//        [pickerView selectRow:row inComponent:1 animated:YES];
        city=[[[allArray objectAtIndex:[country indexOfObject:self.local1]] objectAtIndex:row]objectForKey:@"cities"];
        
        
        // 重新装载第二个滚轮中的值
         [pickerView reloadComponent:1];
         [pickerView reloadComponent:2];
    }
    if (component == 1)
    {

        city=[[[allArray objectAtIndex:[country indexOfObject:self.local1]] objectAtIndex:row]objectForKey:@"cities"];
        
        [pickerView selectRow:row inComponent:1 animated:YES];
        
        [pickerView reloadComponent:2];
    }


}

-(void)pickData:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 209:
        {
            UIDatePicker*picker=(UIDatePicker*)[self.view viewWithTag:100];
            NSDateFormatter*form=[NSDateFormatter new];
            form.dateFormat=@"YYYY年MM月dd日";
            NSString*str=[form stringFromDate:picker.date];
            
            UILabel*lable=(UILabel*)[self.view viewWithTag:303];
            lable.text=str;
            UIView*view=[self.view viewWithTag:10000];
            [view removeFromSuperview];
            
            NSString*str1=[NSString stringWithFormat:@"%d",self.useID];
            NSString *canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str1,@"",@"",str,@"",@"",@"",@""];//设置参数
            NSMutableString*urlDomain=RussiaUrl
            NSString*urlMethod=@"ModifyUserInfo";
            [urlDomain appendString:urlMethod];
            //postRequestTongBu(canshu, urlDomain, received)
          
            postRequestYiBu(canshu, urlDomain);
        
        }
            break;
        case 300:
        {
            [provinces removeAllObjects];
            for (int i=0; i<[[allArray objectAtIndex:0] count]; i++)
            {
                [provinces addObject:[[[allArray objectAtIndex:0] objectAtIndex:i] objectForKey:@"state"]];
            }

//            UIPickerView*picker=(UIPickerView*)[self.view viewWithTag:101];
//            [picker removeFromSuperview];
            UILabel*lable=(UILabel*)[self.view viewWithTag:304];
            NSString*local;
            if ([self.local1 isEqualToString:@"俄罗斯"]||[self.local3 isEqualToString:@"北京"]||[self.local3 isEqualToString:@"天津"]||[self.local3 isEqualToString:@"重庆"]||[self.local3 isEqualToString:@"上海"])
            {
                local=[NSString stringWithFormat:@"%@ %@",self.local1,self.local3];
            }
            else
            {
          
             local=[NSString stringWithFormat:@"%@ %@ %@",self.local1,self.local3,self.local2];
            }
          
            lable.text=local;
            UIView*view=[self.view viewWithTag:10001];
            [view removeFromSuperview];
            
            NSString*str1=[NSString stringWithFormat:@"%d",self.useID];
            NSString *canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str1,@"",@"",@"",local,@"",@"",@""];//设置参数
            NSMutableString*urlDomain=RussiaUrl
            NSString*urlMethod=@"ModifyUserInfo";
            [urlDomain appendString:urlMethod];
           // postRequestTongBu(canshu, urlDomain, received)
          postRequestYiBu(canshu, urlDomain);
            
            
        }
            break;
   
        default:
            break;
    }
  

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString*str=[NSString stringWithFormat:@"%d",self.useID];
     UILabel*lable=(UILabel*)[self.view viewWithTag:302];
  
    NSString* canshu;
     NSString*urlMethod=@"ModifyUserInfo";
    NSMutableString*urlDomain=RussiaUrl
  
    [urlDomain appendString:urlMethod];


    switch (buttonIndex)
    {
       
        case 0:
        {
            NSLog(@"---------");
            

            lable.text=@"男士";
           
             canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str,@"",@"男士",@"",@"",@"",@"",@""];
          //  postRequestTongBu(canshu, urlDomain, received)
            postRequestYiBu(canshu, urlDomain);
            
        }
            break;
        case 1:
        {
//              NSLog(@"!!!!!!!!");
             lable.text=@"女士";
          
                canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str,@"",@"女士",@"",@"",@"",@"",@""];
          
          //  postRequestTongBu(canshu, urlDomain, received)
             postRequestYiBu(canshu, urlDomain);
        }
            break;
        case 2:
        {
            lable.text=@"保密";
          
              canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str,@"",@"保密",@"",@"",@"",@"",@""];
         
           // postRequestTongBu(canshu, urlDomain, received)
             postRequestYiBu(canshu, urlDomain);
        }

        
            break;
            
        default:
            break;
    }



}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
