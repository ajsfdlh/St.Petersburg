//
//  AppDelegate.m
//  St.Petersburg
//
//  Created by 刘 吕琴 on 14-2-8.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "AppDelegate.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "GDataXMLNode.h"
#import "OrderViewController.h"

@implementation AppDelegate
{

    NSString *QuseID;
}
- (void) applicationDidFinishLaunching:(UIApplication *)application
{


}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [[OrderViewController sharedOrderViewController] parse:url application:application];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [NSThread sleepForTimeInterval:2];
    self.isTime=NO;
    
    //在线咨询
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults valueForKey:USER_NAME]) {
        // name = [defaults valueForKey:@"useName"];
        //QuseID = [defaults valueForKey:@"QuseID"];
        //如果账号登陆就访问接口
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(numberGo) userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(numberGo) userInfo:nil repeats:YES];
        // NSLog(@"useName%@,QuseID%@",name,QuseID);
    }

    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"switch", nil];
    [defaults registerDefaults:dic];
    
     HomeViewController*naV11=[HomeViewController new];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
    nav1.viewControllers=[NSArray arrayWithObject:naV11];
    
  
    
    
    ToolViewController*naV22=[[ToolViewController alloc]init];
    UINavigationController *nav2= [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
    nav2.viewControllers=[NSArray arrayWithObject:naV22];
    
//    NeighboViewController*naV33=[[NeighboViewController alloc]init];
//    UINavigationController *nav3 = [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
//    nav3.viewControllers=[NSArray arrayWithObject:naV33];
    
   UINavigationController *nav4 = [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
    
    


    
    
    NSLog(@"%d",[defaults integerForKey:@"QuseID"]);

        MineViewController*naV44=[[MineViewController alloc]init];
        
        nav4.viewControllers=[NSArray arrayWithObject:naV44];
    

    
    MoreViewController*naV55=[[MoreViewController alloc]init];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithNavigationBarClass:[Navbar class] toolbarClass:nil];
    nav5.viewControllers=[NSArray arrayWithObject:naV55];
    
    
   
    NSArray*array=[NSArray arrayWithObjects:nav1,nav2,nav4,nav5, nil];
    
    MainTabarController*main=[MainTabarController new];
    main.buttonImageArray=[NSArray arrayWithObjects:@"_home_1.png",@"tool_1.png",@"neighbo_1.png",@"mine_1.png",@"more_1.png", nil];
    main.highbuttonImageArray=[NSArray arrayWithObjects:@"home_h_1.png",@"tool_h_1.png",@"neighbo_h_1.png",@"mine_h_1.png",@"more_h_1.png", nil];
    main.viewControllers=array;
   
    
    self.window.rootViewController=main;
    
     [ShareSDK registerApp:@"15ca382f35f9"];
    
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"3201194191"
                               appSecret:@"0334252914651e8f76bad63337b3b78f"
                             redirectUri:@"http://appgo.cn"];
    
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
                                redirectUri:@"http://www.sharesdk.cn"];
    
    //添加QQ空间应用
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"];
    
    //添加网易微博应用
    [ShareSDK connect163WeiboWithAppKey:@"T5EI7BXe13vfyDuy"
                              appSecret:@"gZxwyNOvjFYpxwwlnuizHRRtBRZ2lV1j"
                            redirectUri:@"http://www.shareSDK.cn"];
    
    //添加搜狐微博应用
    [ShareSDK connectSohuWeiboWithConsumerKey:@"SAfmTG1blxZY3HztESWx"
                               consumerSecret:@"yfTZf)!rVwh*3dqQuVJVsUL37!F)!yS9S!Orcsij"
                                  redirectUri:@"http://www.sharesdk.cn"];
    
    //添加豆瓣应用
    [ShareSDK connectDoubanWithAppKey:@"07d08fbfc1210e931771af3f43632bb9"
                            appSecret:@"e32896161e72be91"
                          redirectUri:@"http://dev.kumoway.com/braininference/infos.php"];
    
    //添加人人网应用
    [ShareSDK connectRenRenWithAppKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                            appSecret:@"f29df781abdd4f49beca5a2194676ca4"];
    
    //添加开心网应用
    [ShareSDK connectKaiXinWithAppKey:@"358443394194887cee81ff5890870c7c"
                            appSecret:@"da32179d859c016169f66d90b6db2a23"
                          redirectUri:@"http://www.sharesdk.cn/"];
    
    //添加Instapaper应用
    [ShareSDK connectInstapaperWithAppKey:@"4rDJORmcOcSAZL1YpqGHRI605xUvrLbOhkJ07yO0wWrYrc61FA"
                                appSecret:@"GNr1GespOQbrm8nvd7rlUsyRQsIo3boIbMguAl9gfpdL0aKZWe"];
    
    //添加有道云笔记应用
    [ShareSDK connectYouDaoNoteWithConsumerKey:@"dcde25dca105bcc36884ed4534dab940"
                                consumerSecret:@"d98217b4020e7f1874263795f44838fe"
                                   redirectUri:@"http://www.sharesdk.cn/"];
    
    //添加Facebook应用
    [ShareSDK connectFacebookWithAppKey:@"107704292745179"
                              appSecret:@"38053202e1a5fe26c80c753071f0b573"];
    
    //添加Twitter应用
    [ShareSDK connectTwitterWithConsumerKey:@"mnTGqtXk0TYMXYTN7qUxg"
                             consumerSecret:@"ROkFqr8c3m1HXqS3rm3TJ0WkAJuwBOSaWhPbZ9Ojuc"
                                redirectUri:@"http://www.sharesdk.cn"];
    
    //添加搜狐随身看应用
    [ShareSDK connectSohuKanWithAppKey:@"e16680a815134504b746c86e08a19db0"
                             appSecret:@"b8eec53707c3976efc91614dd16ef81c"
                           redirectUri:@"http://sharesdk.cn"];
    
    //添加Pocket应用
    [ShareSDK connectPocketWithConsumerKey:@"11496-de7c8c5eb25b2c9fcdc2b627"
                               redirectUri:@"pocketapp1234"];
    
    //添加印象笔记应用
    [ShareSDK connectEvernoteWithType:SSEverNoteTypeSandbox
                          consumerKey:@"sharesdk-7807"
                       consumerSecret:@"d05bf86993836004"];
    
    //添加LinkedIn应用
    [ShareSDK connectLinkedInWithApiKey:@"ejo5ibkye3vo"
                              secretKey:@"cC7B2jpxITqPLZ5M"
                            redirectUri:@"http://sharesdk.cn"];
    
    
    //添加QQ应用
    [ShareSDK connectQQWithQZoneAppKey:@"101040988"                 //该参数填入申请的QQ AppId
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];

    

    self.window.backgroundColor = [UIColor whiteColor];
    
    _rea =[Reachability reachabilityWithHostName:@"www.baidu.com"];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
    [_rea startNotifier];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)netChange:(NSNotification*)sender
{
    
    
    
    
    Reachability*reach=[sender object];
    NSLog(@"current=====%d",[reach currentReachabilityStatus]);
    Data*_data=[Data shareNet];
    _data.rea =reach;
    if ([reach currentReachabilityStatus]==NotReachable)
    {
        //noNet.hidden=NO;

        //        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接失败，请检查手机网络状态" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //        [alert show];
    }
//    else
//    {
//        
//        noNet.hidden=YES;
//        
//    }
    
    
    
}

