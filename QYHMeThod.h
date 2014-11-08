//
//  QYHMeThod.h
//  QYHMethod
//
//  Created by 刘 吕琴 on 14-5-7.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface QYHMeThod : UIViewController<NSURLConnectionDataDelegate>
// 图文混排方法可以识别lable的标签   此方法需导入RTLable.h
#define FontSize 15
#define LineSpacing 10
#define LableWidth 300
#define LableX 10
#define ImageWidth 300
@property(assign,nonatomic)float l;
+(float)creatTextImage:(NSArray*)TextArray andImageArray:(NSArray*)ImageArray andSuperView:(UIView*)view andViewHeight:(float)a;
//类似地图的效果，地图放大，大头针大小位置不变 大头针需插在ImageView上
+(void)ScrollMap:(UIImageView*)imageView andScrollView:(UIScrollView*)scrollView andButtonOriginalPointArray:(NSArray*)pointArray andSelfView:(UIView*)view;
//类似地图的效果，点击大头针时视图位置偏移到以大头针位中点 大头针需插在ImageView上
+(void)touchMove:(UIButton*)pin andImageView:(UIImageView*)imageView andScrollView:(UIScrollView*)scrollView andSelfView:(UIView*)view;
#define PinWidth 10
#define PinHeight 10
#define OffsetX 60
#define OffsetY 0
#define NavBarAndStateHeight 64
//拦截网页图片  并修改图片大小
#define ImageWidth 300
+(void)changeImageWidthHeight:(UIWebView*)webView;

//多线程下载置顶图片

+(void)downPic:(NSString*)url andTag:(int)_tag1 andPath:(NSString*)path andID:(int)ID andSelfView:(UIView*)selfView;

//检查是否有版本跟新
+(void)checkVersionUpdate:(int)AppId;
//获取跟新的内容
+(NSString*)gainUpdateNotes:(NSDictionary*)results;
//获取当前版本
+(float)gainCurrentVersion:(NSDictionary*)results;
//获取更新的版本
+(float)gainUpdateVersion:(NSDictionary*)results;

//雅虎天气的请求方法 异步请求
+(void)YahooWeatherRequest:(int)w  andU:(NSString*)u andDeleget:(id<NSURLConnectionDataDelegate>)delegate;
//异步请求的方法
+(void)YiBuRequestandMethod:(NSString*)method andDomain:( NSMutableString*)domain andHttpMethod:(NSString*)POSTorGET  andArgument:(NSDictionary*)argument andDelegate:(id<NSURLConnectionDataDelegate>)delegate;
//图片动画旋转
+(UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView;

@end
