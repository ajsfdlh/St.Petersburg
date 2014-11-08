//
//  ProvinceViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "ProvinceViewController.h"

@interface ProvinceViewController ()

@end

@implementation ProvinceViewController

backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    float x=5;
    float y=-20;

    float width=320-2*x;
     NSArray*file = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    provinces=[NSMutableArray new];
    
    for (int i=0; i<[file count]; i++)
    {
        [provinces addObject:[[file objectAtIndex:i] objectForKey:@"state"]];
    }

    province=[NSArray arrayWithObjects:@"莫斯科",@"圣彼得堡",@"索契", nil];
    UITableView*tabView=[[UITableView alloc]initWithFrame:CGRectMake(x, y, width, DeviceHeight) style:UITableViewStyleGrouped];
    tabView.delegate=self;
    tabView.dataSource=self;
     tabView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:tabView];
    
	// Do any additional setup after loading the view.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.pageName isEqualToString:@"中国"])
    {
        return [provinces count];

    }
    
    return [province count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString*str=@"cell";
    CustomCell*cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    if ([self.pageName isEqualToString:@"俄罗斯"])
 {
//        NSLog(@"%@",[province objectAtIndex:indexPath.row]);
        cell.lable.text=[province objectAtIndex:indexPath.row];
        cell._imageView.image=[UIImage imageNamed:@"memeber_headBack.png"];
        cell._imageView.highlightedImage=[UIImage imageNamed:@"LocationRussia.png"];
    }
    if ([self.pageName isEqualToString:@"中国"])
    {
          cell.lable.text=[provinces objectAtIndex:indexPath.row];
          if (indexPath.row==0||indexPath.row==1||indexPath.row==2||indexPath.row==3)
          {
          
              cell._imageView.image=[UIImage imageNamed:@"memeber_headBack.png"];
              cell._imageView.highlightedImage=[UIImage imageNamed:@"LocationRussia.png"];
          
          }
        
        else
        {
      
        cell._imageView.image=[UIImage imageNamed:@"memeber_headBackground.png"];
       cell._imageView.highlightedImage=[UIImage imageNamed:@"memeber_headBackground_h.png"];
     
        }
    }

   
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.pageName isEqualToString:@"俄罗斯"])
    {
        NSString*str=[NSString stringWithFormat:@"%@ %@",self.pageName,[province objectAtIndex:indexPath.row]];

        Location*location=[Location shareLocation];
        location.location=str;
        
        NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
        
        NSString*str1=[NSString stringWithFormat:@"%d", [defaults integerForKey:@"QuseID"] ];
        NSLog(@"%@---",str1);
        NSString *canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str1,@"",@"",@"",str,@"",@"",@""];//设置参数
        NSMutableString*urlDomain=RussiaUrl
        NSString*urlMethod=@"ModifyUserInfo";
        [urlDomain appendString:urlMethod];
       // postRequestTongBu(canshu, urlDomain, received)
        NSURL*url=[[NSURL alloc]initWithString:urlDomain];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod:@"POST"];
        NSData *data = [canshu dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        [[[NSURLConnection alloc]initWithRequest:request delegate:nil] start];
        
       
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];
        

    }
    else
    {
         if (indexPath.row==0||indexPath.row==1||indexPath.row==2||indexPath.row==3)
         {
         
             NSString*str=[NSString stringWithFormat:@"%@ %@",self.pageName,[provinces objectAtIndex:indexPath.row]];
             
             Location*location=[Location shareLocation];
             location.location=str;
             
             NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
             
             NSString*str1=[NSString stringWithFormat:@"%d", [defaults integerForKey:@"QuseID"] ];
             NSString *canshu=[NSString stringWithFormat:@"uid=%@&mobile=%@&sex=%@&birthday=%@&location=%@&address=%@&zip=%@&persondes=%@",str1,@"",@"",@"",str,@"",@"",@""];//设置参数
             NSMutableString*urlDomain=RussiaUrl
             NSString*urlMethod=@"ModifyUserInfo";
             [urlDomain appendString:urlMethod];
            // postRequestTongBu(canshu, urlDomain, received)
            NSURL*url=[[NSURL alloc]initWithString:urlDomain];
             NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
             [request setHTTPMethod:@"POST"];
             NSData *data = [canshu dataUsingEncoding:NSUTF8StringEncoding];
             [request setHTTPBody:data];
             [[[NSURLConnection alloc]initWithRequest:request delegate:nil] start];
             [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:NO];


         
         }
    else
    {
    
        CityViewController*city=[CityViewController new];
        city.indexth=indexPath.row;
        city.province=[provinces objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:city animated:NO];
    }
       
    
    }
    
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
