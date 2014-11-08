//
//  WebView.h
//  Sochi
//
//  Created by 刘 吕琴 on 14-1-22.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebView : NSObject
+(UIWebView*)prodouctWebView;
+(void)loadHTMLString:(UIWebView*)webView andString:(NSString*)htmlStrAll;
+(NSMutableString *)ArangeContent:(NSString*)string;
//+(MainTabarController*)hideTabb;
@end
