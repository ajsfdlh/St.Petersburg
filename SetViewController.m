//
//  SetViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-3-11.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{

    hideTabbar
    [self.navigationItem setNewTitle:@"设置"];

}
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
   UIImageView*imageView1=[UIImageView new];
    imageView1.frame=CGRectMake(0, 10, 320, 40);
    imageView1.image=[UIImage imageNamed:@"mine_news.png"];
    imageView1.userInteractionEnabled=YES;
    
    UISwitch*switchs=[[UISwitch alloc]initWithFrame:CGRectMake(240, 5, 51, 31)];
    switchs.tag=10;
    [switchs addTarget:self action:@selector(touch:) forControlEvents:UIControlEventValueChanged];
    NSLog(@"height====%f",switchs.frame.size.width);
    
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    switchs.on=[defaults boolForKey:@"switch"];
    [imageView1 addSubview:switchs];
    
//    [imageView1 setImage:[UIImage imageNamed:@"mine_news.png"] forState:UIControlStateNormal];
    
    UILabel*lable1=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 150, 40)];
    lable1.text=@"图片显示智能切换";
    
    [imageView1 addSubview:lable1];
    

    
    [self.view addSubview:imageView1];
  
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(15, imageView1.frame.origin.y+imageView1.frame.size.height, 250, 20)];
    lable.text=@"非wifi模式下将自动切换到不显示图片模式";
    lable.textColor=[UIColor grayColor];
    lable.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:lable];
    
    
    UIButton*imageView2=[UIButton buttonWithType:UIButtonTypeCustom];
    imageView2.tag=11;
    imageView2.frame=CGRectMake(0, lable.frame.origin.y+lable.frame.size.height+30, 320, 40);
    
    [imageView2 addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    UILabel*lable2=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 40)];
    lable2.text=@"清除缓存";
    
    [imageView2 addSubview:lable2];
    

    [imageView2 setImage:[UIImage imageNamed:@"mine_newsAndSet.png"] forState:UIControlStateNormal];
     [imageView2 setImage:[UIImage imageNamed:@"mine_newsAndSet_h.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:imageView2];
    
    
    
	// Do any additional setup after loading the view.
}
-(void)touch:(id)sender
{

    UIButton*button=(UIButton*)sender;
    UISwitch*switchs=(UISwitch*)sender;
    
    if (button.tag==11)
    {
        UIAlertView*alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alertView show];
    }
    if (switchs.tag==10)
    {
        
        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
        [defaults setBool:switchs.on forKey:@"switch"];
        [defaults synchronize];
    }
    
    
    
    


}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex==0)
    {
        NSFileManager*fg=[NSFileManager defaultManager];
       
        
        //[[NSURLCache sharedURLCache]removeAllCachedResponses];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@",cachePath);
       
       // NSMutableData *data = [NSMutableData dataWithContentsOfFile:PathOfFile(@"")];
//        NSData *cachesData = [NSData dataWithContentsOfFile:cachePath];
//        [data appendData:cachesData];
       // NSLog(@"data.length  %lu",(unsigned long)data.length);
       // [fg removeItemAtPath:PathOfFile(@"") error:nil];
        [fg removeItemAtPath:cachePath error:nil];
        // [[LineViewController new] filePath:fileName]
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
