//
//  MoreViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MoreViewController.h"
#import "Navbar.h"
#import "GDataXMLNode.h"
#import "json.h"
#import "fwView.h"
#import "bqView.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

-(void)viewWillAppear:(BOOL)animated
{
    Navbar *bar = (Navbar *)self.navigationController.navigationBar;
    bar.cusBarStyele = UIBarStyleBlackOpaque;
 
    [self.navigationItem setNewTitle:@"更多"];
    MainTabarController*main=(MainTabarController*)self.tabBarController;
    main.customizedBar.hidden=NO;
    datas = [NSMutableData data];
   

}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [datas appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    dicResultYiBu(datas, result, dic)
    NSLog(@"dic %@",dic);
    if (result.length>11) {
        _dataArr = [dic objectForKey:@"ds"];
        NSLog(@"dataArr  %@",_dataArr);
        UIView*viewPush=[[UIView alloc]initWithFrame:CGRectMake(0, 220, 300, 130)];
        [scroll addSubview:viewPush];
        UILabel*introLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
        introLable.backgroundColor=[UIColor clearColor];
        
        introLable.text=@"推荐应用";
       // introLable.textColor = [UIColor blueColor];
        introLable.font=[UIFont boldSystemFontOfSize:15];
        [viewPush addSubview:introLable];
        
        int row = _dataArr.count%3==0?(int)_dataArr.count/3:(int)_dataArr.count/3+1;
        UIImageView*imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 300, 115*row)];
        imageview2.image=[UIImage imageNamed:@"more_ recomm.png"];
        imageview2.userInteractionEnabled=YES;
        [viewPush addSubview:imageview2];
        for (int i=0; i<_dataArr.count; i++)
        {
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(20+100*(i%3), 10+(i/3)*110, 60, 60);
            button.tag=i;
            [button addTarget:self action:@selector(goStore:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.titleEdgeInsets = UIEdgeInsetsMake(65, -18, -25, -18);
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            dispatch_async(dispatch_get_global_queue(2, 0), ^{
                //http://192.168.0.156:805/upload/apps/201405231043532042.jpg
                NSString *urlStr = [NSString stringWithFormat:@"http://t.russia-online.cn/upload/apps/%@",[_dataArr[i] objectForKey:@"AppImage2"]];//小图
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
                UIImage *image = [UIImage imageWithData:data];
                NSString *tittle = [NSString stringWithFormat:@"%@",[_dataArr[i] objectForKey:@"AppName"]];
                if (tittle.length>6) {
                    button.titleLabel.numberOfLines=2;
                    button.titleEdgeInsets = UIEdgeInsetsMake(80, -18, -25, -18);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [button setBackgroundImage:image forState:UIControlStateNormal];
                    [button setTitle:tittle forState:UIControlStateNormal];
                    
                });
            });
            
            
            [imageview2 addSubview:button];
        }
        viewPush.frame = CGRectMake(0, 220, 300, 50+115*row);
        view2.frame = CGRectMake(0, viewPush.frame.origin.y+viewPush.frame.size.height, 320, 350);
        scroll.contentSize = CGSizeMake(320, 650+115*row);
    
    }
}
- (void)goStore:(UIButton*)btn{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[_dataArr[btn.tag] objectForKey:@"AppUrl"]]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    Navbar *bar = (Navbar *)self.navigationController.navigationBar;
    bar.cusBarStyele = UIBarStyleBlackOpaque;
    bar.stateBarColor = [UIColor blackColor];
    

     self.navigationController.navigationBar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"top.png"]];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-20-44)];
    scroll.contentSize=CGSizeMake(DeviceWidth, 600);
     if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
     {
      scroll.contentSize=CGSizeMake(DeviceWidth, 800);
         self.hidesBottomBarWhenPushed=YES;

     }
    scroll.bounces=YES;
    scroll.pagingEnabled=NO;
    scroll.userInteractionEnabled=YES;
    scroll.delaysContentTouches=NO;
    //    [scroll delaysContentTouches:NO];
    [self.view addSubview:scroll];
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    [self.view addSubview:view];
    [scroll addSubview:view];
    UIImageView*log=[[UIImageView alloc]initWithFrame:CGRectMake(10, 21, 60, 60)];
    log.image=[UIImage imageNamed:@"120.png"];
    [view addSubview:log];
    UILabel*tittle=[[UILabel alloc]initWithFrame:CGRectMake(84, 11, 171, 39)];
    tittle.font=[UIFont systemFontOfSize:16];
    tittle.text=@"圣彼得堡旅游指南V1.0";
    [view addSubview:tittle];
    UILabel*descrip=[[UILabel alloc]initWithFrame:CGRectMake(84, 40,206, 20)];
    descrip.numberOfLines=2;
    descrip.font=[UIFont systemFontOfSize:13];
    descrip.text=@"最贴近你的俄罗斯旅游中文资讯网";
    
    
    //    ©2013俄旅网
    [view addSubview:descrip];
    
    UILabel*descrip2=[[UILabel alloc]initWithFrame:CGRectMake(84, 60,206, 20)];
    descrip2.numberOfLines=2;
    descrip2.font=[UIFont systemFontOfSize:13];
    descrip2.text=@"©2014俄旅网";
    
     float bold=100;
      float size=15;
    //    ©2013俄旅网
    [view addSubview:descrip2];
    
    UILabel*about=[[UILabel alloc]initWithFrame:CGRectMake(10,95,49, 30)];
    about.text=@"关于";
    about.font=[UIFont boldSystemFontOfSize:size];
    [view addSubview:about];

    //    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 120, 300, 80)];
    //    imageView.userInteractionEnabled=YES;
    //    imageView.image=[UIImage imageNamed:@"更多01_03.png"];
    NSArray*lableArray=[NSArray arrayWithObjects:@"版权信息",@"服务条例", nil];
    //    [self.view addSubview:imageView];
    for (int i=0; i<2; i++)
    {
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        //    [button setImage:[UIImage imageNamed:@"空白.png"] forState:UIControlStateNormal];
        //    [button setTitle:@"法律声明" forState:UIControlStateNormal];
        button.frame=CGRectMake(10, 130+80/2*i, 300,80/2);
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(10 ,0, 200, 80/2)];
        lable.backgroundColor=[UIColor clearColor];
        if (i==0)
        {
            [button setBackgroundImage:[UIImage imageNamed:@"more_up"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"more_up_h"] forState:UIControlStateHighlighted];
        }
               else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"more_down"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"more_down_h"] forState:UIControlStateHighlighted];
            
        }
        button.tag=110+i;
        //    button.backgroundColor=[UIColor whiteColor];
        lable.text=[lableArray objectAtIndex:i];
        lable.font=[UIFont boldSystemFontOfSize:15];
        lable.backgroundColor=[UIColor clearColor];
        [button addSubview:lable];
        //        [imageView addSubview:button];
        
        //        UIImageView*imageViewPic=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10+1, 20, 250.0/6-10-10-2)];
        //        imageViewPic.image=[imageArray objectAtIndex:i];
        //        //    [button setImage:[UIImage imageNamed:@"招商引资.png"] forState:UIControlStateNormal];
        //        [button addSubview:imageViewPic];
        [button addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:button];
        
    }
    
    
    
    view2=[[UIView alloc]initWithFrame:CGRectMake(0, 220, DeviceWidth, 350)];
    [scroll addSubview:view2];
    UILabel*contactLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, DeviceWidth, 30)];
    contactLable.text=@"联系我们";
     contactLable.font=[UIFont boldSystemFontOfSize:size];
    contactLable.backgroundColor=[UIColor clearColor];
    [view2 addSubview:contactLable];
    
    UIImageView*imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(10, 37, 300, 300)];
    imageview3.image=[UIImage imageNamed:@"more_contact.png"];
    imageview3.userInteractionEnabled=YES;
    [view2 addSubview:imageview3];
    UIImageView*imageView4=[[UIImageView alloc]initWithFrame:CGRectMake(75, 10, 150, 50)];
    imageView4.image=[UIImage imageNamed:@"more_LOGO.png"];
    [imageview3 addSubview:imageView4];
    NSArray*array=[NSArray arrayWithObjects:@"网址：",@"电话：",@"联系QQ：159899899",@"邮箱：Severice@Russia-Online.cn", nil];
    
    
    for (int i=0; i<4; i++)
    {
        UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 81+39*i, 250, 40)];
        lable.backgroundColor=[UIColor clearColor];
        [imageview3 addSubview:lable];
        lable.text=[array objectAtIndex:i];
        lable.backgroundColor=[UIColor clearColor];
        lable.font=[UIFont systemFontOfSize:13];
        if (i==0)
        {
            lable.userInteractionEnabled=YES;
            UIButton*urlButton=[UIButton buttonWithType:UIButtonTypeCustom];
            urlButton.tag=10;
            
            [urlButton addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            UILabel*lable2=[[UILabel alloc]initWithFrame:CGRectMake(0, 2, 200, 32)];
            lable2.text=@"www.Rusia-Online.cn";
            lable2.font=[UIFont systemFontOfSize:13];
            lable2.textColor=[UIColor blueColor];
            [urlButton addSubview:lable2];
            urlButton.frame=CGRectMake(40, 0, 200, 32);
            [lable addSubview:urlButton];
        }
        if (i==1)
        {
            UIImageView*image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 32-10)];
            image.image=[UIImage imageNamed:@"more_tele.png"];
            lable.userInteractionEnabled=YES;
            UIButton*urlButton=[UIButton buttonWithType:UIButtonTypeCustom];
            urlButton.tag=11;
            urlButton.frame=CGRectMake(155, 35+95, 290-170-10-10, 32);
            UILabel*lable3=[[UILabel alloc]initWithFrame:CGRectMake(20, -3, 80, 32)];
            lable3.text=@"立即拨打";
            lable3.backgroundColor=[UIColor clearColor];
            lable3.textColor=[UIColor blueColor];
            lable3.font=[UIFont systemFontOfSize:15];
            [urlButton addSubview:lable3];
            [urlButton addSubview:image];
            UILabel*lable2=[[UILabel alloc]initWithFrame:CGRectMake(50, 32+95, 200, 32)];
            lable2.text=@"020-38056258";
            lable2.backgroundColor=[UIColor clearColor];
            lable2.font=[UIFont systemFontOfSize:13];
            lable2.textColor=[UIColor blueColor];
            [imageview3 addSubview:lable2];
            [urlButton addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            [imageview3 addSubview:urlButton];
        }
        
        
    }
    UILabel*lablee=[[UILabel alloc]initWithFrame:CGRectMake(0, 240, 300, 58)];
    
    [imageview3 addSubview:lablee];
    lablee.text=@"欢迎各类旅游商务合作";
    lablee.textAlignment=NSTextAlignmentCenter;
    lablee.backgroundColor=[UIColor clearColor];
    lablee.font=[UIFont systemFontOfSize:20];
    scroll.delaysContentTouches=YES;
     postRequestYiBu(@"appname=玩转圣彼得堡" , @"http://t.russia-online.cn/ListServiceg.asmx/getAppsList")
	// Do any additional setup after loading the view.
}
-(void)touch:(UIButton*)sender
{
    //NSLog(@"2222");
    switch (sender.tag)
    {
        case 10:
        {
            NSLog(@"111111");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.russia-online.cn"]];
            
        }
            break;
        case 11:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://02038056258"]];
            
        }
            break;
        case 120:
        {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/cn/app/e-luo-si-lu-you-zhong-wen-wang/id795666578?mt=8"]];
            
        }
            break;
            
        case 110:
        {
            
            [self performSelector:@selector(push:) withObject:sender afterDelay:0.1];
                [sender setImage:[UIImage imageNamed:@"上b.png"] forState:UIControlStateNormal];
            
        }
            break;
        case 111:
        {
            [self performSelector:@selector(push:) withObject:sender afterDelay:0.1];
            [sender setImage:[UIImage imageNamed:@"下b.png"] forState:UIControlStateNormal];
            
         
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
}

-(void)push:(UIButton*)sender
{
    
    if (sender.tag==111)
    {
        //[sender setImage:[UIImage imageNamed:@"下.png"] forState:UIControlStateNormal];
        fwView*zs=[fwView new];
        [self.navigationController pushViewController:zs animated:NO];
        return;
    }

      //[sender setImage:[UIImage imageNamed:@"上.png"] forState:UIControlStateNormal];
    bqView*zs=[bqView new];
    [self.navigationController pushViewController:zs animated:NO];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
