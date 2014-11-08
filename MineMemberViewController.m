//
//  MineMemberViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-12.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MineMemberViewController.h"
#import "JSON.h"
#import "GDataXMLNode.h"
#import "MineDetailViewController.h"
#import "NewsViewController.h"
@interface MineMemberViewController ()

@end

@implementation MineMemberViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
     [self.navigationItem setNewTitle:@"会员中心"];
    appearTabbar
   // navbar
    NSUserDefaults*defaults=[NSUserDefaults standardUserDefaults];
    int b=[defaults integerForKey:QUSE_ID];
    
    NSString *str;
    if (b)
    {
        str=[NSString stringWithFormat:@"uid=%d",b];//设置参数
        self.useID=b;
    }
    
    NSMutableString*urlDomain=RussiaUrl
    NSString*urlMethod=@"getUserInfo";
    [urlDomain appendString:urlMethod];
    postRequestYiBu(str, urlDomain)

}
- (void)viewDidLoad
{
    [super viewDidLoad];
 
	// Do any additional setup after loading the view.
}
postRequestAgency(datas)
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    dicResultYiBu(datas, result, dic)
    dic3=[[dic valueForKey:@"ds"]lastObject];
    NSLog(@"result===%@",result);
//    NSString*Sex=[dic3 valueForKey:@"Sex"];
    //        NSLog(@"-------------name=%@",name);
//    NSLog(@"-------------Sex=%@",Sex);
//    NSLog(@"-------------dic3=%@",dic3);
    
    
    
    array=[NSMutableArray arrayWithObjects:[dic3 valueForKey:@"ImgTouX"],[dic3 valueForKey:@"Email"],[dic3 valueForKey:@"Mobile"],[dic3 valueForKey:@"Gender"],[dic3 valueForKey:@"Birthday"],[dic3 valueForKey:@"Location"],[dic3 valueForKey:@"Address"],[dic3 valueForKey:@"Zip"],[dic3 valueForKey:@"Introduce"], nil];
    
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
-(void)touch:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 1000:
        {

//     NSLog(@"----======%@",array);
            
            MineDetailViewController*detail=[MineDetailViewController new];
            [self.navigationController pushViewController:detail animated:NO];
            detail.pageTitle=@"我的账号";

            
    
        }
            break;
            
        case 13:
        {
            
            NSLog(@"酒店订单----======%@",array);
            
            NewsViewController*detail=[NewsViewController new];
            [self.navigationController pushViewController:detail animated:NO];

            
            
        }
            break;
            
        default:
            break;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
