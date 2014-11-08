//
//  EmergencyViewController.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-21.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "EmergencyViewController.h"

@interface EmergencyViewController ()

@end

@implementation EmergencyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
backButton
-(void)viewWillAppear:(BOOL)animated
{
    hideTabbar
    
    [self.navigationItem setNewTitle:self.navibarName];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    int count=3;
    self.view.backgroundColor=GroupColor;
    for (int i=0; i<count; i++)
    {
        UIButton*imageView=[[UIButton alloc]initWithFrame:CGRectMake(10, 10+79*i, 300, 69)];
        imageView.tag=10+i;
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"energy%d.png",i+1]] forState:UIControlStateNormal];
//        imageView.backgroundColor=[UIColor whiteColor];
             [self.view addSubview:imageView];
        
        
         [imageView addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
       
        
        
    }
    
    
    
    
	// Do any additional setup after loading the view.
}


-(void)touch:(UIButton*)sender
{
//    UILabel*lable=(UILabel*)[self.view viewWithTag:sender.tag];
//    NSString*str=lable.text;
//
//    NSLog(@"---------");
    NSString*tele;
    if (sender.tag==10)
    {
         tele=[NSString stringWithFormat:@"tel://%@",@"007(812)7138009"];
    }
    if (sender.tag==11)
    {
        tele=[NSString stringWithFormat:@"tel://%@",@"007(812)3329149"];
    }
    if (sender.tag==12)
    {
        tele=[NSString stringWithFormat:@"tel://%@",@"007(911)9248199"];
    }

    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tele]];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
