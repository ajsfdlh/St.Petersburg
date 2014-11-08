//
//  MyTravelingDetailViewController.m
//  St.Petersburg
//
//  Created by li on 14-5-10.
//  Copyright (c) 2014年 Jiayi. All rights reserved.
//

#import "MyTravelingDetailViewController.h"

@interface MyTravelingDetailViewController ()

@end

@implementation MyTravelingDetailViewController
backButton
- (void)viewDidLoad
{
    [super viewDidLoad];
    wv = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    wv.scalesPageToFit=YES;
//    wv.userInteractionEnabled = YES;
    NSString *HTMLData=[NSString stringWithFormat:@"<div id='foo' style='line-height:1.5'><font size=8 line-height=25>%@</font></div>",_htmlStr];
    [wv loadHTMLString:HTMLData baseURL:nil];
    [self.view addSubview:wv];

//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
//    doubleTap.numberOfTouchesRequired = 2;
//    
//    [wv addGestureRecognizer:doubleTap];
}
-(void) doubleTap :(UITapGestureRecognizer*) sender
{
    NSLog(@"%@",sender.view);
    //  <Find HTML tag which was clicked by user>
    //  <If tag is IMG, then get image URL and start saving>
    int scrollPositionY = [[wv stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"] intValue];
    int scrollPositionX = [[wv stringByEvaluatingJavaScriptFromString:@"window.pageXOffset"] intValue];
    
    int displayWidth = [[wv stringByEvaluatingJavaScriptFromString:@"window.outerWidth"] intValue];
    CGFloat scale = wv.frame.size.width / displayWidth;
    
    CGPoint pt = [sender locationInView:wv];
    pt.x *= scale;
    pt.y *= scale;
    pt.x += scrollPositionX;
    pt.y += scrollPositionY;
    
    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", pt.x, pt.y];
     NSLog(@"js  %@",js);
    NSString * tagName = [wv stringByEvaluatingJavaScriptFromString:js];
    NSLog(@"tagName  %@",tagName);
    if ([tagName isEqualToString:@"IMG"]) {
        NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
        NSString *urlToSave = [wv stringByEvaluatingJavaScriptFromString:imgURL];
        NSLog(@"image url=%@", urlToSave);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
