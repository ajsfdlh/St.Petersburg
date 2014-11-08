//
//  DetailViewController.m
//  Sochi
//
//  Created by 刘 吕琴 on 14-1-22.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView*webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    [self.view addSubview:webView];
    webView.dataDetectorTypes=UIDataDetectorTypeNone;
    webView.backgroundColor=[UIColor whiteColor];
    [self.navigationItem setNewTitle:self.pagetitle];

  
   
    
    
    [ webView loadRequest:nil];
//    detailHeadtitle(head1, [self.head objectAtIndex:0 ])
// 
//    
//    
//    Russian(russia1, [self.russia objectAtIndex:0])
//    picStr(pic1, [self.pic objectAtIndex:0])
//    detailtitle(introduce1, [self.introduce objectAtIndex:0])
//    address(address1, [self.address objectAtIndex:0])

    
         NSString *htmlStrAll;
//        htmlStrAll=[[NSString alloc] initWithFormat:@"<html><head><title></title></head><link rel=\"stylesheet\" href=\"web.css\" type=\"text/css\"/><body>%@%@<br><br><br></body></html>",pic1,traffic];
              [WebView loadHTMLString:webView andString:htmlStrAll];
    
        [WebView loadHTMLString:webView andString:htmlStrAll];
    
    
	// Do any additional setup after loading the view.
}
backButton
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