- (void)numberGo{
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID]) {
//        // NSLog(@"type_id == 0");
//        return;
//    }
    NSMutableString *urlStr = RussiaUrl3;
    [urlStr appendString:@"getUserMessageCount"];
    NSString *argumentStr = [NSString stringWithFormat:@"cityid=%@&userid=%d&typeid=%@",@"2",[[[NSUserDefaults standardUserDefaults] objectForKey:QUSE_ID] intValue],[[NSUserDefaults standardUserDefaults] objectForKey:TYPE_ID]];
    NSURL*url=[[NSURL alloc]initWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSData *data = [argumentStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    NSData *receive = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    GDataXMLDocument *document=[[GDataXMLDocument alloc] initWithData:receive options:0 error:nil];
    GDataXMLElement *e1=[document rootElement];
    NSString*result=[e1 stringValue];
    // NSLog(@"result%@",result);
    //[self performSelectorOnMainThread:@selector(postNumber:) withObject:result waitUntilDone:NO];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"number" object:result];
    
 
    
    

    
}
//-(void)postNetCondition
//{
//
//    NSLog(@"!!!!!!!!!!!");
//    Reachability*rea =[Reachability reachabilityWithHostName:@"www.baidu.com"];
//    [rea startNotifier];
//
//
//}


- (void)applicationWillResignActive:(UIApplication *)application
{
    
 
   
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
