//
//  WebView.m
//  Sochi
//
//  Created by 刘 吕琴 on 14-1-22.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "WebView.h"

@implementation WebView
+(UIWebView*)prodouctWebView
{
    UIWebView*webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight-20)];
    webView.scrollView.bounces=YES;
    webView.opaque = NO;
    webView.backgroundColor=[UIColor clearColor];
    //这行能在模拟器下明下加快 loadHTMLString 后显示的速度，其实在真机上没有下句也感觉不到加载过程
    webView.dataDetectorTypes = UIDataDetectorTypeAll;

    return webView;
}
+(void)loadHTMLString:(UIWebView*)webView andString:(NSString*)htmlStrAll

{
    NSString *path=[[NSBundle mainBundle] bundlePath];
    NSURL *baseURL=[NSURL fileURLWithPath:path];
    [webView loadHTMLString:htmlStrAll baseURL:baseURL]; //在 WebView 中显示本地的字符串
    
}
+(NSMutableString *)ArangeContent:(NSString*)string
{
    NSMutableString *str=[[NSMutableString alloc] init];
    NSArray *arr=[string componentsSeparatedByString:@"\n"];
    //NSLog(@"qqq%@",arr);
    for (NSString *s in arr)
    {
        // NSLog(@"%@",s);
        NSString *ss=[s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [str appendFormat:@"<div class=\"sectionDistance\" id=\"pad1\">%@</div>",ss];
        //          [str appendFormat:@"%@",ss];
    }
    return str ;
}

@end
