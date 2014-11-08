//
//  NeighboViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-1-14.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "NeighboViewController.h"
#import "Navbar.h"
@interface NeighboViewController ()

@end

@implementation NeighboViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(0, (DeviceHeight-64)/2, 320, 40)];
    lable.text=@"系统完善中...";
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont systemFontOfSize:25];
    [self.view addSubview:lable];
   
    
   
//
	// Do any additional setup after loading the view.
}
-(void)netChange:(NSNotification*)sender
{
    Reachability*reach=[sender object];
    Data*_data=[Data shareNet];
    _data.rea =reach;
    if ([reach currentReachabilityStatus]==NotReachable)
    {
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败，请检查手机网络状态" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    appearTabbar
//    navbar
    [self.navigationItem setNewTitle:@"附近"];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
