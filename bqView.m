//
//  bqView.m
//  Russia Online
//
//  Created by 刘 吕琴 on 13-12-21.
//  Copyright (c) 2013年 Jiayi. All rights reserved.
//

#import "bqView.h"
#import "MainTabarController.h"

@interface bqView ()

@end

@implementation bqView

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
  
    // Do any additional setup after loading the view from its nib.
}
backButton
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //定义返回按钮
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
  
    hideTabbar
 [self.navigationItem setNewTitle:@"版权信息"];
 //    [self.view addSubview:scrlloView];
    
    UIWebView*webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight+49)];
    webView.scrollView.bounces=YES;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
    {
        webView.frame=CGRectMake(0, 0, 320, DeviceHeight+49+49);
      

        
    }

    webView.scrollView.bounces=YES;
    webView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:webView];
    NSString*str2=@"版权信息";
    NSString *htmlString2=[[NSString alloc] initWithFormat:@"<div class=\"haha1\" id=\"pad\">%@</div>",str2];

    NSString*str1=@" 1、本网所有内容，凡注明“来源：俄罗斯旅游中文网”的所有文字、图片和音视频资料，版权均属俄罗斯旅游中文网所有，任何媒体、网站或个人未经本网协议授权不得转载、链接、转贴或以其他方式复制发布/发表。已经本网协议授权的媒体、网站，在下载使用时必须注明“来源：俄罗斯旅游中文网”，违者本网将依法追究责任。\n\n    凡本网注明“来源：XXX ”的文/图等内容，本网转载出于传递更多信息之目的，并不意味着赞同其观点或证实其内容的真实性。\n\n    2、转载或引用本网内容必须是以新闻性或资料性公共免费信息为使用目的的合理、善意引用，不得对本网内容原意进行曲解、修改，同时必须保留本网注明的“稿件来源”，并自负版权等法律责任。\n\n    3、转载或引用本网内容不得进行如下活动：\n\n    a. 损害本网或他人利益;\n\n    b. 任何违法行为;\n\n    c. 任何可能破坏公秩良俗的行为;\n\n    d. 擅自同意他人继续转载、引用本网内容。\n\n    4、转载或引用本网版权所有之内容须注明“转自(或引自) 俄罗斯旅游中文网”字样，并标明本网网址www.Russia-Online.cn\n\n    5、转载或引用本网中的署名文章，请按规定向作者支付稿酬。\n\n    6、对于不当转载或引用本网内容而引起的民事纷争、行政处理或其他损失，本网不承担责任。\n\n    7、本网以“法定许可”方式使用作品的报酬。\n\n    8、对不遵守本声明或其他违法、恶意使用本网内容者，本网保留追究其法律责任的权利。\n\n    9、如俄罗斯旅游中文网的内容侵犯到您的合法权益，请联系我们，我们将在24小时内确认并清理。联系电话为：020-38056258。 ";
    NSString *htmlString1=[[NSString alloc] initWithFormat:@"<div class=\"title3\" id=\"pad\">%@</div>",[WebView ArangeContent:str1]];
    
    NSString *htmlStrAll;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)
    {
        htmlStrAll=[[NSString alloc] initWithFormat:@"<html><head><title></title></head><link rel=\"stylesheet\" href=\"web.css\" type=\"text/css\"/><body>%@%@<br><br><br><br></body></html>",htmlString2,htmlString1];
    }
    else
    {
    
      htmlStrAll=[[NSString alloc] initWithFormat:@"<html><head><title></title></head><link rel=\"stylesheet\" href=\"web.css\" type=\"text/css\"/><body>%@%@<br><br><br><br><br><br><br><br><br><br></body></html>",htmlString2,htmlString1];
    
    
    }
   
    //    NSString*str3=@"<#string#>"
    
    NSString *path=[[NSBundle mainBundle] bundlePath];
    NSURL *baseURL=[NSURL fileURLWithPath:path];
    [webView loadHTMLString:htmlStrAll baseURL:baseURL]; //在 WebView 中显示本地的字符串
    
    UILabel*newLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    newLable.text=@"    版权声明";
    newLable.font=[UIFont boldSystemFontOfSize:15];
      
    //        self.navigationItem.backBarButtonItem = backItem;
    
    //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"custom" style:UIBarButtonItemStylePlain target:self action:nil];
    //    [self.navigationItem.backBarButtonItem setImage:[UIImage imageNamed:@"jian.png"]];
    //    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    
}
-(void)NavPopControllerSelf
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
